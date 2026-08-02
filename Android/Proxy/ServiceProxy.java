package com.devlear.themetest;

import android.content.ComponentName;
import android.content.ServiceConnection;
import android.os.IBinder;
import android.os.IInterface;
import android.util.Log;

import java.lang.reflect.Constructor;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.lang.reflect.ParameterizedType;

public class ServiceProxy<T extends IInterface> implements ServiceConnection {

    private T mService;

    private final String DESCRIPTOR;

    private ServiceConnection mConnectionCallback = null;

    public ServiceProxy() {
        this(null);
    }

    public ServiceProxy(ServiceConnection connection) {
        mConnectionCallback = connection;
        DESCRIPTOR = makeInterfaceDescriptor();
    }

    protected String makeInterfaceDescriptor() {
        return ((Class<T>) ((ParameterizedType) getClass()
                .getGenericSuperclass()).getActualTypeArguments()[0]).getName();
    }

    /** {@inheritDoc} */
    @Override
    public void onServiceConnected(ComponentName name, IBinder service) {
        //mService = IMyService.Stub.asInterface(service);
        mService = asInterface2(service);
        if (mConnectionCallback != null) {
            mConnectionCallback.onServiceConnected(name, service);
        }
    }

    /** {@inheritDoc} */
    @Override
    public void onServiceDisconnected(ComponentName name) {

    }

    public T getService() {
        return mService;
    }

    protected T asInterface(android.os.IBinder obj) {
        if (obj==null) return null;
        IInterface iin = obj.queryLocalInterface(DESCRIPTOR);

        if (iin != null) {
            return (T) iin;
        }


        Class<?> clazz = null;
        try {
            //clazz = Class.forName("com.devlear.themetest.IMyService");
            clazz = Class.forName(DESCRIPTOR);
            Log.d("TestClass", String.valueOf(clazz.getClasses().length));
            Class<?> stub = clazz.getClasses()[0];
            Log.d("TestClass", stub.getCanonicalName());
            Log.d("TestClass", String.valueOf(stub.getDeclaredClasses().length));
            Class<?> proxy = stub.getDeclaredClasses()[0];
            Log.d("TestClass", proxy.getCanonicalName());
            clazz = proxy;

        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        Constructor<?> ctor = null;
        try {
            //ctor = clazz.getConstructor(IBinder.class);
            ctor = clazz.getDeclaredConstructor(IBinder.class);
        } catch (NoSuchMethodException e) {
            e.printStackTrace();
        }
        Object object = null;
        try {
            object = ctor.newInstance(new Object[] { obj });
        } catch (InstantiationException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (InvocationTargetException e) {
            e.printStackTrace();
        }

        return (T) object;
    }

    protected T asInterface2(IBinder binder) {
        if (binder == null) return null;
        Class<?> clazz = null;
        try {
            clazz = Class.forName(DESCRIPTOR);
        } catch (ClassNotFoundException e) { }
        if (clazz == null) return null;
        Class<?> stub = clazz.getClasses()[0];
        Method asInterface = null;
        try {
            asInterface = stub.getMethod("asInterface", IBinder.class);
        } catch (NoSuchMethodException e) { }
        if (asInterface == null) return null;
        try {
            return (T) asInterface.invoke(stub.getClass(), binder);
        } catch (IllegalAccessException e) { }
        catch (InvocationTargetException e) { }
        return null;
    }

    /** {@inheritDoc} */
    @Override
    public void onBindingDied(ComponentName name) {

    }

    /*private static class InternalProxy extends T {

    } */
}