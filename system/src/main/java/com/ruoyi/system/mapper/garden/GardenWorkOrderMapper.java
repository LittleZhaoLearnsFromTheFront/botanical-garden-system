package com.ruoyi.system.mapper.garden;

import java.util.List;
import com.ruoyi.system.domain.garden.GardenWorkOrder;

/**
 * 工单任务 数据层
 */
public interface GardenWorkOrderMapper
{
    public GardenWorkOrder selectWorkOrderById(Long workOrderId);

    public List<GardenWorkOrder> selectWorkOrderList(GardenWorkOrder workOrder);

    public int insertWorkOrder(GardenWorkOrder workOrder);

    public int updateWorkOrder(GardenWorkOrder workOrder);

    public int updateWorkOrderStatus(GardenWorkOrder workOrder);

    public int deleteWorkOrderById(Long workOrderId);

    public int deleteWorkOrderByIds(Long[] workOrderIds);
}

