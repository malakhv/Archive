package com.malakhv.test.proxy;

import android.app.Activity;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.ServiceConnection;
import android.os.Bundle;
import android.os.IBinder;
import android.os.RemoteException;

public class MainActivity extends Activity implements ServiceConnection {

    private MyServiceProxy myService;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        myService = new MyServiceProxy(this, this);
        myService.bindService(this, BIND_AUTO_CREATE);
    }

    @Override
    public void onServiceConnected(ComponentName name, IBinder service) {
        try {
            myService.getService().play();
            myService.getService().pause();
        } catch (RemoteException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void onServiceDisconnected(ComponentName name) {

    }

    private static class MyServiceProxy extends ServiceProxy<IMyService> {
        public MyServiceProxy(Context context, ServiceConnection conn) {
            super(IMyService.class, new Intent(context, MyService.class), conn);
        }
    }

}
