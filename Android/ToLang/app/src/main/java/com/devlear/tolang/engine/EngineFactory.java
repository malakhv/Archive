package com.devlear.tolang.engine;

import android.content.Context;

import com.devlear.tolang.engine.mock.MockApi;
import com.devlear.tolang.engine.mock.MockEngine;
import com.devlear.tolang.engine.yandex.YandexEngine;

public class EngineFactory {

    public static ServiceEngine makeEngineFor(Context context, String serviceName) {
        if (serviceName.equals("mock")) {
            final MockEngine engine = new MockEngine();
            engine.setOffline(true);
            engine.setApi(new MockApi());
            return engine;
        }
        if (serviceName.equals("yandex")) {
            final YandexEngine engine = new YandexEngine(context);
            engine.setOffline(false);
            return engine;
        }
        return null;
    }

}
