package com.vectordigital.commonlibs.application;

import android.app.Activity;
import android.app.Application;
import android.app.Instrumentation;
import android.os.Bundle;

/**
 * Created by a.karmanov on 27.09.13.
 */
public class DebugInstrumentation extends Instrumentation {


    @Override
    public void callActivityOnCreate(Activity activity, Bundle icicle) {
        super.callActivityOnCreate(activity, icicle);
    }

    @Override
    public void callApplicationOnCreate(Application app) {
//        if (!(app instanceof BaseApplication)) throw new

        super.callApplicationOnCreate(app);
    }


}
