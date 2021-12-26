package com.malakhv.util;

/**
 * @author Mikhail.Malakhov [malakhv@live.ru|https://github.com/malakhv]
 * */
public final class CpuInfo {

    /**
     * @return The number of available CPUs on device.
     * */
    public static int getCount() { return getCount_native(); }

    /**
     * @return The frequency on specified CPU (by number), or -1, if CPU with specified number does
     * not available.
     * */
    public static int getFreq(int number) {
        return getFreq_native(number);
    }


    public static String getAlll() {
        return getAll();
    }

    public static int strToInt() {
        return strToInt_native();
    }

    /*----------------------------------------------------------------------------------------*/
    /* Native (for more details, please, see jni code).
    /*----------------------------------------------------------------------------------------*/

    private static native int getCount_native();
    private static native int getOnline_native();
    private static native int getOffline_native();
    private static native int getPossible_native();
    private static native String getAll();
    private static native int getFreq_native(int number);

    private static native int strToInt_native();

    static {
        System.loadLibrary("cpu_native");
    }

}
