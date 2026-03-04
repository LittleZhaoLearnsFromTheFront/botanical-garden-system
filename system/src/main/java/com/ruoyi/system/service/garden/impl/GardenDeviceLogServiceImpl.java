package com.ruoyi.system.service.garden.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.domain.garden.GardenDeviceLog;
import com.ruoyi.system.mapper.garden.GardenDeviceLogMapper;
import com.ruoyi.system.service.garden.IGardenDeviceLogService;

@Service
public class GardenDeviceLogServiceImpl implements IGardenDeviceLogService
{
    @Autowired
    private GardenDeviceLogMapper deviceLogMapper;

    @Override
    public List<GardenDeviceLog> selectDeviceLogList(GardenDeviceLog log)
    {
        return deviceLogMapper.selectDeviceLogList(log);
    }

    @Override
    public int insertDeviceLog(GardenDeviceLog log)
    {
        return deviceLogMapper.insertDeviceLog(log);
    }
}

