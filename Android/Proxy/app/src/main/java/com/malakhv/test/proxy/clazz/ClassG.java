package com.malakhv.test.proxy.clazz;

import android.os.IInterface;
import android.util.Log;

public abstract class ClassG<T extends IInterface> {

    private static final String TAG = "ServiceProxyG";

    public ClassG(Class<T> service) {
        Log.d(TAG, service.getName());
    }

}
