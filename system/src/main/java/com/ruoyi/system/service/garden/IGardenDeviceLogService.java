package com.ruoyi.system.service.garden;

import java.util.List;
import com.ruoyi.system.domain.garden.GardenDeviceLog;

public interface IGardenDeviceLogService
{
    List<GardenDeviceLog> selectDeviceLogList(GardenDeviceLog log);

    int insertDeviceLog(GardenDeviceLog log);
}

