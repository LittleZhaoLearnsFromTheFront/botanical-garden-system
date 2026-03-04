package com.ruoyi.system.service.garden.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.domain.garden.GardenPlantLog;
import com.ruoyi.system.mapper.garden.GardenPlantLogMapper;
import com.ruoyi.system.service.garden.IGardenPlantLogService;

@Service
public class GardenPlantLogServiceImpl implements IGardenPlantLogService
{
    @Autowired
    private GardenPlantLogMapper plantLogMapper;

    @Override
    public List<GardenPlantLog> selectPlantLogList(GardenPlantLog log)
    {
        return plantLogMapper.selectPlantLogList(log);
    }

    @Override
    public int insertPlantLog(GardenPlantLog log)
    {
        return plantLogMapper.insertPlantLog(log);
    }
}

