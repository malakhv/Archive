package com.malakhv.test.proxy;

import android.app.Service;
import android.content.Intent;
import android.os.IBinder;
import android.os.RemoteException;
import android.util.Log;

public class MyService extends Service {
    private static final String TAG = "MyService";

    private final MyBinder mBinder = new MyBinder();

    /** {@inheritDoc} */
    @Override
    public IBinder onBind(Intent intent) {
        return mBinder;
    }

    @Override
    public void onCreate() {
        super.onCreate();
    }

    private class MyBinder extends IMyService.Stub {

        @Override
        public void play() throws RemoteException {
            Log.d(TAG, "play");
        }

        @Override
        public void pause() throws RemoteException {
            Log.d(TAG, "pause");
        }
    }
}
