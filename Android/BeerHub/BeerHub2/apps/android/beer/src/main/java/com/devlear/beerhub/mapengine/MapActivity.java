package com.devlear.beerhub.mapengine;

import com.devlear.beerhub.data.RowObject;
import com.devlear.beerhub.model.DataActivity;

/**
 * @author Mikhail.Malakhov
 */
public abstract class MapActivity<D extends RowObject> extends DataActivity<D>
        implements MapCallbacks {

    /** The engine for real map. */
    private MapEngine mMapEngine = null;

    /**
     * Returns current map engine to interact with real map.
     * */
    protected MapEngine getMapEngine() {
        return mMapEngine;
    }

    /**
     * Returns {@code true}  when real map exists and ready to use.
     * */
    protected boolean hasMap() {
        return mMapEngine != null && mMapEngine.hasMap();
    }

    /** {@inheritDoc} */
    @Override
    protected void onStart() {
        super.onStart();
        if (mMapEngine == null || !mMapEngine.hasMap()) {
            //TODO We want to receive map type from settings
            MapMaker.makeMapEngineForActivity(this, this, MapType.GOOGLE);
        }
    }

    /** {@inheritDoc} */
    @Override
    public void onMapReady(MapEngine engine) {
        // In this point we are ready to interact with real map
        mMapEngine = engine;
    }

    /** {@inheritDoc} */
    @Override
    public void onMapFail() {
        // Do nothing
    }
}
