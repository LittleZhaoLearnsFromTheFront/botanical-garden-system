package com.ruoyi.web.controller.garden;

import java.util.List;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.lang3.ArrayUtils;
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
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.system.domain.garden.GardenArea;
import com.ruoyi.system.service.garden.IGardenAreaService;

/**
 * 区域管理
 */
@RestController
@RequestMapping("/garden/area")
public class GardenAreaController extends BaseController
{
    @Autowired
    private IGardenAreaService areaService;

    /**
     * 获取区域列表（树）
     */
    @PreAuthorize("@ss.hasPermi('garden:area:list')")
    @GetMapping("/list")
    public AjaxResult list(GardenArea area)
    {
        List<GardenArea> list = areaService.selectAreaList(area);
        return success(list);
    }

    /**
     * 查询区域列表（排除节点）
     */
    @PreAuthorize("@ss.hasPermi('garden:area:list')")
    @GetMapping("/list/exclude/{areaId}")
    public AjaxResult excludeChild(@PathVariable(value = "areaId", required = false) Long areaId)
    {
        List<GardenArea> areas = areaService.selectAreaList(new GardenArea());
        areas.removeIf(a -> a.getAreaId().intValue() == areaId
                || ArrayUtils.contains(StringUtils.split(a.getAncestors(), ","), areaId + ""));
        return success(areas);
    }

    /**
     * 获取区域下拉树列表
     */
    @PreAuthorize("@ss.hasPermi('garden:area:list')")
    @GetMapping("/treeselect")
    public AjaxResult treeselect(GardenArea area)
    {
        return success(areaService.selectAreaTreeList(area));
    }

    @Log(title = "区域管理", businessType = BusinessType.EXPORT)
    @PreAuthorize("@ss.hasPermi('garden:area:export')")
    @PostMapping("/export")
    public void export(HttpServletResponse response, GardenArea area)
    {
        List<GardenArea> list = areaService.selectAreaList(area);
        ExcelUtil<GardenArea> util = new ExcelUtil<GardenArea>(GardenArea.class);
        util.exportExcel(response, list, "区域数据");
    }

    /**
     * 根据区域编号获取详细信息
     */
    @PreAuthorize("@ss.hasPermi('garden:area:query')")
    @GetMapping(value = "/{areaId}")
    public AjaxResult getInfo(@PathVariable Long areaId)
    {
        return success(areaService.selectAreaById(areaId));
    }

    /**
     * 新增区域
     */
    @PreAuthorize("@ss.hasPermi('garden:area:add')")
    @Log(title = "区域管理", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@Validated @RequestBody GardenArea area)
    {
        if (!areaService.checkAreaNameUnique(area))
        {
            return error("新增区域'" + area.getAreaName() + "'失败，区域名称已存在");
        }
        area.setCreateBy(getUsername());
        return toAjax(areaService.insertArea(area));
    }

    /**
     * 修改区域
     */
    @PreAuthorize("@ss.hasPermi('garden:area:edit')")
    @Log(title = "区域管理", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@Validated @RequestBody GardenArea area)
    {
        if (!areaService.checkAreaNameUnique(area))
        {
            return error("修改区域'" + area.getAreaName() + "'失败，区域名称已存在");
        }
        else if (area.getParentId().equals(area.getAreaId()))
        {
            return error("修改区域'" + area.getAreaName() + "'失败，上级区域不能是自己");
        }
        area.setUpdateBy(getUsername());
        return toAjax(areaService.updateArea(area));
    }

    /**
     * 删除区域
     */
    @PreAuthorize("@ss.hasPermi('garden:area:remove')")
    @Log(title = "区域管理", businessType = BusinessType.DELETE)
    @DeleteMapping("/{areaId}")
    public AjaxResult remove(@PathVariable Long areaId)
    {
        if (areaService.hasChildByAreaId(areaId))
        {
            return warn("存在下级区域，不允许删除");
        }
        if (areaService.checkAreaExistPlant(areaId))
        {
            return warn("区域下存在植物档案，不允许删除");
        }
        if (areaService.checkAreaExistDevice(areaId))
        {
            return warn("区域下存在娱乐设备，不允许删除");
        }
        return toAjax(areaService.deleteAreaById(areaId));
    }
}

