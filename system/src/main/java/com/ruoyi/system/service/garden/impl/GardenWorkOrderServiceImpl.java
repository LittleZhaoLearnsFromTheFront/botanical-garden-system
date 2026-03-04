package com.ruoyi.system.service.garden.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.system.domain.garden.GardenAreaLog;
import com.ruoyi.system.domain.garden.GardenDeviceLog;
import com.ruoyi.system.domain.garden.GardenPlantLog;
import com.ruoyi.system.domain.garden.GardenWorkOrder;
import com.ruoyi.system.mapper.garden.GardenWorkOrderMapper;
import com.ruoyi.system.service.garden.IGardenAreaLogService;
import com.ruoyi.system.service.garden.IGardenDeviceLogService;
import com.ruoyi.system.service.garden.IGardenPlantLogService;
import com.ruoyi.system.service.garden.IGardenWorkOrderService;

/**
 * 工单任务 服务实现
 */
@Service
public class GardenWorkOrderServiceImpl implements IGardenWorkOrderService
{
    @Autowired
    private GardenWorkOrderMapper workOrderMapper;

    @Autowired
    private IGardenAreaLogService areaLogService;

    @Autowired
    private IGardenPlantLogService plantLogService;

    @Autowired
    private IGardenDeviceLogService deviceLogService;

    @Override
    public GardenWorkOrder selectWorkOrderById(Long workOrderId)
    {
        return workOrderMapper.selectWorkOrderById(workOrderId);
    }

    @Override
    public List<GardenWorkOrder> selectWorkOrderList(GardenWorkOrder workOrder)
    {
        return workOrderMapper.selectWorkOrderList(workOrder);
    }

    @Override
    public int insertWorkOrder(GardenWorkOrder workOrder)
    {
        if (StringUtils.isEmpty(workOrder.getStatus()))
        {
            workOrder.setStatus("0");
        }
        return workOrderMapper.insertWorkOrder(workOrder);
    }

    @Override
    public int updateWorkOrder(GardenWorkOrder workOrder)
    {
        return workOrderMapper.updateWorkOrder(workOrder);
    }

    @Override
    public int updateWorkOrderStatus(GardenWorkOrder workOrder)
    {
        GardenWorkOrder db = workOrderMapper.selectWorkOrderById(workOrder.getWorkOrderId());
        if (db == null)
        {
            throw new ServiceException("工单不存在");
        }
        if (StringUtils.equalsAny(db.getStatus(), "2", "3"))
        {
            throw new ServiceException("工单已结束，无法继续操作");
        }
        if (db.getExecutorId() == null)
        {
            throw new ServiceException("工单未指定执行人，无法执行");
        }

        String newStatus = workOrder.getStatus();
        if (StringUtils.isEmpty(newStatus))
        {
            throw new ServiceException("状态不能为空");
        }

        if (StringUtils.equals("1", newStatus))
        {
            if (!StringUtils.equals("0", db.getStatus()))
            {
                throw new ServiceException("仅待执行工单可接单");
            }
            workOrder.setAcceptTime(DateUtils.getNowDate());
        }
        else if (StringUtils.equals("2", newStatus))
        {
            if (!StringUtils.equals("1", db.getStatus()))
            {
                throw new ServiceException("仅执行中的工单可完成");
            }
            workOrder.setFinishTime(DateUtils.getNowDate());

            // 生成维护日志
            if (StringUtils.equals("0", db.getTargetType()) && db.getAreaId() != null)
            {
                GardenAreaLog log = new GardenAreaLog();
                log.setWorkOrderId(db.getWorkOrderId());
                log.setAreaId(db.getAreaId());
                log.setExecutorId(db.getExecutorId());
                log.setExecutorName(db.getExecutorName());
                log.setTaskType(db.getTaskType());
                log.setTitle(db.getTitle());
                log.setContent(db.getContent());
                log.setResultDesc(workOrder.getResultDesc());
                log.setStartTime(db.getAcceptTime());
                log.setFinishTime(workOrder.getFinishTime());
                log.setCreateTime(DateUtils.getNowDate());
                areaLogService.insertAreaLog(log);
            }
            else if (StringUtils.equals("1", db.getTargetType()) && db.getPlantId() != null)
            {
                GardenPlantLog log = new GardenPlantLog();
                log.setWorkOrderId(db.getWorkOrderId());
                log.setPlantId(db.getPlantId());
                log.setExecutorId(db.getExecutorId());
                log.setExecutorName(db.getExecutorName());
                log.setTaskType(db.getTaskType());
                log.setTitle(db.getTitle());
                log.setContent(db.getContent());
                log.setResultDesc(workOrder.getResultDesc());
                log.setStartTime(db.getAcceptTime());
                log.setFinishTime(workOrder.getFinishTime());
                log.setCreateTime(DateUtils.getNowDate());
                plantLogService.insertPlantLog(log);
            }
            else if (StringUtils.equals("2", db.getTargetType()) && db.getDeviceId() != null)
            {
                GardenDeviceLog log = new GardenDeviceLog();
                log.setWorkOrderId(db.getWorkOrderId());
                log.setDeviceId(db.getDeviceId());
                log.setExecutorId(db.getExecutorId());
                log.setExecutorName(db.getExecutorName());
                log.setTaskType(db.getTaskType());
                log.setTitle(db.getTitle());
                log.setContent(db.getContent());
                log.setResultDesc(workOrder.getResultDesc());
                log.setStartTime(db.getAcceptTime());
                log.setFinishTime(workOrder.getFinishTime());
                log.setCreateTime(DateUtils.getNowDate());
                deviceLogService.insertDeviceLog(log);
            }
        }
        else if (StringUtils.equals("3", newStatus))
        {
            if (!StringUtils.equalsAny(db.getStatus(), "0", "1"))
            {
                throw new ServiceException("当前工单状态不允许取消");
            }
        }
        else if (!StringUtils.equals("0", newStatus))
        {
            throw new ServiceException("非法状态值");
        }

        return workOrderMapper.updateWorkOrderStatus(workOrder);
    }

    @Override
    public int deleteWorkOrderByIds(Long[] workOrderIds)
    {
        return workOrderMapper.deleteWorkOrderByIds(workOrderIds);
    }

    @Override
    public int deleteWorkOrderById(Long workOrderId)
    {
        return workOrderMapper.deleteWorkOrderById(workOrderId);
    }
}

