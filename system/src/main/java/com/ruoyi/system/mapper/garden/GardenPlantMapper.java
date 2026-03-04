package com.ruoyi.system.mapper.garden;

import java.util.List;
import com.ruoyi.system.domain.garden.GardenPlant;

/**
 * 植物档案 数据层
 */
public interface GardenPlantMapper
{
    public GardenPlant selectPlantById(Long plantId);

    public List<GardenPlant> selectPlantList(GardenPlant plant);

    public int insertPlant(GardenPlant plant);

    public int updatePlant(GardenPlant plant);

    public int deletePlantById(Long plantId);

    public int deletePlantByIds(Long[] plantIds);
}

