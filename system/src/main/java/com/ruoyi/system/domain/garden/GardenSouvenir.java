package com.ruoyi.system.domain.garden;

import java.math.BigDecimal;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 纪念品表 garden_souvenir
 */
public class GardenSouvenir extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 纪念品ID */
    private Long souvenirId;

    /** 纪念品名称 */
    @Excel(name = "纪念品名称")
    private String souvenirName;

    /** 纪念品编码 */
    @Excel(name = "纪念品编码")
    private String souvenirCode;

    /** 分类 */
    @Excel(name = "分类")
    private String category;

    /** 单价 */
    @Excel(name = "单价")
    private BigDecimal price;

    /** 库存数量 */
    @Excel(name = "库存数量")
    private Integer stock;

    /** 状态（0正常 1停用） */
    @Excel(name = "状态", readConverterExp = "0=正常,1=停用")
    private String status;

    /** 删除标志（0代表存在 2代表删除） */
    private String delFlag;

    public Long getSouvenirId()
    {
        return souvenirId;
    }

    public void setSouvenirId(Long souvenirId)
    {
        this.souvenirId = souvenirId;
    }

    public String getSouvenirName()
    {
        return souvenirName;
    }

    public void setSouvenirName(String souvenirName)
    {
        this.souvenirName = souvenirName;
    }

    public String getSouvenirCode()
    {
        return souvenirCode;
    }

    public void setSouvenirCode(String souvenirCode)
    {
        this.souvenirCode = souvenirCode;
    }

    public String getCategory()
    {
        return category;
    }

    public void setCategory(String category)
    {
        this.category = category;
    }

    public BigDecimal getPrice()
    {
        return price;
    }

    public void setPrice(BigDecimal price)
    {
        this.price = price;
    }

    public Integer getStock()
    {
        return stock;
    }

    public void setStock(Integer stock)
    {
        this.stock = stock;
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
                .append("souvenirId", getSouvenirId())
                .append("souvenirName", getSouvenirName())
                .append("souvenirCode", getSouvenirCode())
                .append("category", getCategory())
                .append("price", getPrice())
                .append("stock", getStock())
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

