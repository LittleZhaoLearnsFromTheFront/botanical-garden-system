package com.ruoyi.web.controller.garden;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.system.domain.garden.GardenPlantLog;
import com.ruoyi.system.service.garden.IGardenPlantLogService;

/**
 * 植物维护日志
 */
@RestController
@RequestMapping("/garden/plantLog")
public class GardenPlantLogController extends BaseController
{
    @Autowired
    private IGardenPlantLogService plantLogService;

    @PreAuthorize("@ss.hasPermi('garden:plantLog:list')")
    @GetMapping("/list")
    public TableDataInfo list(GardenPlantLog log)
    {
        startPage();
        List<GardenPlantLog> list = plantLogService.selectPlantLogList(log);
        return getDataTable(list);
    }
}

