package com.vectordigital.commonlibs.server.xml;

import com.vectordigital.commonlibs.exceptions.ServerApiException;
import com.vectordigital.commonlibs.server.ServerRequest;

import org.w3c.dom.Document;
import org.xml.sax.SAXException;

import java.io.IOException;
import java.io.InputStream;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

/**
 * Universal request to get server data in xml format. Use standard DOM parsing model and handle basic exceptions.
 *
 * @author Wild Swift
 */
public abstract class XmlDomRequest<T> extends ServerRequest<T> {
    /**
     * Basic constructor initialize only URL. Method sets to default default (GET)
     *
     * @param url request URL
     */
    protected XmlDomRequest(String url) {
        super(url);
    }

    /**
     * Constructor with initialize constant fields.
     *
     * @param url    request URL
     * @param method request method. Use constants {@link  com.vectordigital.commonlibs.server.ServerRequest#GET} or {@link  com.vectordigital.commonlibs.server.ServerRequest#POST}
     * @throws IllegalArgumentException if method not
     */
    protected XmlDomRequest(String url, int method) {
        super(url, method);
    }

    /**
     * Constructor with initialize constant fields.
     *
     * @param url         request URL
     * @param method      request method. Use constants {@link  com.vectordigital.commonlibs.server.ServerRequest#GET} or {@link  com.vectordigital.commonlibs.server.ServerRequest#POST}
     * @param contentType if need set content type for request
     * @throws IllegalArgumentException if method not
     */
    protected XmlDomRequest(String url, int method, String contentType) {
        super(url, method, contentType);
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
            // create builder
            DocumentBuilder domBuilder = DocumentBuilderFactory.newInstance().newDocumentBuilder();
            // parse, convert and return result
            return convertDom(domBuilder.parse(content));
        } catch (ParserConfigurationException e) {
            // Box exception
            throw new ServerApiException(e);
        } catch (SAXException e) {
            // Box exception
            throw new ServerApiException(e);
        }
    }

    /**
     * Method to convert <b>document object model</b>
     *
     * @param document input dom
     * @return request result
     * @throws com.vectordigital.commonlibs.exceptions.ServerApiException if XML dom not valid
     */
    protected abstract T convertDom(Document document) throws ServerApiException;
}
