package com.ruoyi.system.service.garden.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.domain.garden.GardenCareAdvice;
import com.ruoyi.system.mapper.garden.GardenCareAdviceMapper;
import com.ruoyi.system.service.garden.IGardenCareAdviceService;

/**
 * 智能养护建议 服务实现
 */
@Service
public class GardenCareAdviceServiceImpl implements IGardenCareAdviceService
{
    @Autowired
    private GardenCareAdviceMapper careAdviceMapper;

    @Override
    public GardenCareAdvice selectCareAdviceById(Long adviceId)
    {
        return careAdviceMapper.selectCareAdviceById(adviceId);
    }

    @Override
    public List<GardenCareAdvice> selectCareAdviceList(GardenCareAdvice advice)
    {
        return careAdviceMapper.selectCareAdviceList(advice);
    }

    @Override
    public int insertCareAdvice(GardenCareAdvice advice)
    {
        return careAdviceMapper.insertCareAdvice(advice);
    }

    @Override
    public int updateCareAdvice(GardenCareAdvice advice)
    {
        return careAdviceMapper.updateCareAdvice(advice);
    }

    @Override
    public int deleteCareAdviceByIds(Long[] adviceIds)
    {
        return careAdviceMapper.deleteCareAdviceByIds(adviceIds);
    }

    @Override
    public GardenCareAdvice selectLatestPublishedByTarget(String targetType, Long targetId)
    {
        return careAdviceMapper.selectLatestPublishedByTarget(targetType, targetId);
    }
}

