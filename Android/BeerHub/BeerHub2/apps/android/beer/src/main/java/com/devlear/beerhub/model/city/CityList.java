/* *
 * Copyright (C) 2018 DevLear - All Rights Reserved.
 *
 * This file is a part of BeerHub application.
 *
 * Confidential and Proprietary.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 * */

package com.devlear.beerhub.model.city;

import com.devlear.beerhub.data.LocaleHelper;
import com.devlear.beerhub.model.poi.PoiList;
import com.devlear.beerhub.model.poi.PoiType;

/**
 * Class represents the list of cities.
 * @author Mikhail.Malakhov
 * */
public class CityList extends PoiList<CityObject> {

    /**
     * Construct a new {@link CityList} instance with default parameters.
     * */
    public CityList() {
        super(CityObject.class);
    }

    /** {@inheritDoc} */
    @Override
    public void update() {
        super.update();
        load(PoiType.CITY.getTable(), LocaleHelper.getCurrentLocale());
    }
}