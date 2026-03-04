package com.ruoyi.system.domain.garden;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 植物档案表 garden_plant
 */
public class GardenPlant extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 植物ID */
    private Long plantId;

    /** 所属区域ID */
    @Excel(name = "所属区域ID")
    private Long areaId;

    /** 所属区域名称（展示用） */
    @Excel(name = "所属区域")
    private String areaName;

    /** 植物名称 */
    @Excel(name = "植物名称")
    private String plantName;

    /** 植物编号 */
    @Excel(name = "植物编号")
    private String plantCode;

    /** 品种/学名 */
    @Excel(name = "品种/学名")
    private String species;

    /** 树龄(年) */
    @Excel(name = "树龄(年)")
    private Integer ageYears;

    /** 高度(cm) */
    @Excel(name = "高度(cm)")
    private Integer heightCm;

    /** 健康状态（0良好 1一般 2较差） */
    @Excel(name = "健康状态", readConverterExp = "0=良好,1=一般,2=较差")
    private String healthStatus;

    /** 状态（0正常 1停用） */
    @Excel(name = "状态", readConverterExp = "0=正常,1=停用")
    private String status;

    /** 删除标志（0代表存在 2代表删除） */
    private String delFlag;

    /** 图片URL */
    @Excel(name = "图片URL")
    private String imageUrl;

    public Long getPlantId()
    {
        return plantId;
    }

    public void setPlantId(Long plantId)
    {
        this.plantId = plantId;
    }

    public Long getAreaId()
    {
        return areaId;
    }

    public void setAreaId(Long areaId)
    {
        this.areaId = areaId;
    }

    public String getAreaName()
    {
        return areaName;
    }

    public void setAreaName(String areaName)
    {
        this.areaName = areaName;
    }

    public String getPlantName()
    {
        return plantName;
    }

    public void setPlantName(String plantName)
    {
        this.plantName = plantName;
    }

    public String getPlantCode()
    {
        return plantCode;
    }

    public void setPlantCode(String plantCode)
    {
        this.plantCode = plantCode;
    }

    public String getSpecies()
    {
        return species;
    }

    public void setSpecies(String species)
    {
        this.species = species;
    }

    public Integer getAgeYears()
    {
        return ageYears;
    }

    public void setAgeYears(Integer ageYears)
    {
        this.ageYears = ageYears;
    }

    public Integer getHeightCm()
    {
        return heightCm;
    }

    public void setHeightCm(Integer heightCm)
    {
        this.heightCm = heightCm;
    }

    public String getHealthStatus()
    {
        return healthStatus;
    }

    public void setHealthStatus(String healthStatus)
    {
        this.healthStatus = healthStatus;
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

    public String getImageUrl()
    {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl)
    {
        this.imageUrl = imageUrl;
    }

    @Override
    public String toString()
    {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
                .append("plantId", getPlantId())
                .append("areaId", getAreaId())
                .append("plantName", getPlantName())
                .append("plantCode", getPlantCode())
                .append("species", getSpecies())
                .append("ageYears", getAgeYears())
                .append("heightCm", getHeightCm())
                .append("healthStatus", getHealthStatus())
                .append("status", getStatus())
                .append("delFlag", getDelFlag())
                .append("imageUrl", getImageUrl())
                .append("createBy", getCreateBy())
                .append("createTime", getCreateTime())
                .append("updateBy", getUpdateBy())
                .append("updateTime", getUpdateTime())
                .append("remark", getRemark())
                .toString();
    }
}

