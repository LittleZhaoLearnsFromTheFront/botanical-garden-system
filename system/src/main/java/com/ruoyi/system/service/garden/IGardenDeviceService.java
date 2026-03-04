package com.ruoyi.system.service.garden;

import java.util.List;
import com.ruoyi.system.domain.garden.GardenDevice;

/**
 * 娱乐设备 服务层
 */
public interface IGardenDeviceService
{
    public GardenDevice selectDeviceById(Long deviceId);

    public List<GardenDevice> selectDeviceList(GardenDevice device);

    public int insertDevice(GardenDevice device);

    public int updateDevice(GardenDevice device);

    public int deleteDeviceByIds(Long[] deviceIds);

    public int deleteDeviceById(Long deviceId);
}

