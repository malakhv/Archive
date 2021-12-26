package com.malakhv.test.proxy.clazz;

import android.os.IInterface;

public class ClassD<I extends IInterface> {

    private Proxy proxy;

    public ClassD() {
        proxy = new Proxy();
    }

    private class Proxy extends ClassB<I> {}


}
