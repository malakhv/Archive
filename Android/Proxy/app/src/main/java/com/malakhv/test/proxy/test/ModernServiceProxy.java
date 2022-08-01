package com.malakhv.test.proxy.test;

import android.os.Binder;
import android.os.IBinder;
import android.os.IInterface;

import com.malakhv.test.proxy.IServiceProxy;

public class ModernServiceProxy<T extends IInterface> implements IServiceProxy<T> {

    @Override
    public T getService() {
        return null;
    }

    @Override
    public T asInterface(IBinder binder) {
        return null;
    }

    @Override
    public IBinder asBinder() {
        return getService().asBinder();
    }
}