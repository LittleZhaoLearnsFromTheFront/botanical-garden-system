package com.ruoyi.system.domain.garden;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 工单任务表 garden_work_order
 */
public class GardenWorkOrder extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 工单ID */
    private Long workOrderId;

    /** 标题 */
    @Excel(name = "标题")
    private String title;

    /** 任务类型 */
    @Excel(name = "任务类型")
    private String taskType;

    /** 目标类型（0区域 1植物 2设备） */
    @Excel(name = "目标类型", readConverterExp = "0=区域,1=植物,2=设备")
    private String targetType;

    /** 关联区域ID */
    private Long areaId;

    /** 关联植物ID */
    private Long plantId;

    /** 关联设备ID */
    private Long deviceId;

    /** 任务内容 */
    @Excel(name = "任务内容")
    private String content;

    /** 优先级（0低 1中 2高） */
    @Excel(name = "优先级", readConverterExp = "0=低,1=中,2=高")
    private String priority;

    /** 计划执行时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Excel(name = "计划执行时间", width = 30, dateFormat = "yyyy-MM-dd HH:mm:ss")
    private Date planTime;

    /** 截止时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @Excel(name = "截止时间", width = 30, dateFormat = "yyyy-MM-dd HH:mm:ss")
    private Date deadline;

    /** 发布人用户ID */
    private Long publisherId;

    /** 执行人用户ID */
    private Long executorId;

    /** 状态（0待执行 1执行中 2已完成 3已取消） */
    @Excel(name = "状态", readConverterExp = "0=待执行,1=执行中,2=已完成,3=已取消")
    private String status;

    /** 接单时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date acceptTime;

    /** 完成时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date finishTime;

    /** 执行结果说明 */
    @Excel(name = "执行结果说明")
    private String resultDesc;

    /** 展示字段：区域名称 */
    private String areaName;

    /** 展示字段：植物名称 */
    private String plantName;

    /** 展示字段：设备名称 */
    private String deviceName;

    /** 展示字段：发布人昵称 */
    private String publisherName;

    /** 展示字段：执行人昵称 */
    private String executorName;

    public Long getWorkOrderId()
    {
        return workOrderId;
    }

    public void setWorkOrderId(Long workOrderId)
    {
        this.workOrderId = workOrderId;
    }

    public String getTitle()
    {
        return title;
    }

    public void setTitle(String title)
    {
        this.title = title;
    }

    public String getTaskType()
    {
        return taskType;
    }

    public void setTaskType(String taskType)
    {
        this.taskType = taskType;
    }

    public String getTargetType()
    {
        return targetType;
    }

    public void setTargetType(String targetType)
    {
        this.targetType = targetType;
    }

    public Long getAreaId()
    {
        return areaId;
    }

    public void setAreaId(Long areaId)
    {
        this.areaId = areaId;
    }

    public Long getPlantId()
    {
        return plantId;
    }

    public void setPlantId(Long plantId)
    {
        this.plantId = plantId;
    }

    public Long getDeviceId()
    {
        return deviceId;
    }

    public void setDeviceId(Long deviceId)
    {
        this.deviceId = deviceId;
    }

    public String getContent()
    {
        return content;
    }

    public void setContent(String content)
    {
        this.content = content;
    }

    public String getPriority()
    {
        return priority;
    }

    public void setPriority(String priority)
    {
        this.priority = priority;
    }

    public Date getPlanTime()
    {
        return planTime;
    }

    public void setPlanTime(Date planTime)
    {
        this.planTime = planTime;
    }

    public Date getDeadline()
    {
        return deadline;
    }

    public void setDeadline(Date deadline)
    {
        this.deadline = deadline;
    }

    public Long getPublisherId()
    {
        return publisherId;
    }

    public void setPublisherId(Long publisherId)
    {
        this.publisherId = publisherId;
    }

    public Long getExecutorId()
    {
        return executorId;
    }

    public void setExecutorId(Long executorId)
    {
        this.executorId = executorId;
    }

    public String getStatus()
    {
        return status;
    }

    public void setStatus(String status)
    {
        this.status = status;
    }

    public Date getAcceptTime()
    {
        return acceptTime;
    }

    public void setAcceptTime(Date acceptTime)
    {
        this.acceptTime = acceptTime;
    }

    public Date getFinishTime()
    {
        return finishTime;
    }

    public void setFinishTime(Date finishTime)
    {
        this.finishTime = finishTime;
    }

    public String getResultDesc()
    {
        return resultDesc;
    }

    public void setResultDesc(String resultDesc)
    {
        this.resultDesc = resultDesc;
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

    public String getDeviceName()
    {
        return deviceName;
    }

    public void setDeviceName(String deviceName)
    {
        this.deviceName = deviceName;
    }

    public String getPublisherName()
    {
        return publisherName;
    }

    public void setPublisherName(String publisherName)
    {
        this.publisherName = publisherName;
    }

    public String getExecutorName()
    {
        return executorName;
    }

    public void setExecutorName(String executorName)
    {
        this.executorName = executorName;
    }

    @Override
    public String toString()
    {
        return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
                .append("workOrderId", getWorkOrderId())
                .append("title", getTitle())
                .append("taskType", getTaskType())
                .append("targetType", getTargetType())
                .append("areaId", getAreaId())
                .append("plantId", getPlantId())
                .append("deviceId", getDeviceId())
                .append("content", getContent())
                .append("priority", getPriority())
                .append("planTime", getPlanTime())
                .append("deadline", getDeadline())
                .append("publisherId", getPublisherId())
                .append("executorId", getExecutorId())
                .append("status", getStatus())
                .append("acceptTime", getAcceptTime())
                .append("finishTime", getFinishTime())
                .append("resultDesc", getResultDesc())
                .append("createBy", getCreateBy())
                .append("createTime", getCreateTime())
                .append("updateBy", getUpdateBy())
                .append("updateTime", getUpdateTime())
                .append("remark", getRemark())
                .toString();
    }
}

