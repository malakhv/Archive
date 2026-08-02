package com.devlear.themetest;

import android.content.ComponentName;
import android.content.Intent;
import android.content.ServiceConnection;
import android.os.IBinder;
import android.os.RemoteException;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;

public class MainActivity extends AppCompatActivity implements ServiceConnection {

    private TestServiceProxy serviceProxy;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        final Intent intent = new Intent(this, MyService.class);
        serviceProxy = new TestServiceProxy(this);
        bindService(intent, serviceProxy, BIND_AUTO_CREATE);
        //bindService(intent, this, BIND_AUTO_CREATE);

    }

    /**
     * Called when a connection to the Service has been established, with
     * the {@link IBinder} of the communication channel to the
     * Service.
     *
     * @param name    The concrete component name of the service that has
     *                been connected.
     * @param service The IBinder of the Service's communication channel,
     */
    @Override
    public void onServiceConnected(ComponentName name, IBinder service) {
        Log.d("MyService", "Connect!");
        try {
            serviceProxy.getService().play();
            serviceProxy.getService().pause();
        } catch (RemoteException e) {
            e.printStackTrace();
        }
    }

    /**
     * Called when a connection to the Service has been lost.  This typically
     * happens when the process hosting the service has crashed or been killed.
     * This does <em>not</em> remove the ServiceConnection itself -- this
     * binding to the service will remain active, and you will receive a call
     * to {@link #onServiceConnected} when the Service is next running.
     *
     * @param name The concrete component name of the service whose
     *             connection has been lost.
     */
    @Override
    public void onServiceDisconnected(ComponentName name) {

    }

    private class MyServiceProxy extends ServiceProxy<IMyService> {
        @Override
        public void onServiceConnected(ComponentName name, IBinder service) {
            super.onServiceConnected(name, service);
            try {
                getService().play();
            } catch (RemoteException e) {
                e.printStackTrace();
            }
        }
    }


    private static class TestServiceProxy extends ServiceProxy<IMyService> {
        public TestServiceProxy(ServiceConnection connection) {
            super(connection);
        }
    }
}
