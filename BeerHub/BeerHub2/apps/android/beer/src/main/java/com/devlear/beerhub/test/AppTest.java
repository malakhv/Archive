package com.devlear.beerhub.test;

/**
 * @author Mikhail.Malakhov
 */
class AppTest {

    private boolean mEnabled = false;

    public AppTest(boolean enable) {
        mEnabled = enable;
    }

    public void enable() {
        mEnabled = true;
    }

    public boolean isEnabled() {
        return mEnabled;
    }

}
