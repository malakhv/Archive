package com.vectordigital.commonlibs.json.helper;

/**
 * @author Wild Swift
 */
public interface JsonObjectListener {
    public void onStart();

    public void onEnd();

    public void onField(String name, Object value);
}
