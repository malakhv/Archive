package com.malakhv.test.proxy;

import android.os.IBinder;
import android.os.IInterface;

public interface IServiceProxy<I extends IInterface> extends IInterface {

    /**
     * @return The remote service binder.
     * */
    I getService();

    /**
     * Represents a binder object as typed interface.
     * */
    I asInterface(IBinder binder);

}