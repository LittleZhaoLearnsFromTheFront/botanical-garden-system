package com.ruoyi.web.controller.garden;

import java.util.List;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.system.domain.garden.GardenDevice;
import com.ruoyi.system.service.garden.IGardenDeviceService;

/**
 * 娱乐设备
 */
@RestController
@RequestMapping("/garden/device")
public class GardenDeviceController extends BaseController
{
    @Autowired
    private IGardenDeviceService deviceService;

    @PreAuthorize("@ss.hasPermi('garden:device:list')")
    @GetMapping("/list")
    public TableDataInfo list(GardenDevice device)
    {
        startPage();
        List<GardenDevice> list = deviceService.selectDeviceList(device);
        return getDataTable(list);
    }

    @Log(title = "娱乐设备", businessType = BusinessType.EXPORT)
    @PreAuthorize("@ss.hasPermi('garden:device:export')")
    @PostMapping("/export")
    public void export(HttpServletResponse response, GardenDevice device)
    {
        List<GardenDevice> list = deviceService.selectDeviceList(device);
        ExcelUtil<GardenDevice> util = new ExcelUtil<GardenDevice>(GardenDevice.class);
        util.exportExcel(response, list, "娱乐设备");
    }

    @PreAuthorize("@ss.hasPermi('garden:device:query')")
    @GetMapping(value = "/{deviceId}")
    public AjaxResult getInfo(@PathVariable Long deviceId)
    {
        return success(deviceService.selectDeviceById(deviceId));
    }

    @PreAuthorize("@ss.hasPermi('garden:device:add')")
    @Log(title = "娱乐设备", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@Validated @RequestBody GardenDevice device)
    {
        device.setCreateBy(getUsername());
        return toAjax(deviceService.insertDevice(device));
    }

    @PreAuthorize("@ss.hasPermi('garden:device:edit')")
    @Log(title = "娱乐设备", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@Validated @RequestBody GardenDevice device)
    {
        device.setUpdateBy(getUsername());
        return toAjax(deviceService.updateDevice(device));
    }

    @PreAuthorize("@ss.hasPermi('garden:device:remove')")
    @Log(title = "娱乐设备", businessType = BusinessType.DELETE)
    @DeleteMapping("/{deviceIds}")
    public AjaxResult remove(@PathVariable Long[] deviceIds)
    {
        return toAjax(deviceService.deleteDeviceByIds(deviceIds));
    }
}

