package com.devlear.tolang.engine;

public abstract class BaseEngine implements ServiceEngine {

    private ServiceApi mApi = null;
    private ServiceData mData = new ServiceData();
    private boolean mOffline = false;
    private ServiceListener mListener;

    @Override
    public void setData(ServiceData data) {
        mData.obtain(data);
    }

    @Override
    public ServiceData getData() {
        return mData;
    }

    @Override
    public void setApi(ServiceApi api) {
        mApi = api;
    }

    @Override
    public ServiceApi getApi() {
        return mApi;
    }

    @Override
    public boolean isOffline() {
        return mOffline;
    }

    @Override
    public void setOffline(boolean offline) {
        mOffline = offline;
    }

    protected void performTranslate(ServiceData data) {
        if (mListener != null) {
            mListener.onTranslate(data);
        }
    }

    protected void performError(Exception e) {
        if (mListener != null) {
            mListener.onError(e);
        }
    }

    @Override
    public void setListener(ServiceListener listener) {
        mListener = listener;
    }
}
