// IMyService.aidl
package com.malakhv.test.proxy;

// Declare any non-default types here with import statements

interface IMyService {

    oneway void play();
    oneway void pause();

}