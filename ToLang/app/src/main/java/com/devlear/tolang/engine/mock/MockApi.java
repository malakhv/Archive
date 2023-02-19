package com.devlear.tolang.engine.mock;

import com.devlear.tolang.engine.ServiceApi;
import com.devlear.tolang.engine.ServiceData;

/**
 * The test API for virtual server. The data format is:
 *  original_text;lang_from;lang_to;translated_text
 * */
public class MockApi implements ServiceApi {

    private static final String DELIMITER = ";";
    private final ServiceData mData = new ServiceData();

    @Override
    public String makeRequest(ServiceData data) {
        if (data != null) {
            return data.getOriginalText() + DELIMITER + data.getLangFrom() + DELIMITER +
                    data.getLangTo();
        }
        return null;
    }

    @Override
    public ServiceData obtain(String response) {
        final ServiceData data = new ServiceData();
        if (response != null && !response.isEmpty()) {
            String[] chunks = response.split(DELIMITER);
            if (chunks.length > 0) data.setOriginalText(chunks[0]);
            if (chunks.length > 1) data.setLangFrom(chunks[1]);
            if (chunks.length > 2) data.setLangTo(chunks[2]);
            data.setTranslation(new StringBuilder(data.getOriginalText()).reverse().toString());
        }
        return data;
    }

}