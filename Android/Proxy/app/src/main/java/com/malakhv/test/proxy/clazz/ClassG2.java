package com.malakhv.test.proxy.clazz;


import com.malakhv.test.proxy.IMyService;

public class ClassG2 extends ClassG<IMyService> {

    public ClassG2(Class<IMyService> service) {
        super(service);
    }
}
