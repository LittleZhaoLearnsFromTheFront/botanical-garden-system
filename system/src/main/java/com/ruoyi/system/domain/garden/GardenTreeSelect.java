package com.ruoyi.system.domain.garden;

import java.io.Serializable;
import java.util.List;
import java.util.stream.Collectors;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.ruoyi.common.constant.UserConstants;
import com.ruoyi.common.utils.StringUtils;

/**
 * 区域下拉树结构实体类（供前端 Treeselect 使用）
 */
public class GardenTreeSelect implements Serializable
{
    private static final long serialVersionUID = 1L;

    /** 节点ID */
    private Long id;

    /** 节点名称 */
    private String label;

    /** 节点禁用 */
    private boolean disabled = false;

    /** 子节点 */
    @JsonInclude(JsonInclude.Include.NON_EMPTY)
    private List<GardenTreeSelect> children;

    public GardenTreeSelect()
    {
    }

    public GardenTreeSelect(GardenArea area)
    {
        this.id = area.getAreaId();
        this.label = area.getAreaName();
        this.disabled = StringUtils.equals(UserConstants.DEPT_DISABLE, area.getStatus());
        this.children = area.getChildren().stream().map(GardenTreeSelect::new).collect(Collectors.toList());
    }

    public Long getId()
    {
        return id;
    }

    public void setId(Long id)
    {
        this.id = id;
    }

    public String getLabel()
    {
        return label;
    }

    public void setLabel(String label)
    {
        this.label = label;
    }

    public boolean isDisabled()
    {
        return disabled;
    }

    public void setDisabled(boolean disabled)
    {
        this.disabled = disabled;
    }

    public List<GardenTreeSelect> getChildren()
    {
        return children;
    }

    public void setChildren(List<GardenTreeSelect> children)
    {
        this.children = children;
    }
}

