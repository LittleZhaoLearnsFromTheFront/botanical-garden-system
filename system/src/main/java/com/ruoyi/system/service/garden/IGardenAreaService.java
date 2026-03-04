package com.ruoyi.system.service.garden;

import java.util.List;
import com.ruoyi.system.domain.garden.GardenArea;
import com.ruoyi.system.domain.garden.GardenTreeSelect;

/**
 * 区域管理 服务层
 */
public interface IGardenAreaService
{
    public List<GardenArea> selectAreaList(GardenArea area);

    public List<GardenTreeSelect> selectAreaTreeList(GardenArea area);

    public List<GardenArea> buildAreaTree(List<GardenArea> areas);

    public List<GardenTreeSelect> buildAreaTreeSelect(List<GardenArea> areas);

    public GardenArea selectAreaById(Long areaId);

    public boolean checkAreaNameUnique(GardenArea area);

    public boolean hasChildByAreaId(Long areaId);

    public boolean checkAreaExistPlant(Long areaId);

    public boolean checkAreaExistDevice(Long areaId);

    public int insertArea(GardenArea area);

    public int updateArea(GardenArea area);

    public int deleteAreaById(Long areaId);
}

