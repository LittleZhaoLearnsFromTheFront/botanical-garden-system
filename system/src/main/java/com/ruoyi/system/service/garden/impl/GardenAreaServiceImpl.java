package com.ruoyi.system.service.garden.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.common.constant.UserConstants;
import com.ruoyi.common.core.text.Convert;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.system.domain.garden.GardenArea;
import com.ruoyi.system.domain.garden.GardenTreeSelect;
import com.ruoyi.system.mapper.garden.GardenAreaMapper;
import com.ruoyi.system.service.garden.IGardenAreaService;

/**
 * 区域管理 服务实现
 */
@Service
public class GardenAreaServiceImpl implements IGardenAreaService
{
    @Autowired
    private GardenAreaMapper areaMapper;

    @Override
    public List<GardenArea> selectAreaList(GardenArea area)
    {
        return areaMapper.selectAreaList(area);
    }

    @Override
    public List<GardenTreeSelect> selectAreaTreeList(GardenArea area)
    {
        List<GardenArea> areas = selectAreaList(area);
        return buildAreaTreeSelect(areas);
    }

    @Override
    public List<GardenArea> buildAreaTree(List<GardenArea> areas)
    {
        List<GardenArea> returnList = new ArrayList<GardenArea>();
        List<Long> tempList = areas.stream().map(GardenArea::getAreaId).collect(Collectors.toList());
        for (GardenArea area : areas)
        {
            if (!tempList.contains(area.getParentId()))
            {
                recursionFn(areas, area);
                returnList.add(area);
            }
        }
        if (returnList.isEmpty())
        {
            returnList = areas;
        }
        return returnList;
    }

    @Override
    public List<GardenTreeSelect> buildAreaTreeSelect(List<GardenArea> areas)
    {
        List<GardenArea> areaTrees = buildAreaTree(areas);
        return areaTrees.stream().map(GardenTreeSelect::new).collect(Collectors.toList());
    }

    @Override
    public GardenArea selectAreaById(Long areaId)
    {
        return areaMapper.selectAreaById(areaId);
    }

    @Override
    public boolean checkAreaNameUnique(GardenArea area)
    {
        Long areaId = StringUtils.isNull(area.getAreaId()) ? -1L : area.getAreaId();
        Long parentId = StringUtils.isNull(area.getParentId()) ? 0L : area.getParentId();
        GardenArea info = areaMapper.checkAreaNameUnique(area.getAreaName(), parentId);
        if (StringUtils.isNotNull(info) && info.getAreaId().longValue() != areaId.longValue())
        {
            return UserConstants.NOT_UNIQUE;
        }
        return UserConstants.UNIQUE;
    }

    @Override
    public boolean hasChildByAreaId(Long areaId)
    {
        return areaMapper.hasChildByAreaId(areaId) > 0;
    }

    @Override
    public boolean checkAreaExistPlant(Long areaId)
    {
        return areaMapper.checkAreaExistPlant(areaId) > 0;
    }

    @Override
    public boolean checkAreaExistDevice(Long areaId)
    {
        return areaMapper.checkAreaExistDevice(areaId) > 0;
    }

    @Override
    public int insertArea(GardenArea area)
    {
        Long parentId = StringUtils.isNull(area.getParentId()) ? 0L : area.getParentId();
        if (parentId == 0L)
        {
            area.setParentId(0L);
            area.setAncestors("0");
        }
        else
        {
            GardenArea parent = areaMapper.selectAreaById(parentId);
            if (parent == null)
            {
                throw new ServiceException("上级区域不存在，无法新增");
            }
            if (!StringUtils.equals(UserConstants.DEPT_NORMAL, parent.getStatus()))
            {
                throw new ServiceException("上级区域停用，不允许新增");
            }
            area.setAncestors(parent.getAncestors() + "," + parentId);
        }
        return areaMapper.insertArea(area);
    }

    @Override
    public int updateArea(GardenArea area)
    {
        GardenArea oldArea = areaMapper.selectAreaById(area.getAreaId());
        if (oldArea == null)
        {
            throw new ServiceException("区域不存在");
        }

        Long parentId = StringUtils.isNull(area.getParentId()) ? 0L : area.getParentId();
        String oldAncestors = oldArea.getAncestors();
        String newAncestors;
        if (parentId == 0L)
        {
            area.setParentId(0L);
            newAncestors = "0";
        }
        else
        {
            GardenArea newParent = areaMapper.selectAreaById(parentId);
            if (newParent == null)
            {
                throw new ServiceException("上级区域不存在，无法修改");
            }
            if (!StringUtils.equals(UserConstants.DEPT_NORMAL, newParent.getStatus()))
            {
                throw new ServiceException("上级区域停用，不允许修改");
            }
            newAncestors = newParent.getAncestors() + "," + parentId;
        }
        area.setAncestors(newAncestors);
        updateAreaChildren(area.getAreaId(), newAncestors, oldAncestors);

        int result = areaMapper.updateArea(area);
        if (StringUtils.equals(UserConstants.DEPT_NORMAL, area.getStatus()) && StringUtils.isNotEmpty(area.getAncestors())
                && !StringUtils.equals("0", area.getAncestors()))
        {
            updateParentAreaStatusNormal(area);
        }
        return result;
    }

    @Override
    public int deleteAreaById(Long areaId)
    {
        return areaMapper.deleteAreaById(areaId);
    }

    private void updateParentAreaStatusNormal(GardenArea area)
    {
        String ancestors = area.getAncestors();
        Long[] areaIds = Convert.toLongArray(ancestors);
        areaMapper.updateAreaStatusNormal(areaIds);
    }

    private void updateAreaChildren(Long areaId, String newAncestors, String oldAncestors)
    {
        List<GardenArea> children = areaMapper.selectChildrenAreaById(areaId);
        for (GardenArea child : children)
        {
            child.setAncestors(child.getAncestors().replaceFirst(oldAncestors, newAncestors));
        }
        if (children.size() > 0)
        {
            areaMapper.updateAreaChildren(children);
        }
    }

    private void recursionFn(List<GardenArea> list, GardenArea t)
    {
        List<GardenArea> childList = getChildList(list, t);
        t.setChildren(childList);
        for (GardenArea tChild : childList)
        {
            if (hasChild(list, tChild))
            {
                recursionFn(list, tChild);
            }
        }
    }

    private List<GardenArea> getChildList(List<GardenArea> list, GardenArea t)
    {
        List<GardenArea> tlist = new ArrayList<GardenArea>();
        for (GardenArea n : list)
        {
            if (StringUtils.isNotNull(n.getParentId()) && n.getParentId().longValue() == t.getAreaId().longValue())
            {
                tlist.add(n);
            }
        }
        return tlist;
    }

    private boolean hasChild(List<GardenArea> list, GardenArea t)
    {
        return getChildList(list, t).size() > 0;
    }
}

