package com.ruoyi.web.controller.garden;

import java.util.ArrayList;
import java.util.List;
import com.alibaba.fastjson2.JSONObject;
import javax.servlet.http.HttpServletResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.annotation.Anonymous;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.framework.ai.AiSystemClient;
import com.ruoyi.common.config.AiSystemProperties;
import com.ruoyi.system.domain.garden.GardenWorkOrder;
import com.ruoyi.system.service.garden.IGardenWorkOrderService;

/**
 * 工单任务
 */
@RestController
@RequestMapping("/garden/workOrder")
public class GardenWorkOrderController extends BaseController
{
    private static final Logger log = LoggerFactory.getLogger(GardenWorkOrderController.class);
    @Autowired
    private IGardenWorkOrderService workOrderService;

    @Autowired
    private AiSystemClient aiSystemClient;

    @PreAuthorize("@ss.hasPermi('garden:workOrder:list')")
    @GetMapping("/list")
    public TableDataInfo list(GardenWorkOrder workOrder)
    {
        startPage();
        List<GardenWorkOrder> list = workOrderService.selectWorkOrderList(workOrder);
        return getDataTable(list);
    }

    @Log(title = "工单任务", businessType = BusinessType.EXPORT)
    @PreAuthorize("@ss.hasPermi('garden:workOrder:export')")
    @PostMapping("/export")
    public void export(HttpServletResponse response, GardenWorkOrder workOrder)
    {
        List<GardenWorkOrder> list = workOrderService.selectWorkOrderList(workOrder);
        ExcelUtil<GardenWorkOrder> util = new ExcelUtil<GardenWorkOrder>(GardenWorkOrder.class);
        util.exportExcel(response, list, "工单任务");
    }

    @PreAuthorize("@ss.hasPermi('garden:workOrder:query')")
    @GetMapping(value = "/{workOrderId}")
    public AjaxResult getInfo(@PathVariable Long workOrderId)
    {
        return success(workOrderService.selectWorkOrderById(workOrderId));
    }

    @PreAuthorize("@ss.hasPermi('garden:workOrder:add')")
    @Log(title = "工单任务", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@Validated @RequestBody GardenWorkOrder workOrder)
    {
        workOrder.setPublisherId(getUserId());
        workOrder.setCreateBy(getUsername());
        return toAjax(workOrderService.insertWorkOrder(workOrder));
    }

    @PreAuthorize("@ss.hasPermi('garden:workOrder:edit')")
    @Log(title = "工单任务", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@Validated @RequestBody GardenWorkOrder workOrder)
    {
        workOrder.setUpdateBy(getUsername());
        return toAjax(workOrderService.updateWorkOrder(workOrder));
    }

    /**
     * 工单执行/状态变更（接单、完成、取消）
     */
    @PreAuthorize("@ss.hasPermi('garden:workOrder:execute')")
    @Log(title = "工单任务", businessType = BusinessType.UPDATE)
    @PutMapping("/status")
    public AjaxResult changeStatus(@RequestBody GardenWorkOrder workOrder)
    {
        GardenWorkOrder db = workOrderService.selectWorkOrderById(workOrder.getWorkOrderId());
        if (db == null)
        {
            return error("工单不存在");
        }
        Long currentUserId = getUserId();
        if (!SecurityUtils.isAdmin(currentUserId) && db.getExecutorId() != null && !db.getExecutorId().equals(currentUserId))
        {
            return error("仅执行人可操作该工单");
        }
        workOrder.setUpdateBy(getUsername());
        return toAjax(workOrderService.updateWorkOrderStatus(workOrder));
    }

    @PreAuthorize("@ss.hasPermi('garden:workOrder:remove')")
    @Log(title = "工单任务", businessType = BusinessType.DELETE)
    @DeleteMapping("/{workOrderIds}")
    public AjaxResult remove(@PathVariable Long[] workOrderIds)
    {
        return toAjax(workOrderService.deleteWorkOrderByIds(workOrderIds));
    }

    /**
     * 工单智能辅助（Java 中间层转发到 ai-system）。
     * 入参示例：{ "workOrderId": 1, "question": "帮我生成执行步骤" }
     */
    @PreAuthorize("@ss.hasPermi('garden:workOrder:query')")
    @PostMapping("/ai/assist")
    public AjaxResult aiAssist(@RequestBody JSONObject body)
    {
        Long workOrderId = body.getLong("workOrderId");
        String question = body.getString("question");
        if (workOrderId == null)
        {
            return error("workOrderId 不能为空");
        }
        GardenWorkOrder wo = workOrderService.selectWorkOrderById(workOrderId);
        if (wo == null)
        {
            return error("工单不存在");
        }

        String systemPrompt = buildWorkOrderSystemPrompt(wo);

        List<JSONObject> messages = new ArrayList<>();
        JSONObject sys = new JSONObject();
        sys.put("role", "SYSTEM");
        sys.put("content", systemPrompt);
        messages.add(sys);

        JSONObject user = new JSONObject();
        user.put("role", "USER");
        user.put("content", (question == null || question.trim().isEmpty()) ? "请根据工单信息给出执行建议与注意事项，并输出可执行的步骤清单。" : question);
        messages.add(user);

        String sessionTitle = "工单智能辅助-" + workOrderId;
        JSONObject raw = aiSystemClient.chat(String.valueOf(getUserId()), sessionTitle, messages);

        JSONObject result = new JSONObject();
        result.put("raw", raw);
        result.put("content", extractAiSystemContent(raw));
        return success(result);
    }

    /**
     * 供 ai-system 回调的内部接口：完成工单。
     * 当前版本不做鉴权校验（内部环境使用）。
     *
     * 入参示例：{ "workOrderId": 1, "resultDesc": "已按要求完成" }
     */
    @Anonymous
    @PostMapping("/ai/finish")
    public AjaxResult aiFinish(@RequestBody JSONObject body)
    {
        log.info("收到 AI 回调完成工单请求, body={}", body);

        Long workOrderId = body.getLong("workOrderId");
        String resultDesc = body.getString("resultDesc");
        if (workOrderId == null)
        {
            log.warn("AI 回调失败：workOrderId 为空");
            return error("workOrderId 不能为空");
        }
        GardenWorkOrder db = workOrderService.selectWorkOrderById(workOrderId);
        if (db == null)
        {
            log.warn("AI 回调失败：工单不存在，id={}", workOrderId);
            return error("工单不存在");
        }
        GardenWorkOrder upd = new GardenWorkOrder();
        upd.setWorkOrderId(workOrderId);
        upd.setStatus("2");
        if (resultDesc != null)
        {
            // 避免超过数据库字段长度
            String brief = resultDesc.length() > 1000 ? resultDesc.substring(0, 1000) : resultDesc;
            upd.setResultDesc(brief);
        }
        upd.setUpdateBy("ai-system");
        int rows = workOrderService.updateWorkOrderStatus(upd);
        log.info("AI 回调完成工单成功, workOrderId={}, rows={}", workOrderId, rows);
        return toAjax(rows);
    }

    /**
     * 供 ai-system 回调的内部接口：接单工单（状态改为执行中）。
     */
    @Anonymous
    @PostMapping("/ai/accept")
    public AjaxResult aiAccept(@RequestBody JSONObject body)
    {
        log.info("收到 AI 回调接单工单请求, body={}", body);

        Long workOrderId = body.getLong("workOrderId");
        if (workOrderId == null)
        {
            log.warn("AI 回调接单失败：workOrderId 为空");
            return error("workOrderId 不能为空");
        }
        GardenWorkOrder db = workOrderService.selectWorkOrderById(workOrderId);
        if (db == null)
        {
            log.warn("AI 回调接单失败：工单不存在，id={}", workOrderId);
            return error("工单不存在");
        }
        GardenWorkOrder upd = new GardenWorkOrder();
        upd.setWorkOrderId(workOrderId);
        upd.setStatus("1");
        upd.setUpdateBy("ai-system");
        int rows = workOrderService.updateWorkOrderStatus(upd);
        log.info("AI 回调接单工单成功, workOrderId={}, rows={}", workOrderId, rows);
        return toAjax(rows);
    }

    /**
     * 供 ai-system 回调的内部接口：取消工单（状态改为已取消）。
     */
    @Anonymous
    @PostMapping("/ai/cancel")
    public AjaxResult aiCancel(@RequestBody JSONObject body)
    {
        log.info("收到 AI 回调取消工单请求, body={}", body);

        Long workOrderId = body.getLong("workOrderId");
        String reason = body.getString("reason");
        if (workOrderId == null)
        {
            log.warn("AI 回调取消失败：workOrderId 为空");
            return error("workOrderId 不能为空");
        }
        GardenWorkOrder db = workOrderService.selectWorkOrderById(workOrderId);
        if (db == null)
        {
            log.warn("AI 回调取消失败：工单不存在，id={}", workOrderId);
            return error("工单不存在");
        }
        GardenWorkOrder upd = new GardenWorkOrder();
        upd.setWorkOrderId(workOrderId);
        upd.setStatus("3");
        if (reason != null)
        {
            String brief = reason.length() > 1000 ? reason.substring(0, 1000) : reason;
            upd.setResultDesc(brief);
        }
        upd.setUpdateBy("ai-system");
        int rows = workOrderService.updateWorkOrderStatus(upd);
        log.info("AI 回调取消工单成功, workOrderId={}, rows={}", workOrderId, rows);
        return toAjax(rows);
    }

    private static String extractAiSystemContent(JSONObject raw)
    {
        if (raw == null)
        {
            return "";
        }
        Boolean ok = raw.getBoolean("success");
        if (ok != null && !ok.booleanValue())
        {
            String msg = raw.getString("message");
            return msg == null ? "" : msg;
        }
        JSONObject data = raw.getJSONObject("data");
        if (data == null)
        {
            return "";
        }
        String content = data.getString("content");
        return content == null ? "" : content;
    }

    private static String buildWorkOrderSystemPrompt(GardenWorkOrder wo)
    {
        StringBuilder sb = new StringBuilder();
        sb.append("你是园林管理系统的工单智能助手。");
        sb.append("请基于提供的工单信息，给出专业、可落地的建议。");
        sb.append("输出要结构化（分点/步骤），并明确风险与注意事项。");
        sb.append("\n\n");
        sb.append("【工单信息】\n");
        sb.append("工单ID：").append(wo.getWorkOrderId() == null ? "-" : wo.getWorkOrderId()).append("\n");
        sb.append("标题：").append(nullToDash(wo.getTitle())).append("\n");
        sb.append("任务类型：").append(taskTypeLabel(wo.getTaskType())).append("\n");
        sb.append("目标类型：").append(targetTypeLabel(wo.getTargetType())).append("\n");
        sb.append("内容：").append(nullToDash(wo.getContent())).append("\n");
        sb.append("优先级：").append(priorityLabel(wo.getPriority())).append("\n");
        sb.append("计划时间：").append(wo.getPlanTime() == null ? "-" : wo.getPlanTime()).append("\n");
        sb.append("截止时间：").append(wo.getDeadline() == null ? "-" : wo.getDeadline()).append("\n");
        sb.append("状态：").append(statusLabel(wo.getStatus())).append("\n");
        sb.append("执行人：").append(nullToDash(wo.getExecutorName())).append("\n");
        sb.append("目标名称：").append(firstNonBlank(wo.getAreaName(), wo.getPlantName(), wo.getDeviceName())).append("\n");
        return sb.toString();
    }

    private static String taskTypeLabel(String code)
    {
        if (code == null)
        {
            return "-";
        }
        switch (code)
        {
            case "CLEANING":
                return "区域清理";
            case "PATROL":
                return "巡查";
            case "WATERING":
                return "浇水";
            case "PRUNING":
                return "修剪";
            case "FERTILIZE":
                return "施肥";
            case "PEST_CONTROL":
                return "病虫害处理";
            case "INSPECTION":
                return "设备巡检";
            case "MAINTAIN":
                return "维护保养";
            case "REPAIR":
                return "维修";
            case "OTHER":
                return "其他";
            default:
                return code;
        }
    }

    private static String targetTypeLabel(String code)
    {
        if (code == null)
        {
            return "-";
        }
        if ("0".equals(code))
        {
            return "区域";
        }
        if ("1".equals(code))
        {
            return "植物";
        }
        if ("2".equals(code))
        {
            return "设备";
        }
        return code;
    }

    private static String priorityLabel(String code)
    {
        if (code == null)
        {
            return "-";
        }
        if ("0".equals(code))
        {
            return "低";
        }
        if ("1".equals(code))
        {
            return "中";
        }
        if ("2".equals(code))
        {
            return "高";
        }
        return code;
    }

    private static String statusLabel(String code)
    {
        if (code == null)
        {
            return "-";
        }
        if ("0".equals(code))
        {
            return "待执行";
        }
        if ("1".equals(code))
        {
            return "执行中";
        }
        if ("2".equals(code))
        {
            return "已完成";
        }
        if ("3".equals(code))
        {
            return "已取消";
        }
        return code;
    }

    private static String nullToDash(String v)
    {
        return (v == null || v.trim().isEmpty()) ? "-" : v;
    }

    private static String firstNonBlank(String a, String b, String c)
    {
        if (a != null && a.trim().length() > 0) return a;
        if (b != null && b.trim().length() > 0) return b;
        if (c != null && c.trim().length() > 0) return c;
        return "-";
    }
}

