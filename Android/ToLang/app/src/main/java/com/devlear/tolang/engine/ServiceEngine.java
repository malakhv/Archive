package com.devlear.tolang.engine;

public interface ServiceEngine {

    void setData(ServiceData data);
    ServiceData getData();

    void setApi(ServiceApi api);
    ServiceApi getApi();

    boolean isOffline();
    void setOffline(boolean offline);

    void translate();

    void setListener(ServiceListener listener);

}