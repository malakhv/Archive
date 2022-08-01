package com.malakhv.test.proxy.clazz;

import android.os.IInterface;

public class ClassG1<I extends IInterface> extends ClassG<I> {

    public ClassG1(Class<I> service) {
        super(service);
    }
}
