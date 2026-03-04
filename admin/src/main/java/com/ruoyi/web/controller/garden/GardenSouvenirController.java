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
import com.ruoyi.system.domain.garden.GardenSouvenir;
import com.ruoyi.system.service.garden.IGardenSouvenirService;

/**
 * 纪念品管理
 */
@RestController
@RequestMapping("/garden/souvenir")
public class GardenSouvenirController extends BaseController
{
    @Autowired
    private IGardenSouvenirService souvenirService;

    @PreAuthorize("@ss.hasPermi('garden:souvenir:list')")
    @GetMapping("/list")
    public TableDataInfo list(GardenSouvenir souvenir)
    {
        startPage();
        List<GardenSouvenir> list = souvenirService.selectSouvenirList(souvenir);
        return getDataTable(list);
    }

    @Log(title = "纪念品", businessType = BusinessType.EXPORT)
    @PreAuthorize("@ss.hasPermi('garden:souvenir:export')")
    @PostMapping("/export")
    public void export(HttpServletResponse response, GardenSouvenir souvenir)
    {
        List<GardenSouvenir> list = souvenirService.selectSouvenirList(souvenir);
        ExcelUtil<GardenSouvenir> util = new ExcelUtil<GardenSouvenir>(GardenSouvenir.class);
        util.exportExcel(response, list, "纪念品数据");
    }

    @PreAuthorize("@ss.hasPermi('garden:souvenir:query')")
    @GetMapping(value = "/{souvenirId}")
    public AjaxResult getInfo(@PathVariable Long souvenirId)
    {
        return success(souvenirService.selectSouvenirById(souvenirId));
    }

    @PreAuthorize("@ss.hasPermi('garden:souvenir:add')")
    @Log(title = "纪念品", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@Validated @RequestBody GardenSouvenir souvenir)
    {
        souvenir.setCreateBy(getUsername());
        return toAjax(souvenirService.insertSouvenir(souvenir));
    }

    @PreAuthorize("@ss.hasPermi('garden:souvenir:edit')")
    @Log(title = "纪念品", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@Validated @RequestBody GardenSouvenir souvenir)
    {
        souvenir.setUpdateBy(getUsername());
        return toAjax(souvenirService.updateSouvenir(souvenir));
    }

    @PreAuthorize("@ss.hasPermi('garden:souvenir:remove')")
    @Log(title = "纪念品", businessType = BusinessType.DELETE)
    @DeleteMapping("/{souvenirIds}")
    public AjaxResult remove(@PathVariable Long[] souvenirIds)
    {
        return toAjax(souvenirService.deleteSouvenirByIds(souvenirIds));
    }
}

