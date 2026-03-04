package com.ruoyi.system.service.garden;

import java.util.List;
import com.ruoyi.system.domain.garden.GardenPlant;

/**
 * 植物档案 服务层
 */
public interface IGardenPlantService
{
    public GardenPlant selectPlantById(Long plantId);

    public List<GardenPlant> selectPlantList(GardenPlant plant);

    public int insertPlant(GardenPlant plant);

    public int updatePlant(GardenPlant plant);

    public int deletePlantByIds(Long[] plantIds);

    public int deletePlantById(Long plantId);
}

