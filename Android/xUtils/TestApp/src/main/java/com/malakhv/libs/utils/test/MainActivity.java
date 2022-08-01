package com.malakhv.libs.utils.test;

import android.app.Activity;
import android.app.ActivityManager;
import android.os.Bundle;
import android.os.Debug;
import android.util.Log;
import android.util.TimeUtils;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.TextView;

import com.malakhv.util.CpuInfo;
import com.malakhv.util.DateTime;

import java.util.Calendar;
import java.util.TimeZone;

public class MainActivity extends Activity implements View.OnClickListener {
    private final static String TAG = "LibTest";
    private TextView mLog = null;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        mLog = (TextView) this.findViewById(R.id.log);
    }

    private void clearLog() { mLog.setText(""); }

    private void toLog(String... strings) {
        if (strings == null || strings.length <= 0) return;
        for (String str: strings) {
            mLog.append(str); mLog.append("\n");
        }
    }

    /**
     * Called when a view has been clicked.
     * @param v The view that was clicked.
     */
    @Override
    public void onClick(View v) {
        final int id = v != null ? v.getId() : 0;
        clearLog();
        if (id == R.id.btn_1) doAction1();
        if (id == R.id.btn_2) doAction2();
        if (id == R.id.btn_3) doAction3();
        if (id == R.id.btn_4) doAction4();
        if (id == R.id.btn_5) doAction5();
    }

    private void doAction1() {
        toLog("DateTime test");
        Calendar calendar = Calendar.getInstance();
        long time = calendar.getTimeInMillis();
        int h1 = calendar.get(Calendar.HOUR_OF_DAY);
        int m1 = calendar.get(Calendar.MINUTE);
        toLog("Current time - " + h1 + ":" + m1);

        int h2 = DateTime.getHourOfDay(time, TimeZone.getDefault());
        int m2 = DateTime.getMinuteOfHour(time);
        toLog("Calculated time - " + h2 + ":" + m2);
        toLog(" ");


        // Time Intersects 1 (true)
        long s1 = DateTime.getMillis(7, 30);
        long e1 = DateTime.getMillis(17, 42);
        long s2 = DateTime.getMillis(13, 20);
        long e2 = DateTime.getMillis(18, 37);
        toLog("7:30-17:42 and 13:20-18:37 intersect: " +
                DateTime.isTimeIntersects(s1, e1, s2, e2));

        // Time Intersects 2 (false)
        s1 = DateTime.getMillis(7, 30);
        e1 = DateTime.getMillis(17, 42);
        s2 = DateTime.getMillis(18, 20);
        e2 = DateTime.getMillis(18, 37);
        toLog("7:30-17:42 and 18:20-18:37 intersect: " +
                DateTime.isTimeIntersects(s1, e1, s2, e2));

        // Time Intersects 2 (over midnight, true)
        s1 = DateTime.getMillis(20, 30);
        e1 = DateTime.getMillis(7, 00);
        s2 = DateTime.getMillis(23, 52);
        e2 = DateTime.getMillis(04, 37);
        toLog("20:30-07:00 and 23:52-04:37 intersect: " +
                DateTime.isTimeIntersects(s1, e1, s2, e2));

        // Time Intersects 2 (over midnight, true)
        s1 = DateTime.getMillis(20, 30);
        e1 = DateTime.getMillis(7, 00);
        s2 = DateTime.getMillis(21, 52);
        e2 = DateTime.getMillis(22, 37);
        toLog("20:30-07:00 and 21:52-22:37 intersect: " +
                DateTime.isTimeIntersects(s1, e1, s2, e2));

        // Time Intersects 2 (over midnight, true)
        s1 = DateTime.getMillis(20, 30);
        e1 = DateTime.getMillis(7, 00);
        s2 = DateTime.getMillis(19, 52);
        e2 = DateTime.getMillis(17, 10);
        toLog("20:30-07:00 and 19:52-17:10 intersect: " +
                DateTime.isTimeIntersects(s1, e1, s2, e2));

        // Time Intersects 2 (over midnight, false)
        s1 = DateTime.getMillis(20, 30);
        e1 = DateTime.getMillis(7, 00);
        s2 = DateTime.getMillis(8, 52);
        e2 = DateTime.getMillis(17, 10);
        toLog("20:30-07:00 and 08:52-17:10 intersect: " +
                DateTime.isTimeIntersects(s1, e1, s2, e2));

    }

    private void doAction2() {
        toLog("Action 2");
        //toLog(String.valueOf(CpuInfo.getCount()));
        //toLog(String.valueOf(CpuInfo.getFreq(0)));
        toLog(CpuInfo.getAlll());
        toLog(String.valueOf(CpuInfo.strToInt()));
    }

    private void doAction3() {
        toLog("Action 3");
    }

    private void doAction4() {
        toLog("Action 4");
    }

    private void doAction5() {
        toLog("Action 5");
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.main, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        clearLog();
        return true;
    }
}