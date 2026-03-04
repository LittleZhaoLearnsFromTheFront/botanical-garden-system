package com.ruoyi.system.mapper.garden;

import java.util.List;
import com.ruoyi.system.domain.garden.GardenDeviceLog;

public interface GardenDeviceLogMapper
{
    List<GardenDeviceLog> selectDeviceLogList(GardenDeviceLog log);

    int insertDeviceLog(GardenDeviceLog log);
}

