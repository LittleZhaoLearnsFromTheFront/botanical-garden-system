package com.ruoyi.system.mapper.garden;

import java.util.List;
import com.ruoyi.system.domain.garden.GardenAreaLog;

public interface GardenAreaLogMapper
{
    List<GardenAreaLog> selectAreaLogList(GardenAreaLog log);

    int insertAreaLog(GardenAreaLog log);
}

