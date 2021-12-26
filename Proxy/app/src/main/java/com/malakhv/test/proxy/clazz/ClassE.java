package com.malakhv.test.proxy.clazz;

import android.os.IInterface;
import android.util.Log;

import java.lang.reflect.Method;

public class ClassE<T extends IInterface> {

    private static final String TAG = "ServiceProxyE";

    public T dummy() { return null; }

    public ClassE() {
        Log.d(TAG, "Class - " + getName());
    }

    private String getName() {
        final Method m = getMethod(getClass(),"dummy");
        return m != null ? m.getReturnType().getName() : null;

        /* try {
            Class<?> c = this.getClass().getDeclaredMethod("dummy", long.class).getReturnType();
            //Log.d(TAG, c.toString());
            return c.getName();
        } catch (NoSuchMethodException e) {
            e.printStackTrace();
            return null;
        } */
    }


    private Method getMethod(Class<?> clazz, String method) {
        if (clazz == null) return null;
        try {
            final Method m = clazz.getMethod(method);
            return m;
        } catch (NoSuchMethodException e) {
            return getMethod(clazz.getSuperclass(), method);
        }
    }


    public String getServiceClassName() {
        String res = null;
        try {
            Class<?> c = this.getClass().getDeclaredMethod("dummy").getReturnType();
            Log.d(TAG, c.toString());
            res = c.getName();
        } catch (NoSuchMethodException e) {
            e.printStackTrace();
        }
        return res;
    }

    public ClassE(Class<? extends IInterface> service) {
        Log.d(TAG, service.getName());
        //getServiceClassName();
    }

}
