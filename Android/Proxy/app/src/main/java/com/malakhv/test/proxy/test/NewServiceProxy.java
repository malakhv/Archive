package com.malakhv.test.proxy.test;

import android.os.IInterface;
import android.util.Log;

import java.lang.reflect.ParameterizedType;

public class NewServiceProxy <I extends IInterface> {

    private static final String TAG = "NewServiceProxy";

    public NewServiceProxy() {
        final InternalProxy proxy = new InternalProxy();
    }

    protected String makeInterfaceDescriptor() {
        final InternalProxy proxy = new InternalProxy();
        return proxy.makeInterfaceDescriptor();
    }


    private static class GenericStub<T extends IInterface> {

        private final String DESCRIPTOR;

        public GenericStub() {
            DESCRIPTOR = makeInterfaceDescriptor();
            Log.d(TAG, DESCRIPTOR);
        }

        /**
         * Construct the remote service descriptor. In general case, this is aidl class name.
         * */
        public String makeInterfaceDescriptor() {

            ParameterizedType t = (ParameterizedType) getClass().getGenericSuperclass();
            Log.d(TAG, t.toString());
            Log.d(TAG, "getActualTypeArguments().length = " + t.getActualTypeArguments().length);
            if (t.getActualTypeArguments().length > 0) {
                Log.d(TAG, ((Class<T>) t.getActualTypeArguments()[0]).getName());
            }

           /*return ((Class<T>) ((ParameterizedType) getClass()
                    .getGenericSuperclass()).getActualTypeArguments()[0]).getName(); */
           return "end";
        }
    }

    private final class InternalProxy extends GenericStub<I> {

    }

}
