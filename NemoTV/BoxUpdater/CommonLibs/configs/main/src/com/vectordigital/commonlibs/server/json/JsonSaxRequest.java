package com.vectordigital.commonlibs.server.json;

import com.vectordigital.commonlibs.application.ApplicationUtils;
import com.vectordigital.commonlibs.exceptions.ServerApiException;
import com.vectordigital.commonlibs.json.parser.JSONParser;
import com.vectordigital.commonlibs.json.parser.ParseException;
import com.vectordigital.commonlibs.server.ServerRequest;

import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.logging.Logger;

/**
 * Universal request to get server data in JSON format. Use SAX style parsing model and handle basic exceptions.
 *
 * @author Wild Swift
 */
public abstract class JsonSaxRequest<T> extends ServerRequest<T> {
    /**
     * internal logger
     */
    private Logger log = Logger.getLogger(getClass().getName());

    /**
     * Basic constructor initialize only URL. Method sets to default default (GET)
     *
     * @param url request URL
     */
    protected JsonSaxRequest(String url) {
        super(url, POST, "application/json; charset=utf-8");
    }

    /**
     * Constructor with initialize constant fields.
     *
     * @param url    request URL
     * @param method request method. Use constants {@link  com.vectordigital.commonlibs.server.ServerRequest#GET} or {@link  com.vectordigital.commonlibs.server.ServerRequest#POST}
     * @throws IllegalArgumentException if method not
     */
    protected JsonSaxRequest(String url, int method) {
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
    protected JsonSaxRequest(String url, int method, String contentType) {
        super(url, method, contentType);
    }

    /**
     * Callback to work with response. Called when input from server gets, and return result of request.<br/>
     * Parse JSON with defined handler.
     * Don't override. If need, use {@link  com.vectordigital.commonlibs.server.ServerRequest} instead
     *
     * @param content input from server side
     * @return result of processing request (data object or other information)
     * @throws com.vectordigital.commonlibs.exceptions.ServerApiException if error in server format of data
     * @throws java.io.IOException                                        if IOErrors occurred
     */
    @Override
    public final T processRequest(InputStream content) throws ServerApiException, IOException {
        RequestHandler<T> handler = getHandler();
        try {
            new JSONParser().parse(new InputStreamReader(content), handler);
        } catch (ParseException e) {
            log.severe(ApplicationUtils.getErrorReport(e.getMessage(), e));
            throw new ServerApiException(e);
        }
        return handler.getResult();
    }

    protected abstract RequestHandler<T> getHandler();
}