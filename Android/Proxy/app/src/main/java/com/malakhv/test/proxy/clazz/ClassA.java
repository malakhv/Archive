package com.malakhv.test.proxy.clazz;

import android.os.IInterface;
import android.util.Log;

import java.lang.reflect.ParameterizedType;

class ClassA<T extends IInterface> {

    private static final String TAG = "BaseServiceProxy";

    private final String DESCRIPTOR;

    public ClassA() {
        DESCRIPTOR = makeInterfaceDescriptor();
    }

    /**
     * Construct the remote service descriptor. In general case, this is aidl class name.
     * */
    private String makeInterfaceDescriptor() {
        Log.d(TAG, "===== " + getClass().toString());

        ParameterizedType t = (ParameterizedType) getClass().getGenericSuperclass();
        Log.d(TAG, t.toString());
        Log.d(TAG, "getActualTypeArguments().length = " + t.getActualTypeArguments().length);
        if (t.getActualTypeArguments().length > 0) {
            Log.d(TAG, ((Class<T>) t.getActualTypeArguments()[0]).getName());
        }



        /* return ((Class<T>) ((ParameterizedType) getClass()
                .getGenericSuperclass()).getActualTypeArguments()[0]).getName(); */
        return null;
    }
}

class ClassB<I extends IInterface> extends ClassA<I> {

}
