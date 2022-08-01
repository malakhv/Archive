package com.devlear.beerhub.mapengine;


/**
 * @author Mikhail.Malakhov
 */
public enum MapType {

    NONE, GOOGLE, YANDEX, MAPBOX, MAPYCZ, TEST;

    /** {@inheritDoc} */
    @Override
    public String toString() {
        return super.toString().toLowerCase();
    }
}
