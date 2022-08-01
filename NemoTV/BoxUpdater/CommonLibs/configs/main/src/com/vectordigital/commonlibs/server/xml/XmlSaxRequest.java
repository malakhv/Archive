package com.vectordigital.commonlibs.server.xml;

import com.vectordigital.commonlibs.exceptions.ServerApiException;
import com.vectordigital.commonlibs.server.ServerRequest;

import org.xml.sax.SAXException;

import java.io.IOException;
import java.io.InputStream;

import javax.xml.parsers.ParserConfigurationException;
import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;

/**
 * Universal request to get server data in xml format. Use standard SAX parsing model and handle basic exceptions.
 *
 * @author Wild Swift
 */
public abstract class XmlSaxRequest<T> extends ServerRequest<T> {
    /**
     * Handler to parse server response. Must be constant. Defined in constructor.
     */
    private RequestHandler<T> handler;

    /**
     * Basic constructor initialize only URL. Method sets to default default (GET)
     *
     * @param url     request URL
     * @param handler Handler to parse response
     */
    protected XmlSaxRequest(String url, RequestHandler<T> handler) {
        super(url);
        this.handler = handler;
    }

    /**
     * Constructor with initialize constant fields.
     *
     * @param url     request URL
     * @param method  request method. Use constants {@link  com.vectordigital.commonlibs.server.ServerRequest#GET} or {@link  com.vectordigital.commonlibs.server.ServerRequest#POST}
     * @param handler Handler to parse response
     * @throws IllegalArgumentException if method not
     */
    protected XmlSaxRequest(String url, int method, RequestHandler<T> handler) {
        super(url, method);
        this.handler = handler;
    }

    /**
     * Constructor with initialize constant fields.
     *
     * @param url         request URL
     * @param method      request method. Use constants {@link  com.vectordigital.commonlibs.server.ServerRequest#GET} or {@link  com.vectordigital.commonlibs.server.ServerRequest#POST}
     * @param contentType if need set content type for request
     * @param handler     Handler to parse response
     * @throws IllegalArgumentException if method not
     */
    protected XmlSaxRequest(String url, int method, String contentType, RequestHandler<T> handler) {
        super(url, method, contentType);
        this.handler = handler;
    }

    /**
     * Callback to work with response. Called when input from server gets, and return result of request.<br/>
     * Used in other classes. Protect to override.
     * If need to override, use {@link  com.vectordigital.commonlibs.server.ServerRequest} instead
     *
     * @param content input from server side
     * @return result of processing request (data object or other information)
     * @throws com.vectordigital.commonlibs.exceptions.ServerApiException if error in server format of data
     * @throws java.io.IOException                                        if IOErrors occurred
     */
    @Override
    public final T processRequest(InputStream content) throws ServerApiException, IOException {
        try {
            // Get parser
            SAXParser parser = SAXParserFactory.newInstance().newSAXParser();
            // Parse
            parser.parse(content, handler);
            // Get result
            return handler.getResult();
        } catch (ParserConfigurationException e) {
            // Box exception
            throw new ServerApiException(e);
        } catch (SAXException e) {
            // Box exception
            throw new ServerApiException(e);
        }
    }
}
