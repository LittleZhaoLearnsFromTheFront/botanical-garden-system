package com.ruoyi.system.domain.garden;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 区域维护日志表 garden_area_log
 */
public class GardenAreaLog extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 日志ID */
    private Long logId;

    /** 关联工单ID */
    private Long workOrderId;

    /** 区域ID */
    private Long areaId;

    /** 区域名称（联表展示用） */
    private String areaName;

    /** 执行人ID */
    private Long executorId;

    /** 执行人姓名 */
    private String executorName;

    /** 任务类型 */
    private String taskType;

    /** 工单标题 */
    private String title;

    /** 维护内容 */
    private String content;

    /** 执行结果说明 */
    private String resultDesc;

    /** 开始时间（接单时间） */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date startTime;

    /** 完成时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date finishTime;

    /** 记录时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date createTime;

    public Long getLogId()
    {
        return logId;
    }

    public void setLogId(Long logId)
    {
        this.logId = logId;
    }

    public Long getWorkOrderId()
    {
        return workOrderId;
    }

    public void setWorkOrderId(Long workOrderId)
    {
        this.workOrderId = workOrderId;
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

    public Long getExecutorId()
    {
        return executorId;
    }

    public void setExecutorId(Long executorId)
    {
        this.executorId = executorId;
    }

    public String getExecutorName()
    {
        return executorName;
    }

    public void setExecutorName(String executorName)
    {
        this.executorName = executorName;
    }

    public String getTaskType()
    {
        return taskType;
    }

    public void setTaskType(String taskType)
    {
        this.taskType = taskType;
    }

    public String getTitle()
    {
        return title;
    }

    public void setTitle(String title)
    {
        this.title = title;
    }

    public String getContent()
    {
        return content;
    }

    public void setContent(String content)
    {
        this.content = content;
    }

    public String getResultDesc()
    {
        return resultDesc;
    }

    public void setResultDesc(String resultDesc)
    {
        this.resultDesc = resultDesc;
    }

    public Date getStartTime()
    {
        return startTime;
    }

    public void setStartTime(Date startTime)
    {
        this.startTime = startTime;
    }

    public Date getFinishTime()
    {
        return finishTime;
    }

    public void setFinishTime(Date finishTime)
    {
        this.finishTime = finishTime;
    }

    public Date getCreateTime()
    {
        return createTime;
    }

    public void setCreateTime(Date createTime)
    {
        this.createTime = createTime;
    }
}

