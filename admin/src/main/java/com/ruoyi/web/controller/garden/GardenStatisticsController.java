package com.ruoyi.web.controller.garden;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.system.domain.garden.GardenArea;
import com.ruoyi.system.domain.garden.GardenDevice;
import com.ruoyi.system.domain.garden.GardenPlant;
import com.ruoyi.system.domain.garden.GardenSouvenir;
import com.ruoyi.system.domain.garden.GardenWorkOrder;
import com.ruoyi.system.service.garden.IGardenAreaService;
import com.ruoyi.system.service.garden.IGardenDeviceService;
import com.ruoyi.system.service.garden.IGardenPlantService;
import com.ruoyi.system.service.garden.IGardenSouvenirService;
import com.ruoyi.system.service.garden.IGardenWorkOrderService;

/**
 * 园林数据统计（首页数据统计模块）
 */
@RestController
@RequestMapping("/garden/statistics")
public class GardenStatisticsController extends BaseController
{
    @Autowired
    private IGardenAreaService areaService;
    @Autowired
    private IGardenPlantService plantService;
    @Autowired
    private IGardenDeviceService deviceService;
    @Autowired
    private IGardenSouvenirService souvenirService;
    @Autowired
    private IGardenWorkOrderService workOrderService;

    /**
     * 基础数据统计：区域、植物、设备、纪念品数量
     */
    @GetMapping("/basic")
    public AjaxResult basic()
    {
        PageHelper.startPage(1, 1);
        List<GardenArea> areaList = areaService.selectAreaList(new GardenArea());
        TableDataInfo areaTable = getDataTable(areaList);
        long areaCount = areaTable.getTotal();

        PageHelper.startPage(1, 1);
        List<GardenPlant> plantList = plantService.selectPlantList(new GardenPlant());
        long plantCount = getDataTable(plantList).getTotal();

        PageHelper.startPage(1, 1);
        List<GardenDevice> deviceList = deviceService.selectDeviceList(new GardenDevice());
        long deviceCount = getDataTable(deviceList).getTotal();

        PageHelper.startPage(1, 1);
        List<GardenSouvenir> souvenirList = souvenirService.selectSouvenirList(new GardenSouvenir());
        long souvenirCount = getDataTable(souvenirList).getTotal();

        Map<String, Long> data = new HashMap<>();
        data.put("areaCount", areaCount);
        data.put("plantCount", plantCount);
        data.put("deviceCount", deviceCount);
        data.put("souvenirCount", souvenirCount);
        return success(data);
    }

    /**
     * 任务数据统计：工单按状态分布
     */
    @GetMapping("/task")
    public AjaxResult task()
    {
        List<GardenWorkOrder> list = workOrderService.selectWorkOrderList(new GardenWorkOrder());
        Map<String, Long> statusCount = list.stream()
                .collect(Collectors.groupingBy(
                        w -> w.getStatus() != null ? w.getStatus() : "0",
                        Collectors.counting()));
        Map<String, Long> data = new HashMap<>();
        data.put("pending", statusCount.getOrDefault("0", 0L));
        data.put("doing", statusCount.getOrDefault("1", 0L));
        data.put("done", statusCount.getOrDefault("2", 0L));
        data.put("cancelled", statusCount.getOrDefault("3", 0L));
        data.put("total", (long) list.size());
        return success(data);
    }
}
