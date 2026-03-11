package com.ruoyi.system.domain.garden;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 智能养护建议表 garden_care_advice
 */
public class GardenCareAdvice extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 建议ID */
    private Long adviceId;

    /** 目标类型（PLANT/AREA/DEVICE），MVP 先用 PLANT */
    @Excel(name = "目标类型")
    private String targetType;

    /** 目标ID（植物/区域/设备） */
    @Excel(name = "目标ID")
    private Long targetId;

    /** 建议类型（ROUTINE/ABNORMAL/SEASONAL/PEST...） */
    @Excel(name = "建议类型")
    private String adviceType;

    /** 标题 */
    @Excel(name = "标题")
    private String title;

    /** 内容（给人看的文本/Markdown） */
    private String contentMd;

    /** 结构化内容 JSON（步骤/频次/用量/风险等） */
    private String contentJson;

    /** 证据 JSON（引用档案/日志/工单的摘要与ID） */
    private String evidenceJson;

    /** 风险等级（0低 1中 2高） */
    @Excel(name = "风险等级", readConverterExp = "0=低,1=中,2=高")
    private String riskLevel;

    /** 置信度（0-100） */
    private Integer confidence;

    /** 状态（1待审核 2已通过 3已拒绝） */
    @Excel(name = "状态", readConverterExp = "1=待审核,2=已通过,3=已拒绝")
    private String status;

    /** 审核人 */
    private String reviewBy;

    /** 审核时间 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date reviewTime;

    /** 审核备注 */
    private String reviewNote;

    /** 有效期开始 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date validFrom;

    /** 有效期结束 */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date validTo;

    /** AI provider */
    private String aiProvider;

    /** AI model */
    private String aiModel;

    /** prompt 版本 */
    private String promptVersion;

    /** 关联展示字段：植物名称（查询用） */
    private String plantName;

    /** 关联展示字段：区域名称（查询用） */
    private String areaName;

    /** 已转工单ID（每条建议只允许转一次工单） */
    private Long linkedWorkOrderId;

    public Long getAdviceId()
    {
        return adviceId;
    }

    public void setAdviceId(Long adviceId)
    {
        this.adviceId = adviceId;
    }

    public String getTargetType()
    {
        return targetType;
    }

    public void setTargetType(String targetType)
    {
        this.targetType = targetType;
    }

    public Long getTargetId()
    {
        return targetId;
    }

    public void setTargetId(Long targetId)
    {
        this.targetId = targetId;
    }

    public String getAdviceType()
    {
        return adviceType;
    }

    public void setAdviceType(String adviceType)
    {
        this.adviceType = adviceType;
    }

    public String getTitle()
    {
        return title;
    }

    public void setTitle(String title)
    {
        this.title = title;
    }

    public String getContentMd()
    {
        return contentMd;
    }

    public void setContentMd(String contentMd)
    {
        this.contentMd = contentMd;
    }

    public String getContentJson()
    {
        return contentJson;
    }

    public void setContentJson(String contentJson)
    {
        this.contentJson = contentJson;
    }

    public String getEvidenceJson()
    {
        return evidenceJson;
    }

    public void setEvidenceJson(String evidenceJson)
    {
        this.evidenceJson = evidenceJson;
    }

    public String getRiskLevel()
    {
        return riskLevel;
    }

    public void setRiskLevel(String riskLevel)
    {
        this.riskLevel = riskLevel;
    }

    public Integer getConfidence()
    {
        return confidence;
    }

    public void setConfidence(Integer confidence)
    {
        this.confidence = confidence;
    }

    public String getStatus()
    {
        return status;
    }

    public void setStatus(String status)
    {
        this.status = status;
    }

    public String getReviewBy()
    {
        return reviewBy;
    }

    public void setReviewBy(String reviewBy)
    {
        this.reviewBy = reviewBy;
    }

    public Date getReviewTime()
    {
        return reviewTime;
    }

    public void setReviewTime(Date reviewTime)
    {
        this.reviewTime = reviewTime;
    }

    public String getReviewNote()
    {
        return reviewNote;
    }

    public void setReviewNote(String reviewNote)
    {
        this.reviewNote = reviewNote;
    }

    public Date getValidFrom()
    {
        return validFrom;
    }

    public void setValidFrom(Date validFrom)
    {
        this.validFrom = validFrom;
    }

    public Date getValidTo()
    {
        return validTo;
    }

    public void setValidTo(Date validTo)
    {
        this.validTo = validTo;
    }

    public String getAiProvider()
    {
        return aiProvider;
    }

    public void setAiProvider(String aiProvider)
    {
        this.aiProvider = aiProvider;
    }

    public String getAiModel()
    {
        return aiModel;
    }

    public void setAiModel(String aiModel)
    {
        this.aiModel = aiModel;
    }

    public String getPromptVersion()
    {
        return promptVersion;
    }

    public void setPromptVersion(String promptVersion)
    {
        this.promptVersion = promptVersion;
    }

    public String getPlantName()
    {
        return plantName;
    }

    public void setPlantName(String plantName)
    {
        this.plantName = plantName;
    }

    public String getAreaName()
    {
        return areaName;
    }

    public void setAreaName(String areaName)
    {
        this.areaName = areaName;
    }

    public Long getLinkedWorkOrderId()
    {
        return linkedWorkOrderId;
    }

    public void setLinkedWorkOrderId(Long linkedWorkOrderId)
    {
        this.linkedWorkOrderId = linkedWorkOrderId;
    }
}

