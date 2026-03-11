package com.ruoyi.web.controller.garden;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.JSONArray;
import com.alibaba.fastjson2.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.framework.ai.AiSystemClient;
import com.ruoyi.system.domain.garden.GardenCareAdvice;
import com.ruoyi.system.domain.garden.GardenPlant;
import com.ruoyi.system.domain.garden.GardenPlantLog;
import com.ruoyi.system.domain.garden.GardenWorkOrder;
import com.ruoyi.system.service.garden.IGardenCareAdviceService;
import com.ruoyi.system.service.garden.IGardenPlantLogService;
import com.ruoyi.system.service.garden.IGardenPlantService;
import com.ruoyi.system.service.garden.IGardenWorkOrderService;

/**
 * 智能养护建议
 */
@RestController
@RequestMapping("/garden/careAdvice")
public class GardenCareAdviceController extends BaseController
{
    @Autowired
    private IGardenCareAdviceService careAdviceService;

    @Autowired
    private IGardenPlantService plantService;

    @Autowired
    private IGardenPlantLogService plantLogService;

    @Autowired
    private IGardenWorkOrderService workOrderService;

    @Autowired
    private AiSystemClient aiSystemClient;

    @PreAuthorize("@ss.hasPermi('garden:careAdvice:list')")
    @GetMapping("/list")
    public TableDataInfo list(GardenCareAdvice advice)
    {
        startPage();
        List<GardenCareAdvice> list = careAdviceService.selectCareAdviceList(advice);
        return getDataTable(list);
    }

    @PreAuthorize("@ss.hasPermi('garden:careAdvice:query')")
    @GetMapping(value = "/{adviceId}")
    public AjaxResult getInfo(@PathVariable Long adviceId)
    {
        return success(careAdviceService.selectCareAdviceById(adviceId));
    }

    @PreAuthorize("@ss.hasPermi('garden:careAdvice:query')")
    @GetMapping("/latest")
    public AjaxResult latest(String targetType, Long targetId)
    {
        if (StringUtils.isEmpty(targetType) || targetId == null)
        {
            return error("targetType/targetId 不能为空");
        }
        return success(careAdviceService.selectLatestPublishedByTarget(targetType, targetId));
    }

    /**
     * 生成养护建议（MVP：植物）
     * 入参示例：{ "plantId": 1, "focus": "我更关心浇水与病虫害" }
     */
    @PreAuthorize("@ss.hasPermi('garden:careAdvice:generate')")
    @Log(title = "智能养护建议", businessType = BusinessType.INSERT)
    @PostMapping("/generate")
    public AjaxResult generate(@RequestBody JSONObject body)
    {
        Long plantId = body.getLong("plantId");
        String focus = body.getString("focus");
        if (plantId == null)
        {
            return error("plantId 不能为空");
        }

        GardenPlant plant = plantService.selectPlantById(plantId);
        if (plant == null)
        {
            return error("植物不存在");
        }

        List<GardenPlantLog> logs = getRecentPlantLogs(plantId, 10);
        List<GardenWorkOrder> openOrders = getOpenPlantWorkOrders(plantId, 20);

        JSONObject evidence = buildEvidence(plant, logs, openOrders);
        String systemPrompt = buildPlantCareSystemPrompt(plant, logs, openOrders);
        String userPrompt = buildPlantCareUserPrompt(focus);

        List<JSONObject> messages = new ArrayList<>();
        JSONObject sys = new JSONObject();
        sys.put("role", "SYSTEM");
        sys.put("content", systemPrompt);
        messages.add(sys);

        JSONObject user = new JSONObject();
        user.put("role", "USER");
        user.put("content", userPrompt);
        messages.add(user);

        // 养护建议生成不需要工单动作识别，避免误触发 Java 回调
        JSONObject raw = aiSystemClient.chat(String.valueOf(getUserId()), "智能养护建议-植物-" + plantId, messages, false);
        String content = extractAiSystemContent(raw);

        JSONObject parsed = tryParseAdviceJson(content);
        String contentJson = parsed == null ? null : parsed.toJSONString();
        String contentMd = parsed == null ? content : (parsed.getString("content_md") == null ? content : parsed.getString("content_md"));

        GardenCareAdvice advice = new GardenCareAdvice();
        advice.setTargetType("PLANT");
        advice.setTargetId(plantId);
        advice.setAdviceType("ROUTINE");
        advice.setTitle(buildAdviceTitle(plant));
        advice.setContentMd(contentMd);
        advice.setContentJson(contentJson);
        advice.setEvidenceJson(evidence.toJSONString());
        advice.setRiskLevel(guessRiskLevel(parsed, plant));
        advice.setConfidence(parsed == null ? null : parsed.getInteger("confidence"));
        advice.setStatus("1"); // 待审核
        advice.setCreateBy(getUsername());
        advice.setValidFrom(new Date());
        careAdviceService.insertCareAdvice(advice);

        JSONObject result = new JSONObject();
        result.put("adviceId", advice.getAdviceId());
        result.put("content", contentMd);
        result.put("raw", raw);
        result.put("parsed", parsed);
        return success(result);
    }

    /**
     * 审核（通过/驳回）
     * 入参示例：{ "adviceId": 1, "approve": true, "reviewNote": "同意发布" }
     */
    @PreAuthorize("@ss.hasPermi('garden:careAdvice:review')")
    @Log(title = "智能养护建议审核", businessType = BusinessType.UPDATE)
    @PostMapping("/review")
    public AjaxResult review(@RequestBody JSONObject body)
    {
        Long adviceId = body.getLong("adviceId");
        Boolean approve = body.getBoolean("approve");
        String reviewNote = body.getString("reviewNote");
        if (adviceId == null || approve == null)
        {
            return error("adviceId/approve 不能为空");
        }
        GardenCareAdvice db = careAdviceService.selectCareAdviceById(adviceId);
        if (db == null)
        {
            return error("建议不存在");
        }

        GardenCareAdvice upd = new GardenCareAdvice();
        upd.setAdviceId(adviceId);
        upd.setReviewBy(getUsername());
        upd.setReviewTime(new Date());
        upd.setReviewNote(reviewNote);
        upd.setUpdateBy(getUsername());
        upd.setStatus(Boolean.TRUE.equals(approve) ? "2" : "3");
        return toAjax(careAdviceService.updateCareAdvice(upd));
    }

    /**
     * 一键转工单（按建议内容生成一个工单草稿）
     * 入参示例：{ "adviceId": 1, "priority": "1", "deadline": "2026-03-11 18:00:00" }
     */
    @PreAuthorize("@ss.hasPermi('garden:careAdvice:toWorkOrder')")
    @Log(title = "养护建议转工单", businessType = BusinessType.INSERT)
    @PostMapping("/toWorkOrder")
    public AjaxResult toWorkOrder(@RequestBody JSONObject body)
    {
        Long adviceId = body.getLong("adviceId");
        if (adviceId == null)
        {
            return error("adviceId 不能为空");
        }
        Long executorId = body.getLong("executorId");
        String planTimeStr = body.getString("planTime");
        String deadlineStr = body.getString("deadline");
        if (executorId == null)
        {
            return error("executorId 不能为空");
        }
        if (StringUtils.isEmpty(planTimeStr))
        {
            return error("planTime 不能为空");
        }
        if (StringUtils.isEmpty(deadlineStr))
        {
            return error("deadline 不能为空");
        }
        Date planTime = DateUtils.parseDate(planTimeStr);
        Date deadline = DateUtils.parseDate(deadlineStr);
        if (planTime == null)
        {
            return error("planTime 格式错误");
        }
        if (deadline == null)
        {
            return error("deadline 格式错误");
        }

        GardenCareAdvice advice = careAdviceService.selectCareAdviceById(adviceId);
        if (advice == null)
        {
            return error("建议不存在");
        }
        // 每条建议只允许转一次工单
        if (advice.getLinkedWorkOrderId() != null)
        {
            return error("该建议已转过工单（工单ID：" + advice.getLinkedWorkOrderId() + "）");
        }
        // 只允许已通过的建议转工单
        if (!"2".equals(advice.getStatus()))
        {
            return error("当前建议未通过审核，无法转工单，请先审核通过");
        }
        if (!"PLANT".equalsIgnoreCase(advice.getTargetType()))
        {
            return error("当前版本仅支持植物建议转工单");
        }

        GardenPlant plant = plantService.selectPlantById(advice.getTargetId());
        if (plant == null)
        {
            return error("植物不存在");
        }

        GardenWorkOrder wo = new GardenWorkOrder();
        wo.setTitle("养护建议执行-" + safe(plant.getPlantName()));
        wo.setTargetType("1");
        wo.setPlantId(plant.getPlantId());
        wo.setAreaId(plant.getAreaId());
        wo.setTaskType(guessTaskTypeFromAdvice(advice));
        wo.setContent(buildWorkOrderContentFromAdvice(advice));
        wo.setPriority(body.getString("priority") == null ? "1" : body.getString("priority"));
        wo.setExecutorId(executorId);
        wo.setPlanTime(planTime);
        wo.setDeadline(deadline);
        wo.setStatus("0");
        wo.setPublisherId(getUserId());
        wo.setCreateBy(getUsername());

        int rows = workOrderService.insertWorkOrder(wo);
        if (rows > 0 && wo.getWorkOrderId() != null)
        {
            GardenCareAdvice upd = new GardenCareAdvice();
            upd.setAdviceId(adviceId);
            upd.setLinkedWorkOrderId(wo.getWorkOrderId());
            upd.setUpdateBy(getUsername());
            careAdviceService.updateCareAdvice(upd);
        }
        JSONObject data = new JSONObject();
        data.put("workOrderId", wo.getWorkOrderId());
        return success(data);
    }

    private List<GardenPlantLog> getRecentPlantLogs(Long plantId, int limit)
    {
        GardenPlantLog q = new GardenPlantLog();
        q.setPlantId(plantId);
        List<GardenPlantLog> list = plantLogService.selectPlantLogList(q);
        if (list == null || list.isEmpty())
        {
            return new ArrayList<>();
        }
        if (list.size() <= limit)
        {
            return list;
        }
        return list.subList(0, limit);
    }

    private List<GardenWorkOrder> getOpenPlantWorkOrders(Long plantId, int limit)
    {
        GardenWorkOrder q = new GardenWorkOrder();
        q.setTargetType("1");
        q.setPlantId(plantId);
        // 不筛状态，让模型看到近期工单；MVP 先取最近 N 条
        List<GardenWorkOrder> list = workOrderService.selectWorkOrderList(q);
        if (list == null || list.isEmpty())
        {
            return new ArrayList<>();
        }
        if (list.size() <= limit)
        {
            return list;
        }
        return list.subList(0, limit);
    }

    private static JSONObject buildEvidence(GardenPlant plant, List<GardenPlantLog> logs, List<GardenWorkOrder> orders)
    {
        JSONObject e = new JSONObject();
        e.put("plant", JSON.parseObject(JSON.toJSONString(plant)));
        JSONArray logArr = new JSONArray();
        for (GardenPlantLog l : logs)
        {
            JSONObject o = new JSONObject();
            o.put("logId", l.getLogId());
            o.put("taskType", l.getTaskType());
            o.put("content", l.getContent());
            o.put("resultDesc", l.getResultDesc());
            o.put("finishTime", l.getFinishTime());
            logArr.add(o);
        }
        e.put("recentLogs", logArr);
        JSONArray ordArr = new JSONArray();
        for (GardenWorkOrder w : orders)
        {
            JSONObject o = new JSONObject();
            o.put("workOrderId", w.getWorkOrderId());
            o.put("taskType", w.getTaskType());
            o.put("status", w.getStatus());
            o.put("title", w.getTitle());
            o.put("deadline", w.getDeadline());
            ordArr.add(o);
        }
        e.put("recentWorkOrders", ordArr);
        return e;
    }

    private static String buildPlantCareSystemPrompt(GardenPlant plant, List<GardenPlantLog> logs, List<GardenWorkOrder> orders)
    {
        StringBuilder sb = new StringBuilder();
        sb.append("你是园林管理系统的智能养护建议助手。");
        sb.append("请基于给定的【事实信息】输出【可执行的养护建议】。");
        sb.append("必须专业、具体、可落地，避免空泛描述。");
        sb.append("\n\n");
        sb.append("【事实信息】\n");
        sb.append("目标类型：植物\n");
        sb.append("植物ID：").append(plant.getPlantId() == null ? "-" : plant.getPlantId()).append("\n");
        sb.append("植物名称：").append(safe(plant.getPlantName())).append("\n");
        sb.append("品种/学名：").append(safe(plant.getSpecies())).append("\n");
        sb.append("树龄(年)：").append(plant.getAgeYears() == null ? "-" : plant.getAgeYears()).append("\n");
        sb.append("高度(cm)：").append(plant.getHeightCm() == null ? "-" : plant.getHeightCm()).append("\n");
        sb.append("健康状态：").append(healthLabel(plant.getHealthStatus())).append("\n");
        sb.append("所属区域：").append(safe(plant.getAreaName())).append("\n");
        sb.append("\n");

        sb.append("【最近维护日志（最多10条，越靠前越新）】\n");
        if (logs == null || logs.isEmpty())
        {
            sb.append("无\n");
        }
        else
        {
            for (GardenPlantLog l : logs)
            {
                sb.append("- ").append(taskTypeLabel(l.getTaskType())).append("；内容：").append(oneLine(l.getContent()));
                if (StringUtils.isNotEmpty(l.getResultDesc()))
                {
                    sb.append("；结果：").append(oneLine(l.getResultDesc()));
                }
                if (l.getFinishTime() != null)
                {
                    sb.append("；完成时间：").append(l.getFinishTime());
                }
                sb.append("\n");
            }
        }
        sb.append("\n");

        sb.append("【最近工单（最多20条，越靠前越新）】\n");
        if (orders == null || orders.isEmpty())
        {
            sb.append("无\n");
        }
        else
        {
            for (GardenWorkOrder w : orders)
            {
                sb.append("- 工单ID：").append(w.getWorkOrderId()).append("；状态：").append(statusLabel(w.getStatus()))
                        .append("；任务：").append(taskTypeLabel(w.getTaskType()))
                        .append("；标题：").append(oneLine(w.getTitle()))
                        .append("\n");
            }
        }

        sb.append("\n");
        sb.append("【输出要求】\n");
        sb.append("1) 你需要同时输出两部分：content_md（给人阅读的 Markdown）与 structured（严格 JSON 结构化建议）。\n");
        sb.append("2) structured 必须包含：summary、risk_level(0/1/2)、confidence(0-100)、actions 数组；每个 action 包含 name、steps、frequency、materials、precautions、follow_up。\n");
        sb.append("3) 严格输出 JSON，不能输出解释性文字或多余字段。JSON 结构示例：\n");
        sb.append("{\"content_md\":\"...\",\"structured\":{\"summary\":\"...\",\"risk_level\":\"1\",\"confidence\":80,\"actions\":[{\"name\":\"浇水\",\"frequency\":\"每周2次\",\"steps\":[\"...\"],\"materials\":[\"...\"],\"precautions\":[\"...\"],\"follow_up\":\"3天后复查叶片\"}]}}");
        return sb.toString();
    }

    private static String buildPlantCareUserPrompt(String focus)
    {
        String base = "请为该植物生成未来 7-14 天的养护建议，强调可执行步骤、频次、用量范围（如果无法确定请给区间并说明依据），并指出需要升级处理/上报的风险信号。";
        if (StringUtils.isEmpty(focus))
        {
            return base;
        }
        return base + "\n额外关注点：" + focus;
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

    private static JSONObject tryParseAdviceJson(String content)
    {
        if (StringUtils.isEmpty(content))
        {
            return null;
        }
        String v = content.trim();
        try
        {
            return JSON.parseObject(v);
        }
        catch (Exception ignore)
        {
            // ai 有时会包在 ```json ``` 里，做一次简单剥离
            String vv = v.replace("```json", "").replace("```", "").trim();
            try
            {
                return JSON.parseObject(vv);
            }
            catch (Exception ignore2)
            {
                return null;
            }
        }
    }

    private static String buildAdviceTitle(GardenPlant plant)
    {
        String name = safe(plant.getPlantName());
        if (StringUtils.isEmpty(name))
        {
            name = "植物";
        }
        return "智能养护建议-" + name;
    }

    private static String guessRiskLevel(JSONObject parsed, GardenPlant plant)
    {
        if (parsed != null)
        {
            JSONObject structured = parsed.getJSONObject("structured");
            if (structured != null && StringUtils.isNotEmpty(structured.getString("risk_level")))
            {
                return structured.getString("risk_level");
            }
            if (StringUtils.isNotEmpty(parsed.getString("risk_level")))
            {
                return parsed.getString("risk_level");
            }
        }
        // fallback：根据健康状态简单估计
        if ("2".equals(plant.getHealthStatus()))
        {
            return "2";
        }
        if ("1".equals(plant.getHealthStatus()))
        {
            return "1";
        }
        return "0";
    }

    private static String guessTaskTypeFromAdvice(GardenCareAdvice advice)
    {
        // MVP：先默认 OTHER，避免影响现有字典/枚举；后续可从 structured.actions[0].name 映射
        return "OTHER";
    }

    private static String buildWorkOrderContentFromAdvice(GardenCareAdvice advice)
    {
        StringBuilder sb = new StringBuilder();
        sb.append("来源：智能养护建议#").append(advice.getAdviceId()).append("\n");
        if (StringUtils.isNotEmpty(advice.getTitle()))
        {
            sb.append("建议标题：").append(advice.getTitle()).append("\n");
        }
        if (StringUtils.isNotEmpty(advice.getContentMd()))
        {
            sb.append("建议内容：\n").append(advice.getContentMd());
        }
        else
        {
            sb.append("建议内容为空，请在建议详情中查看结构化内容。");
        }
        // garden_work_order.content 为 varchar(1000)，这里做截断保护，避免转工单失败
        String text = sb.toString();
        final int maxLen = 1000;
        if (text.length() <= maxLen)
        {
            return text;
        }
        String suffix = "\n（内容过长已截断，请到“智能养护建议”详情查看完整版）";
        int keep = maxLen - suffix.length();
        if (keep <= 0)
        {
            return text.substring(0, maxLen);
        }
        return text.substring(0, keep) + suffix;
    }

    private static String safe(String v)
    {
        return v == null ? "" : v;
    }

    private static String oneLine(String v)
    {
        if (v == null) return "";
        String s = v.replace("\r", " ").replace("\n", " ").trim();
        return s.length() > 300 ? s.substring(0, 300) + "..." : s;
    }

    private static String healthLabel(String code)
    {
        if (code == null) return "-";
        if ("0".equals(code)) return "良好";
        if ("1".equals(code)) return "一般";
        if ("2".equals(code)) return "较差";
        return code;
    }

    private static String statusLabel(String code)
    {
        if (code == null) return "-";
        if ("0".equals(code)) return "待执行";
        if ("1".equals(code)) return "执行中";
        if ("2".equals(code)) return "已完成";
        if ("3".equals(code)) return "已取消";
        return code;
    }

    private static String taskTypeLabel(String code)
    {
        if (code == null) return "-";
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
}

