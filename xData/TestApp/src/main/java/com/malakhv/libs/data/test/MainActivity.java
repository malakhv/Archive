package com.malakhv.libs.data.test;

import android.app.Activity;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.TextView;

import com.malakhv.data.BitwiseSet;

public class MainActivity extends Activity implements View.OnClickListener {
    private final static String TAG = "LogTest";

    /** The Log view. */
    private TextView mLog = null;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        mLog = (TextView) this.findViewById(R.id.log);
        log("App started...");
    }

    /**
     * Create main menu for this activity.
     * */
    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.main, menu); return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        int id = item != null ? item.getItemId() : 0;
        if (id == R.id.act_clear) {
            clear(); return true;
        }
        return super.onOptionsItemSelected(item);
    }

    /**
     * Clear the log.
     * */
    private void clear() { mLog.setText(""); }

    /**
     * Put specified strings to log.
     * */
    private void log(String... strings) {
        if (strings == null || strings.length <= 0) return;
        for (String str: strings) {
            mLog.append(str + "\n");
        }
    }

    /**
     * Called when a view has been clicked.
     * @param v The view that was clicked.
     */
    @Override
    public void onClick(View v) {
        final int id = v != null ? v.getId() : 0;
        if (id == R.id.btn_1) { action1(); }
        if (id == R.id.btn_2) { action2(); }
        if (id == R.id.btn_3) { action3(); }
        if (id == R.id.btn_4) { action4(); }
    }

    /** The action for button 1. */
    private void action1() {
        clear(); log("Action 1:");

        // Default constructor
        BitwiseSet set = new BitwiseSet();
        log(set.toString());

        // All bits are off
        set = new BitwiseSet(BitwiseSet.BITWISE_VALUE_ALL_OFF);
        log(set.toString());

        // All bits are on
        set = new BitwiseSet(BitwiseSet.BITWISE_VALUE_ALL_ON);
        log(set.toString());

        // To byte array test
        byte[] bits = set.toBytes();
        StringBuilder sBuilder = new StringBuilder();
        for (byte bit: bits) {
            sBuilder.append(String.valueOf(bit));
        }
        log(sBuilder.toString());

        // Test mask
        int mask = BitwiseSet.Bitwise.getMask(31);
        log(Integer.toBinaryString(mask));
        set.set(mask, false);
        log(set.toString());

        // Test toString
        log("Test - toString");
        log(set.toString());
    }

    /** The action for button 2. */
    private void action2() {
        clear(); log("Action 2:");
        log("Test shl and shr operations");

        // Make BitwiseSet instance
        BitwiseSet set = new BitwiseSet(BitwiseSet.BITWISE_VALUE_ALL_OFF);
        int mask = BitwiseSet.Bitwise.getMask(2);
        set.set(mask, true);
        log(set.toBinaryString());

        // shl 1
        set.shl();
        log(set.toBinaryString());

        // shr 1
        set.shr();
        log(set.toBinaryString());

        // All bits ON
        set.clear(true);

        // shl
        set.shl(7);
        log(set.toBinaryString());

        // shr
        set.shr(5);
        log(set.toBinaryString());

        // shr
        set.shr(15);
        log(set.toBinaryString());

        // sur 1
        set.sur();
        log(set.toBinaryString());

        // sur 117
        set.sur(117);
        log(set.toBinaryString());

        // shr max int
        mask = BitwiseSet.Bitwise.getMask(31);
        set.set(mask, true);
        set.shr(Integer.MAX_VALUE);
        log(set.toBinaryString());

    }

    /** The action for button 3. */
    private void action3() {
        clear(); log("Action 3:");
        log("Test setBit, turnOn and turnOff");

        // Make BitwiseSet instance
        BitwiseSet set = new BitwiseSet(BitwiseSet.BITWISE_VALUE_ALL_OFF);
        log(set.toBinaryString());

        // SetBit
        for (int i = 0; i < Integer.SIZE; i++) {
            set.setBit(i, (i % 2) == 0);
        }
        log(set.toBinaryString());

        // turnOn
        set.clear();
        set.turnOn(0); set.turnOn(2); set.turnOn(4); set.turnOn(6); set.turnOn(8);
        set.turnOn(10); set.turnOn(12); set.turnOn(14); set.turnOn(16); set.turnOn(18);
        set.turnOn(20); set.turnOn(22); set.turnOn(24); set.turnOn(26); set.turnOn(28);
        set.turnOn(30);
        log(set.toBinaryString());

        // turnOf
        set.clear(true);
        set.turnOff(1); set.turnOff(3); set.turnOff(5); set.turnOff(7); set.turnOff(9);
        set.turnOff(11); set.turnOff(13); set.turnOff(15); set.turnOff(17); set.turnOff(19);
        set.turnOff(21); set.turnOff(23); set.turnOff(25); set.turnOff(27); set.turnOff(29);
        set.turnOff(31);
        log(set.toBinaryString());

    }

    /** The action for button 4. */
    private void action4() {
        clear(); log("Action 4:");
    }
}