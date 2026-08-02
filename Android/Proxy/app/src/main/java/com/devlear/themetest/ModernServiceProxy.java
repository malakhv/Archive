package com.devlear.themetest;

import android.os.Binder;
import android.os.IBinder;
import android.os.IInterface;

public class ModernServiceProxy<T extends IInterface> implements IServiceProxy<T> {

    @Override
    public T getService() {
        return null;
    }

    @Override
    public T asInterface(Binder binder) {
        return null;
    }

    @Override
    public IBinder asBinder() {
        return getService().asBinder();
    }
}