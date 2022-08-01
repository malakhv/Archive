package com.vectordigital.commonlibs.server.json;

import com.vectordigital.commonlibs.exceptions.ServerApiException;
import com.vectordigital.commonlibs.server.ServerRequest;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Universal request to get server data in JSON format. Use standard DOM parsing model and handle basic exceptions.
 *
 * @author Wild Swift
 */
public abstract class JsonDomRequest<T> extends ServerRequest<T> {
    private final Logger log = Logger.getLogger(JsonDomRequest.class.getName());

    /**
     * Basic constructor initialize only URL. Method sets to default default (GET)
     *
     * @param url request URL
     */
    protected JsonDomRequest(String url) {
        super(url, POST, "application/json; charset=utf-8");
    }

    /**
     * Constructor with initialize constant fields.
     *
     * @param url    request URL
     * @param method request method. Use constants {@link  com.vectordigital.commonlibs.server.ServerRequest#GET} or {@link  com.vectordigital.commonlibs.server.ServerRequest#POST}
     * @throws IllegalArgumentException if method not
     */
    protected JsonDomRequest(String url, int method) {
        super(url, method, "application/json; charset=utf-8");
    }

    /**
     * Constructor with initialize constant fields.
     *
     * @param url         request URL
     * @param method      request method. Use constants {@link  com.vectordigital.commonlibs.server.ServerRequest#GET} or {@link  com.vectordigital.commonlibs.server.ServerRequest#POST}
     * @param contentType if need set content type for request
     * @throws IllegalArgumentException if method not
     */
    protected JsonDomRequest(String url, int method, String contentType) {
        super(url, method, contentType);
    }

    /**
     * Callback to work with response. Called when input from server gets, and return result of request.<br/>
     * Load all server data. Parse JSON and call one of convert methods.
     * Don't override. If need, use {@link  com.vectordigital.commonlibs.server.ServerRequest} instead
     *
     * @param content input from server side
     * @return result of processing request (data object or other information)
     * @throws com.vectordigital.commonlibs.exceptions.ServerApiException if error in server format of data
     * @throws java.io.IOException                                        if IOErrors occurred
     */
    @Override
    public final T processRequest(InputStream content) throws ServerApiException, IOException {
        ByteArrayOutputStream dataCache = new ByteArrayOutputStream();

        // Fully read data
        byte[] buff = new byte[1024];
        int len;
        while ((len = content.read(buff)) >= 0) {
            dataCache.write(buff, 0, len);
        }
        // Close streams
        dataCache.close();

        String jsonString = new String(dataCache.toByteArray()).trim();

        // Check for array index out of bounds
        if (jsonString.length() > 0) {
            try {
                if(log.isLoggable(Level.CONFIG)) {
                    log.config("Processing url: " + getUrl());
                    log.config("Params: " + getParameters());
                }
                if(log.isLoggable(Level.FINE)) {
                    log.fine("Got response: " + jsonString);
                }
                // switch type of Json root object
                if (jsonString.startsWith("{")) {
                    return convertJson(new JSONObject(jsonString));
                } else {
                    return convertJson(new JSONArray(jsonString));
                }
            } catch (JSONException e) {
                // Box exception
                throw new ServerApiException(e);
            }
        }
        throw new ServerApiException("No data returned");
    }

    protected abstract T convertJson(JSONObject obj) throws ServerApiException, JSONException;

    protected abstract T convertJson(JSONArray obj) throws ServerApiException, JSONException;
}