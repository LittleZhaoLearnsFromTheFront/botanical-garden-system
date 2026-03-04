package com.ruoyi.system.service.garden;

import java.util.List;
import com.ruoyi.system.domain.garden.GardenAreaLog;

public interface IGardenAreaLogService
{
    List<GardenAreaLog> selectAreaLogList(GardenAreaLog log);

    int insertAreaLog(GardenAreaLog log);
}

