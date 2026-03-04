package com.ruoyi.system.service.garden.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.domain.garden.GardenAreaLog;
import com.ruoyi.system.mapper.garden.GardenAreaLogMapper;
import com.ruoyi.system.service.garden.IGardenAreaLogService;

@Service
public class GardenAreaLogServiceImpl implements IGardenAreaLogService
{
    @Autowired
    private GardenAreaLogMapper areaLogMapper;

    @Override
    public List<GardenAreaLog> selectAreaLogList(GardenAreaLog log)
    {
        return areaLogMapper.selectAreaLogList(log);
    }

    @Override
    public int insertAreaLog(GardenAreaLog log)
    {
        return areaLogMapper.insertAreaLog(log);
    }
}

