package com.devlear.beerhub.mapengine;

import android.os.Bundle;

import androidx.annotation.Nullable;

import com.devlear.beerhub.R;
import com.devlear.beerhub.model.poi.PoiObject;

/**
 * @author Mikhail.Malakhov
 */
public class TestMapEngineActivity extends MapActivity<PoiObject> {

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.act_city_map);
    }

    /**
     * Makes the data item that represents database row that activity was started for. In future
     * implementation you should create instance and configure it, if needed.
     */
    @Override
    protected PoiObject makeDataItem() {
        return new PoiObject();
    }
}
