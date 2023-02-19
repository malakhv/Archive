package com.devlear.tolang.web;

import android.graphics.BitmapFactory;
import android.os.AsyncTask;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.net.URL;

import javax.net.ssl.HttpsURLConnection;

/**
 * The simple async web client.
 * @author Mikhail.Malakhov
 * */
public class WebClient {

    /** The tag for LOgCat. */
    private static final String TAG = WebClient.class.getSimpleName();

    /** The default value for request id if it's not defined. */
    public static final int NO_ID = -1;

    private OnCompleteListener mCompleteListener = null;
    private OnProgressListener mProgressListener = null;

    private AsyncRequest lastRequest = null;

    /**
     * Make new instance of {@link WebClient}.
     * */
    public WebClient() { super(); }

    /**
     * Make new instance of {@link WebClient} with specified parameters.
     * */
    public WebClient(OnCompleteListener completeListener, OnProgressListener progressListener) {
        super();
        mCompleteListener = completeListener;
        mProgressListener = progressListener;
    }

    public void send(int id, String... request) {
        this.cancel(id);
        lastRequest = new AsyncRequest(id);
        lastRequest.execute(request);
    }

    public void cancel(int id) {
        if ( lastRequest != null && (lastRequest.getId() == id || id == NO_ID) ) {
            lastRequest.cancel(true);
            lastRequest = null;
        }
    }

    public void cancel() { this.cancel(NO_ID); }

    /**
     * @return The currently used {@link OnCompleteListener}.
     * */
    public OnCompleteListener getOnCompleteListener() {
        return mCompleteListener;
    }

    /**
     * @return The currently used {@link OnProgressListener}.
     * */
    public OnProgressListener getOnProgressListener() {
        return mProgressListener;
    }

    /**
     * Sets the new value for {@link OnCompleteListener} in this object.
     * */
    public void setOnCompleteListener(OnCompleteListener listener) {
        mCompleteListener = listener;
    }

    /**
     * Sets the new value for {@link OnProgressListener} in this object.
     * */
    public void setOnProgressListener(OnProgressListener listener) {
        mProgressListener = listener;
    }

    /**
     * Performs callback for {@link OnCompleteListener} in this object.
     * */
    protected void performComplete(int id, int count, Exception e) {
        final OnCompleteListener l = getOnCompleteListener();
        if (l != null) {
            l.onComplete(id, count, e);
        }
    }

    /**
     * Performs callback for {@link OnProgressListener} in this object.
     * */
    protected void performProgress(int index, int id, Object data, Exception e) {
        final OnProgressListener l = getOnProgressListener();
        if (l != null) {
            l.onProgress(index, id, data, e);
        }
    }

    private static URL makeUrl(String request) {
        if (request == null || request.isEmpty()) return null;
        try {
            return new URL(request);
        } catch (MalformedURLException e) {
            return null;
        }
    }

    /**
     * Executes specified request to a web-server and receives appropriate data.
     * */
    private static Object execute(String request) throws IOException {

        // Request is null?
        if (request == null ) {
            throw new IllegalArgumentException("Request to web-server is null");
        }

        // Request is empty?
        if (request.equals("")) {
            throw new IllegalArgumentException("Request to web-server is empty");
        }

        // Prepare url for request
        final URL url = makeUrl(request);
        if (url == null) return null;

        // The connection instance
        HttpsURLConnection connection = null;

        // Stream for data from web-server
        InputStream stream = null;

        // Request result
        Object data = null;

        // Connect to the web-server and receive data
        try {
            connection = (HttpsURLConnection) url.openConnection();
            connection.setReadTimeout(3000);
            connection.setConnectTimeout(3000);
            connection.setRequestMethod("GET");
            connection.setDoInput(true);

            // Try to connect
            connection.connect();
            int responseCode = connection.getResponseCode();
            if (responseCode != HttpsURLConnection.HTTP_OK) {
                throw new IOException("HTTP error code: " + responseCode);
            }

            // Raw data
            stream = connection.getInputStream();

            // The data type
            final String type = connection.getContentType();

            // The data length
            final int length = connection.getContentLength();

            // Convert raw data
            data = convertData(stream, length, type);

        } finally {
            if (stream != null) stream.close();
            if (connection != null) connection.disconnect();
        }

        return data;
    }

    /**
     * Converts data from raw stream to appropriate format.
     * */
    protected static Object convertData(InputStream data, long size,
            String format) throws IOException {

        // Size < 0, it's very strange
        if (size < 0) {
            throw new IllegalArgumentException("The data size is less than 0");
        }

        // Size is 0 - no data
        if (size == 0) return null;

        // Data is text?
        if (formatIsString(format)) {
            BufferedReader bReader = new BufferedReader(new InputStreamReader(data));
            StringBuilder sBuilder = new StringBuilder();
            String buf = null;
            while ((buf = bReader.readLine()) != null)
                sBuilder.append(buf).append("\n");
            bReader.close();
            return sBuilder.toString();
        }

        // Data is image?
        if (formatIsImage(format)) {
            return BitmapFactory.decodeStream(data);
        }

        return null;
    }

    /**
     * @return True, if data with specified format can be represent as string.
     * */
    protected static boolean formatIsString(String format) {
        return (format.contains("text") || format.contains("json") ||
                format.contains("xml") || format.contains("html"));
    }

    /**
     * @return True, if data with specified format can be represent as bitmap image.
     * */
    private static boolean formatIsImage(String format) {
        return format.contains("image");
    }

    /** The inner class for async operation. */
    protected class AsyncRequest extends AsyncTask<String, Object, Integer> {

        /** The request id. */
        private int mId = NO_ID;

        /** The last exception. */
        private Exception mException = null;

        /**
         * Make new {@link AsyncRequest} instance.
         * */
        public AsyncRequest() {
            super();
        }

        /**
         * Make new {@link AsyncRequest} instance with specified parameters.
         * */
        public AsyncRequest(int id) {
            super();
            mId = id;
        }

        /** @return The id of current request. */
        public int getId() { return mId; }

        /** {@inheritDoc} */
        @Override
        protected Integer doInBackground(String... params) {
            if (params == null || params.length == 0) {
                throw new IllegalArgumentException("Request parameters are empty");
            }

            // The number of success requests
            int count = 0;

            mException = null;
            for (int i = 0; i < params.length; i++) {
                Object data = null;
                try {
                    data = WebClient.execute(params[i]);
                    count++;
                } catch (Exception e) {
                    mException = e;
                }
                if (this.isCancelled()) break;
                publishProgress(i, mId, data, mException);
            }
            return count;
        }

        /** {@inheritDoc} */
        @Override
        protected void onProgressUpdate(Object... values) {
            if (values == null) {
                throw new IllegalArgumentException("Values is null");
            }
            if (values.length == 4) {
                int index = (Integer) values[0];
                int id = (Integer) values[1];
                performProgress(index, id, values[2], (Exception) values[3]);
            } else {
                performProgress(-1, mId, null,
                        new IllegalArgumentException("Incorrect length of values"));
            }
        }

        /** {@inheritDoc} */
        @Override
        protected void onPostExecute(Integer result) {
            if (this.isCancelled()) return;
            performComplete(mId, result, mException);

        }

        /** {@inheritDoc} */
        @Override
        protected void onCancelled() {
            performComplete(mId, 0, new IOException("Request was canceled"));
            super.onCancelled();
        }
    }

    /**
     * Interface definition for a callback to be invoked when all data is received and a request
     * is completed.
     * @see OnProgressListener
     * */
    public interface OnExecuteListener {

        /**
         * Called when all data has been received from web server. Run on UI thread.
         * @param id The request id, can be {@link #NO_ID}.
         * @param count The number of success sub-requests.
         * @param e The exception, if any problem happens, should be {@code null} in normal
         *          situation.
         * */
        void onExecute(int id, int count, Exception e);
    }

    /**
     * Interface definition for a callback to be invoked when request to a web server is completed.
     * @see OnProgressListener
     * */
    public interface OnCompleteListener {

        /**
         * Called when a request to a web server has been completed. Run on UI thread.
         * @param id The main request id, can be {@link #NO_ID}.
         * @param count The number of success sub-requests.
         * @param e The exception, if any problem happens, or {@code null}.
         * */
        void onComplete(int id, int count, Exception e);
    }


    /**
     * Interface definition for a callback to be invoked when data of sub-request is received.
     * @see OnExecuteListener
     * */
    public interface OnProgressListener {

        /**
         * Called when a data of sub-request has been received. Run on UI thread.
         * @param index The index of sub-request to a web server.
         * @param id The main request id, can be {@link #NO_ID}.
         * @param data The web server answer.
         * @param e The exception, if any problem happens, or {@code null}.
         * */
        void onProgress(int index, int id, Object data, Exception e);

    }
}