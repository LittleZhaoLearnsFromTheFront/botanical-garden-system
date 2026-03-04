package com.ruoyi.system.service.garden.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.domain.garden.GardenDevice;
import com.ruoyi.system.mapper.garden.GardenDeviceMapper;
import com.ruoyi.system.service.garden.IGardenDeviceService;

/**
 * 娱乐设备 服务实现
 */
@Service
public class GardenDeviceServiceImpl implements IGardenDeviceService
{
    @Autowired
    private GardenDeviceMapper deviceMapper;

    @Override
    public GardenDevice selectDeviceById(Long deviceId)
    {
        return deviceMapper.selectDeviceById(deviceId);
    }

    @Override
    public List<GardenDevice> selectDeviceList(GardenDevice device)
    {
        return deviceMapper.selectDeviceList(device);
    }

    @Override
    public int insertDevice(GardenDevice device)
    {
        return deviceMapper.insertDevice(device);
    }

    @Override
    public int updateDevice(GardenDevice device)
    {
        return deviceMapper.updateDevice(device);
    }

    @Override
    public int deleteDeviceByIds(Long[] deviceIds)
    {
        return deviceMapper.deleteDeviceByIds(deviceIds);
    }

    @Override
    public int deleteDeviceById(Long deviceId)
    {
        return deviceMapper.deleteDeviceById(deviceId);
    }
}

