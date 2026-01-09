package com.devlear.tolang.engine.yandex;

import com.devlear.tolang.engine.ServiceApi;
import com.devlear.tolang.engine.ServiceData;

final class YandexApi implements ServiceApi {

    private String mHostName;
    private String mApiKey;

    @Override
    public String makeRequest(ServiceData data) {
        final String request = mHostName + "?" + "key=" + mApiKey
                + "&format=plain"
                + "&lang=" + data.getLangTo()
                + "&text=" + data.getOriginalText();
        return request;
    }

    @Override
    public ServiceData obtain(String response) {
        final ServiceData data = new ServiceData();
        final String S = "<text>";
        final String E = "</text>";
        int pS = response.indexOf(S);
        int pE = response.indexOf(E, pS);
        if (pE > pS) data.setTranslation(response.substring(pS + S.length(), pE));
        return data;
    }

    public void setHostName(String host) {
        mHostName = host;
    }

    public void setApiKey(String key) {
        mApiKey = key;
    }
}