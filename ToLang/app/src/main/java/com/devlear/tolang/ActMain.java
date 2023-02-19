package com.devlear.tolang;

import android.app.Activity;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Spinner;
import android.widget.TextView;

import com.devlear.tolang.engine.EngineFactory;
import com.devlear.tolang.core.ShareTextProvider;
import com.devlear.tolang.engine.ServiceData;
import com.devlear.tolang.engine.ServiceEngine;
import com.devlear.tolang.engine.ServiceListener;

/**
 * The main Activity of this app.
 * @author Mikhail.Malakhov
 * */
public class ActMain extends Activity implements View.OnClickListener,
        AdapterView.OnItemSelectedListener, ServiceListener {

    /** The empty string. */
    private static final String EMPTY = "";

    /* *
     * The UI components
     * */
    private Button mTranslate = null;
    private EditText mOriginalText = null;
    private TextView mTranslatedText = null;
    private Spinner mLanguages = null;

    private ServiceEngine mEngine;

    private String[] mLangCodes = null;

    /* *
     * The "Share" providers
     * */
    private ShareTextProvider mOriginalShareProvider;
    private ShareTextProvider mTranslatedShareProvider;

    /**
     * Initialize all UI components.
     * */
    private void initUi() {
        mTranslate = findViewById(R.id.translate);
        mTranslate.setOnClickListener(this);
        mOriginalText = findViewById(R.id.original_text);
        mTranslatedText = findViewById(R.id.translated_text);
        // List of languages
        mLanguages = this.findViewById(R.id.languages);
        mLanguages.setOnItemSelectedListener(this);
        ArrayAdapter<String> langAdapter = new ArrayAdapter<>(this,
                android.R.layout.simple_spinner_item,
                getResources().getStringArray(R.array.lang_names));
        langAdapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        mLanguages.setAdapter(langAdapter);
    }

    private void initTranslationEngine() {
        //mEngine = EngineFactory.makeEngineFor("mock");
        mEngine = EngineFactory.makeEngineFor(this,"yandex");
        if (mEngine != null) {
            mEngine.setListener(this);
        }
    }

    /** {@inheritDoc} */
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        setTheme(R.style.Default);
        super.onCreate(savedInstanceState);
        setContentView(R.layout.act_main);
        initUi();
        initTranslationEngine();
        mLangCodes = getResources().getStringArray(R.array.lang_codes);
    }

    /** {@inheritDoc} */
    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.act_main, menu);

        // Share action provider for original text
        MenuItem item = menu.findItem(R.id.share_original);
        if (item != null) {
            mOriginalShareProvider = (ShareTextProvider) item.getActionProvider();
        }

        // Share action provider for translated text
        item = menu.findItem(R.id.share_translation);
        if (item != null) {
            mTranslatedShareProvider = (ShareTextProvider) item.getActionProvider();
        }

        return true;
    }

    /** {@inheritDoc} */
    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        final int id = item != null ? item.getItemId() : -1;

        // Clear
        if (id == R.id.clear) {
            clearText();
            return true;
        }

        // Share
        if (id == R.id.share) {
            mOriginalShareProvider.setText(getOriginalText());
            mTranslatedShareProvider.setText(getTranslatedText());
        }

        return super.onOptionsItemSelected(item);
    }

    /**
     * Clear all text.
     * */
    private void clearText() {
        setTranslatedText(EMPTY);
        mOriginalText.setText(EMPTY);
    }


    private void setTranslatedText(String text) {
        String t = text != null ? text : EMPTY;
        mTranslatedText.setText(t);
        mTranslatedShareProvider.setText(t);
    }

    /**
     * Starts translation process.
     * */
    private void translate() {
        //setTranslatedText(mOriginalText.getText().toString());
        if (mEngine != null) {
            int pos = mLanguages.getSelectedItemPosition();
            mEngine.getData().setLangTo(mLangCodes[pos]);
            mEngine.getData().setOriginalText(getOriginalText());
            mEngine.translate();
        }
    }

    private String getOriginalText() {
        return mOriginalText.getText().toString();
    }

    private String getTranslatedText() {
        return mTranslatedText.getText().toString();
    }

    /**
     * Called when a view has been clicked.
     * @param v The view that was clicked.
     * */
    @Override
    public void onClick(View v) {
        final int id =  v != null ? v.getId() : -1;

        if (id == R.id.translate) {
            translate();
        }
    }

    /**
     * <p>Callback method to be invoked when an item in this view has been
     * selected. This callback is invoked only when the newly selected
     * position is different from the previously selected position or if
     * there was no selected item.</p>
     * <p>
     * Impelmenters can call getItemAtPosition(position) if they need to access the
     * data associated with the selected item.
     *
     * @param parent   The AdapterView where the selection happened
     * @param view     The view within the AdapterView that was clicked
     * @param position The position of the view in the adapter
     * @param id       The row id of the item that is selected
     */
    @Override
    public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {

    }

    /**
     * Callback method to be invoked when the selection disappears from this
     * view. The selection can disappear for instance when touch is activated
     * or when the adapter becomes empty.
     *
     * @param parent The AdapterView that now contains no selected item.
     */
    @Override
    public void onNothingSelected(AdapterView<?> parent) {

    }

    @Override
    public void onTranslate(ServiceData data) {
        setTranslatedText(data.getTranslation());
    }

    @Override
    public void onError(Exception e) {

    }
}