package com.devlear.tolang.engine;

public interface ServiceListener {

    void onTranslate(ServiceData data);
    void onError(Exception e);

}