package com.ruoyi.system.service.garden;

import java.util.List;
import com.ruoyi.system.domain.garden.GardenPlantLog;

public interface IGardenPlantLogService
{
    List<GardenPlantLog> selectPlantLogList(GardenPlantLog log);

    int insertPlantLog(GardenPlantLog log);
}

