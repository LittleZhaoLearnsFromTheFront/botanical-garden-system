package com.ruoyi.system.service.garden.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.system.domain.garden.GardenSouvenir;
import com.ruoyi.system.mapper.garden.GardenSouvenirMapper;
import com.ruoyi.system.service.garden.IGardenSouvenirService;

@Service
public class GardenSouvenirServiceImpl implements IGardenSouvenirService
{
    @Autowired
    private GardenSouvenirMapper souvenirMapper;

    @Override
    public GardenSouvenir selectSouvenirById(Long souvenirId)
    {
        return souvenirMapper.selectSouvenirById(souvenirId);
    }

    @Override
    public List<GardenSouvenir> selectSouvenirList(GardenSouvenir souvenir)
    {
        return souvenirMapper.selectSouvenirList(souvenir);
    }

    @Override
    public int insertSouvenir(GardenSouvenir souvenir)
    {
        return souvenirMapper.insertSouvenir(souvenir);
    }

    @Override
    public int updateSouvenir(GardenSouvenir souvenir)
    {
        return souvenirMapper.updateSouvenir(souvenir);
    }

    @Override
    public int deleteSouvenirById(Long souvenirId)
    {
        return souvenirMapper.deleteSouvenirById(souvenirId);
    }

    @Override
    public int deleteSouvenirByIds(Long[] souvenirIds)
    {
        return souvenirMapper.deleteSouvenirByIds(souvenirIds);
    }
}

