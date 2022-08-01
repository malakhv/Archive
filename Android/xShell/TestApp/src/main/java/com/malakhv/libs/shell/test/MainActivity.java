package com.malakhv.libs.shell.test;

import android.app.Activity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;

import com.malakhv.shell.Shell;

public class MainActivity extends Activity implements View.OnClickListener {
    private final static String TAG = "ShellTest";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }

    /**
     * Called when a view has been clicked.
     * @param v The view that was clicked.
     */
    @Override
    public void onClick(View v) {
        final int id = v != null ? v.getId() : 0;

        if (id == R.id.btn_e) {
            Shell.ShellResult result = Shell.execute("ls");
            Log.d(TAG, result.toString());
        }

        if (id == R.id.btn_w) {

        }

        if (id == R.id.btn_i) {

        }

        if (id == R.id.btn_d) {

        }

        if (id == R.id.btn_v) {
            //Shell.execute("reboot");
        }

    }
}