package com.ruoyi.web.controller.garden;

import java.util.List;
import javax.servlet.http.HttpServletResponse;
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
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.system.domain.garden.GardenWorkOrder;
import com.ruoyi.system.service.garden.IGardenWorkOrderService;

/**
 * 工单任务
 */
@RestController
@RequestMapping("/garden/workOrder")
public class GardenWorkOrderController extends BaseController
{
    @Autowired
    private IGardenWorkOrderService workOrderService;

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
}

