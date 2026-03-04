package com.ruoyi.system.domain.garden;

import java.util.ArrayList;
import java.util.List;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 园林区域表 garden_area
 */
public class GardenArea extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 区域ID */
    @Excel(name = "区域ID")
    private Long areaId;

    /** 父区域ID */
    @Excel(name = "父区域ID")
    private Long parentId;

    /** 祖级列表 */
    private String ancestors;

    /** 区域名称 */
    @Excel(name = "区域名称")
    private String areaName;

    /** 区域编码 */
    @Excel(name = "区域编码")
    private String areaCode;

    /** 显示顺序 */
    @Excel(name = "显示顺序")
    private Integer orderNum;

    /** 状态（0正常 1停用） */
    @Excel(name = "状态", readConverterExp = "0=正常,1=停用")
    private String status;

    /** 删除标志（0代表存在 2代表删除） */
    private String delFlag;

    /** 父区域名称 */
    private String parentName;

    /** 子区域 */
    private List<GardenArea> children = new ArrayList<GardenArea>();

    public Long getAreaId()
    {
        return areaId;
    }

    public void setAreaId(Long areaId)
    {
        this.areaId = areaId;
    }

    public Long getParentId()
    {
        return parentId;
    }

    public void setParentId(Long parentId)
    {
        this.parentId = parentId;
    }

    public String getAncestors()
    {
        return ancestors;
    }

    public void setAncestors(String ancestors)
    {
        this.ancestors = ancestors;
    }

    @NotBlank(message = "区域名称不能为空")
    @Size(min = 0, max = 50, message = "区域名称长度不能超过50个字符")
    public String getAreaName()
    {
        return areaName;
    }

    public void setAreaName(String areaName)
    {
        this.areaName = areaName;
    }

    @Size(min = 0, max = 50, message = "区域编码长度不能超过50个字符")
    public String getAreaCode()
    {
        return areaCode;
    }

    public void setAreaCode(String areaCode)
    {
        this.areaCode = areaCode;
    }

    @NotNull(message = "显示顺序不能为空")
    public Integer getOrderNum()
    {
        return orderNum;
    }

    public void setOrderNum(Integer orderNum)
    {
        this.orderNum = orderNum;
    }

    public String getStatus()
    {
        return status;
    }

    public void setStatus(String status)
    {
        this.status = status;
    }

    public String getDelFlag()
    {
        return delFlag;
    }

    public void setDelFlag(String delFlag)
    {
        this.delFlag = delFlag;
    }

    public String getParentName()
    {
        return parentName;
    }

    public void setParentName(String parentName)
    {
        this.parentName = parentName;
    }

    public List<GardenArea> getChildren()
    {
        return children;
    }

    public void setChildren(List<GardenArea> children)
    {
        this.children = children;
    }

    @Override
    public String toString()
    {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
                .append("areaId", getAreaId())
                .append("parentId", getParentId())
                .append("ancestors", getAncestors())
                .append("areaName", getAreaName())
                .append("areaCode", getAreaCode())
                .append("orderNum", getOrderNum())
                .append("status", getStatus())
                .append("delFlag", getDelFlag())
                .append("createBy", getCreateBy())
                .append("createTime", getCreateTime())
                .append("updateBy", getUpdateBy())
                .append("updateTime", getUpdateTime())
                .append("remark", getRemark())
                .toString();
    }
}

