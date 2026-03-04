package com.ruoyi.system.mapper.garden;

import java.util.List;
import com.ruoyi.system.domain.garden.GardenSouvenir;

/**
 * 纪念品 数据层
 */
public interface GardenSouvenirMapper
{
    public GardenSouvenir selectSouvenirById(Long souvenirId);

    public List<GardenSouvenir> selectSouvenirList(GardenSouvenir souvenir);

    public int insertSouvenir(GardenSouvenir souvenir);

    public int updateSouvenir(GardenSouvenir souvenir);

    public int deleteSouvenirById(Long souvenirId);

    public int deleteSouvenirByIds(Long[] souvenirIds);
}

