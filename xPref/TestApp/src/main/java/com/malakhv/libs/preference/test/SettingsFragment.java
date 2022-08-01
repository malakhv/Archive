package com.malakhv.libs.preference.test;

import android.os.Bundle;
import android.preference.PreferenceFragment;

/**
 * Created by malakhv on 16.06.2016.
 */
public class SettingsFragment extends PreferenceFragment {

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        addPreferencesFromResource(R.xml.preference);
    }
}
