/* *
 * Copyright (C) 2018 DevLear - All Rights Reserved.
 *
 * This file is a part of BeerHub application.
 *
 * Confidential and Proprietary.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 * */

package com.devlear.app.beerhub.settings;

import android.content.Context;

/**
 * Class contains methods for managing app settings.
 * @author Mikhail.Malahov
 * */
@SuppressWarnings({"WeakerAccess","unused"})
public class SettingsManager {

    /** The map used: Google map. */
    public static final int SETTING_MAP_USED_GOOGLE = 1;

    /** The map used: Yandex map. */
    public static final int SETTING_MAP_USED_YANDEX = 2;

    /** The map used: Mapy.cz map. */
    public static final int SETTING_MAP_USED_MAPYCZ = 3;

    /** The map used: MAPS.ME map. */
    public static final int SETTING_MAP_USED_MAPSME = 3;

    /**
     * The current used map. One of: {@link #SETTING_MAP_USED_GOOGLE},
     * {@link #SETTING_MAP_USED_YANDEX}, {@link #SETTING_MAP_USED_MAPYCZ} or
     * {@link #SETTING_MAP_USED_MAPSME}.
     * */
    public static final String SETTING_MAP_USED = "map_used";

    /**
     * @return The current used map.
     * @see #SETTING_MAP_USED
     * */
    public static int getMapUsed(Context context) {
        // TODO Need to retrieve this value from SharedPreference
        return SETTING_MAP_USED_GOOGLE;
    }

}
