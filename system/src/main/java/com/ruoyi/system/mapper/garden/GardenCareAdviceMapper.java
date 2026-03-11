package com.ruoyi.system.mapper.garden;

import java.util.List;
import com.ruoyi.system.domain.garden.GardenCareAdvice;

/**
 * 智能养护建议 数据层
 */
public interface GardenCareAdviceMapper
{
    public GardenCareAdvice selectCareAdviceById(Long adviceId);

    public List<GardenCareAdvice> selectCareAdviceList(GardenCareAdvice advice);

    public int insertCareAdvice(GardenCareAdvice advice);

    public int updateCareAdvice(GardenCareAdvice advice);

    public int deleteCareAdviceById(Long adviceId);

    public int deleteCareAdviceByIds(Long[] adviceIds);

    public GardenCareAdvice selectLatestPublishedByTarget(String targetType, Long targetId);
}

