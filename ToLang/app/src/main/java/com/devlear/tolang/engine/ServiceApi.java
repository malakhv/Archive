package com.devlear.tolang.engine;

public interface ServiceApi {
    String makeRequest(ServiceData data);
    ServiceData obtain(String response);
}