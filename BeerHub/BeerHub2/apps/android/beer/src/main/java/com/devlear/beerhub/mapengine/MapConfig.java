package com.devlear.beerhub.mapengine;

import java.util.HashMap;
import java.util.Map;

/**
 * This class contains configs for real map object.
 * @author Mikhail.Malakhov
 * */
public class MapConfig {

    static final String KEY_ZOOM_LEVEL_ME = "zoom_level_me";
    static final String KEY_ZOOM_LEVEL_CITY = "zoom_level_city";
    static final String KEY_ZOOM_LEVEL_COUNTRY = "zoom_level_country";
    static final String KEY_ZOOM_LEVEL_OFF = "zoom_level_off";

    /** The internal configurations storage. */
    private final Map<String, Object> mConfigs = new HashMap<>();

    public void clear() {
        mConfigs.clear();
    }

    public void obtain(MapConfig config) {
        mConfigs.clear();
        mConfigs.putAll(config.mConfigs);
    }

    public boolean put(String key, Object value) {
        if (isCorrectKey(key) &&  value != null) {
            mConfigs.put(key, value);
            return true;
        }
        return false;
    }

    protected Object get(String key) {
        return isCorrectKey(key) ? mConfigs.get(key) : null;
    }

    public String getString(String key) {
        final Object value = get(key);
        return value instanceof String ? (String) value : null;
    }

    public int getInt(String key, int def) {
        final Object value = get(key);
        return value instanceof Integer ? (Integer) value : def;
    }

    public float getFloat(String key, int def) {
        final Object value = get(key);
        return value instanceof Float ? (Float) value : def;
    }

    protected boolean isCorrectKey(String source) {
        // We don't want to use Android TextUtils class to reduce relatedness
        return source != null && !source.isEmpty();
    }

}
