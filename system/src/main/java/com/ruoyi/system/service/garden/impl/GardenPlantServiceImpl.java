package com.ruoyi.system.service.garden.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.domain.garden.GardenPlant;
import com.ruoyi.system.mapper.garden.GardenPlantMapper;
import com.ruoyi.system.service.garden.IGardenPlantService;

/**
 * 植物档案 服务实现
 */
@Service
public class GardenPlantServiceImpl implements IGardenPlantService
{
    @Autowired
    private GardenPlantMapper plantMapper;

    @Override
    public GardenPlant selectPlantById(Long plantId)
    {
        return plantMapper.selectPlantById(plantId);
    }

    @Override
    public List<GardenPlant> selectPlantList(GardenPlant plant)
    {
        return plantMapper.selectPlantList(plant);
    }

    @Override
    public int insertPlant(GardenPlant plant)
    {
        return plantMapper.insertPlant(plant);
    }

    @Override
    public int updatePlant(GardenPlant plant)
    {
        return plantMapper.updatePlant(plant);
    }

    @Override
    public int deletePlantByIds(Long[] plantIds)
    {
        return plantMapper.deletePlantByIds(plantIds);
    }

    @Override
    public int deletePlantById(Long plantId)
    {
        return plantMapper.deletePlantById(plantId);
    }
}

