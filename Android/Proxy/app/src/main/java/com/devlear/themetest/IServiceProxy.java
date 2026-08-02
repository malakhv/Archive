package com.devlear.themetest;

import android.os.Binder;
import android.os.IBinder;
import android.os.IInterface;

public interface IServiceProxy<I extends IInterface> extends IInterface {
    I getService();
    I asInterface(Binder binder);
}