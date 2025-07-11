package com.vectordigital.commonlibs.server.network;

import com.vectordigital.commonlibs.application.ApplicationUtils;
import com.vectordigital.commonlibs.exceptions.InvalidStatusException;
import com.vectordigital.commonlibs.exceptions.NetworkException;
import com.vectordigital.commonlibs.exceptions.TransportException;

import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.Date;
import java.util.Map;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Implementation fo interface {@link  Network}.<br/>
 * Should call {@link  NetworkImpl#getInputForRequest(String, java.util.Map, int, java.util.Date, java.lang.String, java.lang.String)} or {@link  NetworkImpl#openConnection(String, java.util.Map, int, java.util.Date, java.lang.String, java.lang.String)} with {@link NetworkImpl#close()} in one synchronized block.<br/>
 * Sample. <br/>
 * <code>
 * Network network = NetworkImpl.getInstance();
 * synchronized (network) {
 * InputStream serverInput = network.getInputForRequest(request.getUrl(), request.getParameters(), request.getMethod());
 * // some work with response
 * network.close();
 * }
 * </code>
 *
 * @author Wild Swift
 */
class NetworkImpl implements Network {
    private boolean free = true;

    /**
     * Current working connection.
     */
    private HttpURLConnection currentConnection;
    /**
     * Current working InputStream.
     */
    private InputStream currentInput;
    private final Logger log = Logger.getLogger(getClass().getName());
    private int readTimeout;
    private int connectionTimeout;

    /**
     * Constructor with private access
     */
    protected NetworkImpl() {
    }


    /**
     * Checks response code and modify connection if need
     *
     * @return need to retry
     * @throws IOException                                              if IO error occurred
     * @throws com.vectordigital.commonlibs.exceptions.NetworkException if response code not valid
     */
    private boolean workWithResponseCode() throws IOException, NetworkException {
        int code = currentConnection.getResponseCode();
        log.info("response = " + code);

        // Temporarily we consider all response codes "2xx" as correct,
        // though in future some of them will need additional processing
        if ((code / 100) == 2) return false;

        // if not modified close connection
        if (code == HttpURLConnection.HTTP_NOT_MODIFIED) {
            close();
            return false;
        }

        // if system problem (no valid response code)
        if (code == -1) {
            return true;
        }

        // message to exception
        String message = "Bad response code " + code + " : " + currentConnection.getResponseMessage();
        NetworkException networkException = new InvalidStatusException(message, code);

        log.severe(ApplicationUtils.getErrorReport(message, networkException));

        if (log.isLoggable(Level.CONFIG)) {
            InputStream errorStream = currentConnection.getErrorStream();
            ByteArrayOutputStream output = new ByteArrayOutputStream();


            byte[] buffer = new byte[1024];
            int len;
            while ((len = errorStream.read(buffer)) >= 0) {
                output.write(buffer, 0, len);
            }
            log.info(new String(output.toByteArray()));
        }

        throw networkException;
    }

    /**
     * Open InputStream to server content specified by url, request parameters,and request method.<br/>
     * If localCacheDate specified verify if content changed.<br/>
     * Method should be called from block synchronized by object instance.
     *
     * @param url            request url
     * @param parameters     request parameters map
     * @param method         specified request method. Accept one of constant {@link  Network#GET} or {@link  Network#POST}
     * @param localCacheDate date of cache previous content. If null no cache supported.
     * @param eTag           data id
     * @return null if server return NOT_MODIFIED status, and HTTPConnection other way
     * @throws NetworkException if server return status different from OK and NOT_MODIFIED or IO error occurred
     */
    public InputStream getInputForRequest(String url, Map<String, String> parameters, int method, Date localCacheDate, String eTag, String contentType) throws NetworkException {
        openConnection(url, parameters, method, localCacheDate, eTag, contentType);
        try {
            currentInput = currentConnection.getInputStream();
        } catch (IOException e) {
            // Box exception
            throw new TransportException(e);
        }
        return new BufferedInputStream(currentInput, 8192);
    }

    /**
     * Open InputStream to server content specified by url, request parameters,and request method.<br/>
     * If localCacheDate specified verify if content changed.<br/>
     * Method should be called from the code synchronized by object instance.
     *
     * @param url            request url
     * @param parameters     request parameters map
     * @param method         specified request method. Accept one of constant {@link  Network#GET} or {@link  Network#POST}
     * @param localCacheDate date of cache previous content. If null no cache supported.
     * @param eTag           data id
     * @return null if server return NOT_MODIFIED status, and HTTPConnection other way
     * @throws NetworkException if server return status different from OK and NOT_MODIFIED or IO error occurred
     */
    public HttpURLConnection openConnection(String url, Map<String, String> parameters, int method, Date localCacheDate, String eTag, String contentType) throws NetworkException {
        this.notify();
        try {
            free = false;
            // Create encoded parameters string
            String reqParameters = "";
            Set<String> keys = parameters.keySet();
            for (String key : keys) {
                if (key.length() == 0) {
                    reqParameters += parameters.get(key) + "&";
                } else {
                    reqParameters += URLEncoder.encode(key, "UTF-8") + "=" + URLEncoder.encode(parameters.get(key), "UTF-8") + "&";
                }
            }
            // remove last & if need
            if (reqParameters.length() > 0) {
                reqParameters = reqParameters.substring(0, reqParameters.length() - 1);
            }

            log.config("url = " + url);
            log.config("parameters = " + reqParameters);

            do {

                // Create connection for selected method
                currentConnection = null;
                if (method == GET) {
                    log.info("method = GET");
                    URL urlObject = new URL(url + (reqParameters.length() == 0 ? "" : ("?" + reqParameters)));
                    currentConnection = (HttpURLConnection) urlObject.openConnection();
                    currentConnection.setRequestMethod("GET");
                } else if (method == POST) {
                    log.info("method = POST");
                    URL urlObject = new URL(url);
                    currentConnection = (HttpURLConnection) urlObject.openConnection();
                    currentConnection.setRequestMethod("POST");
                } else {
                    throw new IllegalArgumentException("Bad Method");
                }

                if(readTimeout != 0){
                    currentConnection.setReadTimeout(readTimeout);
                }

                if(connectionTimeout != 0){
                    currentConnection.setConnectTimeout(connectionTimeout);
                }

                // set content type
                if (contentType != null && contentType.length() > 0) {
                    currentConnection.setRequestProperty("Content-Type", contentType);
                }

                // set last modified date if need
                if (localCacheDate != null) {
                    currentConnection.setIfModifiedSince(localCacheDate.getTime());
                }

                if (eTag != null && eTag.length() > 0) {
                    currentConnection.addRequestProperty("If-None-Match", eTag);
                }

                if (method == POST) {
                    currentConnection.setDoOutput(true);
                    currentConnection.setRequestProperty("Content-Length", reqParameters.getBytes().length + "");
                    OutputStream connectionOutput = currentConnection.getOutputStream();
                    connectionOutput.write(reqParameters.getBytes());
                    connectionOutput.close();
                }

                // check response code and retry if need
            } while (workWithResponseCode());


            // return result
            return currentConnection;
        } catch (IOException e) {
            // Box exception
            close();
            throw new TransportException(e);
        }
    }

    /**
     * Checks if this instance is free
     *
     * @return if this instance is not working with network now
     */
    public boolean isFree() {
        return free;
    }

    /**
     * Close previous connection and streams
     */
    public void close() {
        this.notify();
        if (currentInput != null) {
            try {
                currentInput.close();
            } catch (IOException e) {
                log.config("Error while closing input stream");
            }
            currentInput = null;
        }
        if (currentConnection != null) {
            currentConnection.disconnect();
            currentConnection = null;
        }
        free = true;
    }

    @Override
    public void setReadTimeout(int timeoutMillis) {
        readTimeout = timeoutMillis;
    }

    @Override
    public void setConnectionTimeout(int timeoutMillis) {
        connectionTimeout = timeoutMillis;
    }


}
