package com.ruoyi.web.controller.garden;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.system.domain.garden.GardenDeviceLog;
import com.ruoyi.system.service.garden.IGardenDeviceLogService;

/**
 * 设备维护日志
 */
@RestController
@RequestMapping("/garden/deviceLog")
public class GardenDeviceLogController extends BaseController
{
    @Autowired
    private IGardenDeviceLogService deviceLogService;

    @PreAuthorize("@ss.hasPermi('garden:deviceLog:list')")
    @GetMapping("/list")
    public TableDataInfo list(GardenDeviceLog log)
    {
        startPage();
        List<GardenDeviceLog> list = deviceLogService.selectDeviceLogList(log);
        return getDataTable(list);
    }
}

