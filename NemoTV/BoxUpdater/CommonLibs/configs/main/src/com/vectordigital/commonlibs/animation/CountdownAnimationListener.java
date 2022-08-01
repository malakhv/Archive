package com.vectordigital.commonlibs.animation;

import android.view.animation.Animation;

/**
 * Created by a.karmanov on 20.08.13.
 */
public class CountdownAnimationListener implements Animation.AnimationListener {
    protected int count;
    protected Runnable action;

    public CountdownAnimationListener(int count, Runnable action) {
        this.count = count;
        this.action = action;
    }

    @Override
    public void onAnimationStart(Animation animation) {

    }

    @Override
    public void onAnimationEnd(Animation animation) {
        count--;
        if (count == 0) {
            action.run();
        }
    }

    @Override
    public void onAnimationRepeat(Animation animation) {

    }
}
