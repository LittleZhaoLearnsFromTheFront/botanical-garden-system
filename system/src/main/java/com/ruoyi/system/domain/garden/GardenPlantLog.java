package com.ruoyi.system.domain.garden;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 植物维护日志表 garden_plant_log
 */
public class GardenPlantLog extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    private Long logId;

    private Long workOrderId;

    private Long plantId;

    private String plantName;

    private Long executorId;

    private String executorName;

    /** 任务类型 */
    private String taskType;

    private String title;

    private String content;

    private String resultDesc;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date startTime;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date finishTime;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date createTime;

    public Long getLogId() { return logId; }
    public void setLogId(Long logId) { this.logId = logId; }

    public Long getWorkOrderId() { return workOrderId; }
    public void setWorkOrderId(Long workOrderId) { this.workOrderId = workOrderId; }

    public Long getPlantId() { return plantId; }
    public void setPlantId(Long plantId) { this.plantId = plantId; }

    public String getPlantName() { return plantName; }
    public void setPlantName(String plantName) { this.plantName = plantName; }

    public Long getExecutorId() { return executorId; }
    public void setExecutorId(Long executorId) { this.executorId = executorId; }

    public String getExecutorName() { return executorName; }
    public void setExecutorName(String executorName) { this.executorName = executorName; }

    public String getTaskType() { return taskType; }
    public void setTaskType(String taskType) { this.taskType = taskType; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public String getResultDesc() { return resultDesc; }
    public void setResultDesc(String resultDesc) { this.resultDesc = resultDesc; }

    public Date getStartTime() { return startTime; }
    public void setStartTime(Date startTime) { this.startTime = startTime; }

    public Date getFinishTime() { return finishTime; }
    public void setFinishTime(Date finishTime) { this.finishTime = finishTime; }

    public Date getCreateTime() { return createTime; }
    public void setCreateTime(Date createTime) { this.createTime = createTime; }
}

