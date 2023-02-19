package com.devlear.tolang.engine;

import com.devlear.tolang.web.WebClient;

public class OnlineEngine extends BaseEngine {

    private WebClient mWebClient;
    private WebClientListeners mWebListeners;

    public OnlineEngine(ServiceApi api) {
        super();
        setApi(api);
        mWebListeners = new WebClientListeners();
        mWebClient = new WebClient();
        mWebClient.setOnCompleteListener(mWebListeners);
        mWebClient.setOnProgressListener(mWebListeners);
    }

    @Override
    public void translate() {
        final ServiceData data = getData();
        if (data == null) return;
        final ServiceApi api = getApi();
        if (api == null) return;
        mWebClient.send(WebClient.NO_ID, api.makeRequest(data));
    }

    private class WebClientListeners implements WebClient.OnProgressListener,
            WebClient.OnCompleteListener {

        /**
         * Called when a request to a web server has been completed. Run on UI thread.
         * */
        @Override
        public void onComplete(int id, int count, Exception e) {
            /* do nothing */
        }

        /**
         * Called when a data of sub-request has been received. Run on UI thread.
         * */
        @Override
        public void onProgress(int index, int id, Object data, Exception e) {
            if (e != null) {
                performError(e);
            } else if (data instanceof String) {
                getData().obtain(getApi().obtain((String) data));
                performTranslate(getData());
            }
        }
    }
}