package com.malakhv.test.proxy;

import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.ServiceConnection;
import android.os.IBinder;
import android.os.IInterface;

import java.lang.reflect.Method;

/**
 * The helper class for connection to remote server.
 * @author Mikhail.Malakhov
 * */
public class ServiceProxy<I extends IInterface> implements IServiceProxy<I> {

    /** The remote service class. */
    private Class<I> mServiceType = null;

    /** The remote service binder. */
    private I mService = null;

    /** Internal service connection listener. */
    private InternalConnection mInternalServiceConnection = new InternalConnection();

    /** The intent for binding to remote service. */
    private Intent mServiceIntent = null;

    /** External service connection object. May be {@code null}. */
    private ServiceConnection mConnectionCallback = null;

    /**
     * Create {@link ServiceProxy} instance with specified parameters.
     * */
    public ServiceProxy(Class<I> service, Intent intent) {
        this(service, intent, null);
    }

    /**
     * Create {@link ServiceProxy} instance with specified parameters.
     * */
    public ServiceProxy(Class<I> service, Intent intent, ServiceConnection conn) {
        mServiceType = service;
        mServiceIntent = intent;
        mConnectionCallback = conn;
    }

    @Override
    public I getService() {
        return mService;
    }

    /** {@inheritDoc} */
    @SuppressWarnings("unchecked")
    @Override
    public I asInterface(IBinder binder) {
        if (binder == null || mServiceType == null) return null;
        Class<?> stub = mServiceType.getClasses()[0];
        try {
            final Method asInterface = stub.getMethod("asInterface", IBinder.class);
            return (I) asInterface.invoke(stub, binder);
        } catch (Exception e) { return null; }
    }

    /**
     * Associates this proxy to the remote service.
     * */
    protected void setService(IBinder service) {
        if (service != null) {
            mService = asInterface(service);
        } else {
            mService = null;
        }
    }

    public boolean bindService(Context context, int flags) {
        if (context == null || mServiceIntent == null) return false;
        return context.bindService(mServiceIntent, mInternalServiceConnection, flags);
    }

    public void unbindService(Context context) {
        if (context == null) return;
        context.unbindService(mInternalServiceConnection);
    }


    protected void performServiceConnected(ComponentName name, IBinder service) {
        if (mConnectionCallback != null) {
            mConnectionCallback.onServiceConnected(name, service);
        }
    }

    protected void performServiceDisconnected(ComponentName name) {
        if (mConnectionCallback != null) {
            mConnectionCallback.onServiceDisconnected(name);
        }
    }

    @Override
    public IBinder asBinder() {
        return null;
    }

    private class InternalConnection implements ServiceConnection {

        @Override
        public void onServiceConnected(ComponentName name, IBinder service) {
            ServiceProxy.this.setService(service);
            ServiceProxy.this.performServiceConnected(name, service);
        }

        @Override
        public void onServiceDisconnected(ComponentName name) {
            ServiceProxy.this.setService((IBinder) null);
            ServiceProxy.this.performServiceDisconnected(name);
        }

        @Override
        public void onBindingDied(ComponentName name) {

        }

        @Override
        public void onNullBinding(ComponentName name) {

        }
    }
}