package com.malakhv.test.proxy.test;

import android.content.ComponentName;
import android.content.ServiceConnection;
import android.os.IBinder;
import android.os.IInterface;
import android.util.Log;

import java.lang.reflect.Constructor;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.lang.reflect.ParameterizedType;

/**
 * Universal service proxy.
 * @author Mikhail.Malakhov
 * */
public abstract class ServiceProxy<T extends IInterface> implements ServiceConnection {

    private static final String TAG = "BaseServiceProxy";

    /** The service binder object. */
    private T mService;

    /** The remote service descriptor. In general case, this is aidl class name. */
    private final String DESCRIPTOR;

    /** External service connection object. May be {@code null}. */
    private ServiceConnection mConnectionCallback = null;

    /**
     * Constructs the new {@link ServiceProxy} instance.
     * */
    public ServiceProxy() {
        this(null);
    }

    /**
     * Constructs the new {@link ServiceProxy} instance with specified parameters.
     * */
    public ServiceProxy(ServiceConnection connection) {
        mConnectionCallback = connection;
        DESCRIPTOR = makeInterfaceDescriptor();
    }

    public abstract Class<T> getXType();

    /**
     * Construct the remote service descriptor. In general case, this is aidl class name.
     * */
    protected String makeInterfaceDescriptor() {
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

    /** {@inheritDoc} */
    @Override
    public void onServiceConnected(ComponentName name, IBinder service) {
        mService = asInterface(service);
        performServiceConnected(name, service);
    }

    /***/
    protected void performServiceConnected(ComponentName name, IBinder service) {
        if (mConnectionCallback != null) {
            mConnectionCallback.onServiceConnected(name, service);
        }
    }

    /** {@inheritDoc} */
    @Override
    public void onServiceDisconnected(ComponentName name) {
        mService = null;
    }

    /** {@inheritDoc} */
    @Override
    public void onBindingDied(ComponentName name) {

    }

    public T getService() {
        return mService;
    }

    protected T asInterface1(IBinder obj) {
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

    /**
     * Represents specified binder object as related interface.
     * */
    protected T asInterface(IBinder binder) {
        if (binder == null) return null;
        if (DESCRIPTOR == null) return null;

        // Retrieving a class
        Class<?> clazz = null;
        try {
            clazz = Class.forName(DESCRIPTOR);
        } catch (ClassNotFoundException e) { }
        if (clazz == null) return null;

        // Retrieving a "Stub" class and call original "asInterface" method
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

        // WTF?
        return null;
    }

    private static abstract class BaseInternalProxy<E extends IInterface> {};
    private class InternalProxy extends BaseInternalProxy<T> {};
}