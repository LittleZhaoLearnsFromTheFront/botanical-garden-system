package com.ruoyi.system.service.garden;

import java.util.List;
import com.ruoyi.system.domain.garden.GardenWorkOrder;

/**
 * 工单任务 服务层
 */
public interface IGardenWorkOrderService
{
    public GardenWorkOrder selectWorkOrderById(Long workOrderId);

    public List<GardenWorkOrder> selectWorkOrderList(GardenWorkOrder workOrder);

    public int insertWorkOrder(GardenWorkOrder workOrder);

    public int updateWorkOrder(GardenWorkOrder workOrder);

    public int updateWorkOrderStatus(GardenWorkOrder workOrder);

    public int deleteWorkOrderByIds(Long[] workOrderIds);

    public int deleteWorkOrderById(Long workOrderId);
}

