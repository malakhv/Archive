package com.devlear.app.beerhub.util;

/**
 * @author Mikhail.Malakhov
 * */
public class Device {

    public static boolean isEmulator() {
        return false;
    }

    public static boolean isRealDevice() {
        return !isEmulator();
    }

}