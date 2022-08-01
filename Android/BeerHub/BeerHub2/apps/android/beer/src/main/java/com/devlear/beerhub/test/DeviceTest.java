package com.devlear.beerhub.test;

/**
 * @author Mikhail.Malakhov
 */
public final class DeviceTest extends AppTest {

    private final static boolean IS_SUPPORTED_DEVICE = false;

    public DeviceTest(boolean enable) {
        super(enable);
    }

    public boolean isSupportedDevice() {
        return IS_SUPPORTED_DEVICE;
    }
}
