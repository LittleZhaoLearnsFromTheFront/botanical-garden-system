package com.ruoyi.system.mapper.garden;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.ruoyi.system.domain.garden.GardenArea;

/**
 * 区域管理 数据层
 */
public interface GardenAreaMapper
{
    public List<GardenArea> selectAreaList(GardenArea area);

    public GardenArea selectAreaById(Long areaId);

    public List<GardenArea> selectChildrenAreaById(Long areaId);

    public int hasChildByAreaId(Long areaId);

    public int checkAreaExistPlant(Long areaId);

    public int checkAreaExistDevice(Long areaId);

    public GardenArea checkAreaNameUnique(@Param("areaName") String areaName, @Param("parentId") Long parentId);

    public int insertArea(GardenArea area);

    public int updateArea(GardenArea area);

    public void updateAreaStatusNormal(Long[] areaIds);

    public int updateAreaChildren(@Param("areas") List<GardenArea> areas);

    public int deleteAreaById(Long areaId);
}

