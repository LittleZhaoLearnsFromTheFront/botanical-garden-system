package com.ruoyi.system.domain.garden;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 娱乐设备表 garden_device
 */
public class GardenDevice extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 设备ID */
    private Long deviceId;

    /** 所属区域ID */
    @Excel(name = "所属区域ID")
    private Long areaId;

    /** 所属区域名称（展示用） */
    @Excel(name = "所属区域")
    private String areaName;

    /** 设备名称 */
    @Excel(name = "设备名称")
    private String deviceName;

    /** 设备编号 */
    @Excel(name = "设备编号")
    private String deviceCode;

    /** 设备类型 */
    @Excel(name = "设备类型")
    private String deviceType;

    /** 生产厂家 */
    @Excel(name = "生产厂家")
    private String manufacturer;

    /** 安装日期 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "安装日期", width = 30, dateFormat = "yyyy-MM-dd")
    private Date installDate;

    /** 使用次数 */
    @Excel(name = "使用次数")
    private Integer usageCount;

    /** 状态（0正常 1停用） */
    @Excel(name = "状态", readConverterExp = "0=正常,1=停用")
    private String status;

    /** 删除标志（0代表存在 2代表删除） */
    private String delFlag;

    public Long getDeviceId()
    {
        return deviceId;
    }

    public void setDeviceId(Long deviceId)
    {
        this.deviceId = deviceId;
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

    public String getDeviceName()
    {
        return deviceName;
    }

    public void setDeviceName(String deviceName)
    {
        this.deviceName = deviceName;
    }

    public String getDeviceCode()
    {
        return deviceCode;
    }

    public void setDeviceCode(String deviceCode)
    {
        this.deviceCode = deviceCode;
    }

    public String getDeviceType()
    {
        return deviceType;
    }

    public void setDeviceType(String deviceType)
    {
        this.deviceType = deviceType;
    }

    public String getManufacturer()
    {
        return manufacturer;
    }

    public void setManufacturer(String manufacturer)
    {
        this.manufacturer = manufacturer;
    }

    public Date getInstallDate()
    {
        return installDate;
    }

    public void setInstallDate(Date installDate)
    {
        this.installDate = installDate;
    }

    public Integer getUsageCount()
    {
        return usageCount;
    }

    public void setUsageCount(Integer usageCount)
    {
        this.usageCount = usageCount;
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

    @Override
    public String toString()
    {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
                .append("deviceId", getDeviceId())
                .append("areaId", getAreaId())
                .append("deviceName", getDeviceName())
                .append("deviceCode", getDeviceCode())
                .append("deviceType", getDeviceType())
                .append("manufacturer", getManufacturer())
                .append("installDate", getInstallDate())
                .append("usageCount", getUsageCount())
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

