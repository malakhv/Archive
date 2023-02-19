package com.devlear.tolang.engine.yandex;

import android.content.Context;

import com.devlear.tolang.R;
import com.devlear.tolang.engine.OnlineEngine;

public class YandexEngine extends OnlineEngine {

    public YandexEngine(Context context) {
        super(null);
        final YandexApi api = new YandexApi();
        api.setApiKey(context.getString(R.string.yandex_api_key));
        api.setHostName(context.getString(R.string.yandex_api_host));
        setApi(api);
    }
}