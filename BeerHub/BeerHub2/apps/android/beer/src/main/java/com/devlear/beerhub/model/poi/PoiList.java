package com.devlear.beerhub.model.poi;

import com.devlear.beerhub.data.RowList;

/**
 * @author Mikhail.Malakhov
 */
public class PoiList<E extends PoiObject> extends RowList<E> {

    public PoiList(Class<E> clazz) {
        super(clazz);
    }

    public PoiList(Class<E> clazz, int capacity) {
        super(clazz, capacity);
    }

    public void load(PoiType type, String locale, int max) {
        this.load(type.getTable(), locale, max);
    }

}