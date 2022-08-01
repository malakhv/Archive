package com.vectordigital.commonlibs.ui.gesture.helpers;

/**
 * Class for saving basic state of each finger gesture
 * <p/>
 * 12.02.12
 *
 * @author Wild Swift
 */
public class FingerState {
    private Long downTime;
    private int fingerNum = 0;
    private boolean down;

    public Long getDownTime() {
        return downTime;
    }

    public void setDownTime(Long downTime) {
        this.downTime = downTime;
    }

    public int getFingerNum() {
        return fingerNum;
    }

    public void setFingerNum(int fingerNum) {
        this.fingerNum = fingerNum;
    }


    public boolean isDown() {
        return down;
    }

    public void setDown(boolean down) {
        this.down = down;
    }
}
