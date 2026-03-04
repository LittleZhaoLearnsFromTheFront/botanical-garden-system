package com.ruoyi.system.mapper.garden;

import java.util.List;
import com.ruoyi.system.domain.garden.GardenDevice;

/**
 * 娱乐设备 数据层
 */
public interface GardenDeviceMapper
{
    public GardenDevice selectDeviceById(Long deviceId);

    public List<GardenDevice> selectDeviceList(GardenDevice device);

    public int insertDevice(GardenDevice device);

    public int updateDevice(GardenDevice device);

    public int deleteDeviceById(Long deviceId);

    public int deleteDeviceByIds(Long[] deviceIds);
}

