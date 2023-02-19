package com.devlear.tolang.engine.mock;

import android.os.Handler;

import com.devlear.tolang.engine.BaseEngine;
import com.devlear.tolang.engine.ServiceApi;
import com.devlear.tolang.engine.ServiceData;

public class MockEngine extends BaseEngine {

    private final Handler handler = new Handler();

    @Override
    public void translate() {
        handler.postDelayed(translationRunnable, 200);
    }

    private Runnable translationRunnable = new Runnable() {
        @Override
        public void run() {
            translateInternal(getData());
        }
    };

    private void translateInternal(ServiceData data) {
        if (data == null) return;
        final ServiceApi api = getApi();
        if (api == null) return;
        String request = api.makeRequest(data);
        final ServiceData responce = api.obtain(request);
        performTranslate(responce);
    }
}
