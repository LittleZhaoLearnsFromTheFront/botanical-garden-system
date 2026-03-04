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
import com.ruoyi.system.domain.garden.GardenPlant;
import com.ruoyi.system.service.garden.IGardenPlantService;

/**
 * 植物档案
 */
@RestController
@RequestMapping("/garden/plant")
public class GardenPlantController extends BaseController
{
    @Autowired
    private IGardenPlantService plantService;

    @PreAuthorize("@ss.hasPermi('garden:plant:list')")
    @GetMapping("/list")
    public TableDataInfo list(GardenPlant plant)
    {
        startPage();
        List<GardenPlant> list = plantService.selectPlantList(plant);
        return getDataTable(list);
    }

    @Log(title = "植物档案", businessType = BusinessType.EXPORT)
    @PreAuthorize("@ss.hasPermi('garden:plant:export')")
    @PostMapping("/export")
    public void export(HttpServletResponse response, GardenPlant plant)
    {
        List<GardenPlant> list = plantService.selectPlantList(plant);
        ExcelUtil<GardenPlant> util = new ExcelUtil<GardenPlant>(GardenPlant.class);
        util.exportExcel(response, list, "植物档案");
    }

    @PreAuthorize("@ss.hasPermi('garden:plant:query')")
    @GetMapping(value = "/{plantId}")
    public AjaxResult getInfo(@PathVariable Long plantId)
    {
        return success(plantService.selectPlantById(plantId));
    }

    @PreAuthorize("@ss.hasPermi('garden:plant:add')")
    @Log(title = "植物档案", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@Validated @RequestBody GardenPlant plant)
    {
        plant.setCreateBy(getUsername());
        return toAjax(plantService.insertPlant(plant));
    }

    @PreAuthorize("@ss.hasPermi('garden:plant:edit')")
    @Log(title = "植物档案", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@Validated @RequestBody GardenPlant plant)
    {
        plant.setUpdateBy(getUsername());
        return toAjax(plantService.updatePlant(plant));
    }

    @PreAuthorize("@ss.hasPermi('garden:plant:remove')")
    @Log(title = "植物档案", businessType = BusinessType.DELETE)
    @DeleteMapping("/{plantIds}")
    public AjaxResult remove(@PathVariable Long[] plantIds)
    {
        return toAjax(plantService.deletePlantByIds(plantIds));
    }
}

