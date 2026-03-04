package com.ruoyi.system.mapper.garden;

import java.util.List;
import com.ruoyi.system.domain.garden.GardenPlantLog;

public interface GardenPlantLogMapper
{
    List<GardenPlantLog> selectPlantLogList(GardenPlantLog log);

    int insertPlantLog(GardenPlantLog log);
}

