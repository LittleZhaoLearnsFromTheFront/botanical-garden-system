package com.ruoyi.web.controller.garden;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.system.domain.garden.GardenAreaLog;
import com.ruoyi.system.service.garden.IGardenAreaLogService;

/**
 * 区域维护日志
 */
@RestController
@RequestMapping("/garden/areaLog")
public class GardenAreaLogController extends BaseController
{
    @Autowired
    private IGardenAreaLogService areaLogService;

    @PreAuthorize("@ss.hasPermi('garden:areaLog:list')")
    @GetMapping("/list")
    public TableDataInfo list(GardenAreaLog log)
    {
        startPage();
        List<GardenAreaLog> list = areaLogService.selectAreaLogList(log);
        return getDataTable(list);
    }
}

