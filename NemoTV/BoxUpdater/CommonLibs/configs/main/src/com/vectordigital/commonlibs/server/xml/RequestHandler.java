package com.vectordigital.commonlibs.server.xml;

import org.xml.sax.helpers.DefaultHandler;

/**
 * Base handler to work with {@link  XmlSaxRequest}
 *
 * @author Wild Swift
 */
public class RequestHandler<T> extends DefaultHandler {
    /**
     * Result field
     */
    private T result;

    /**
     * Method to get parse result
     *
     * @return parse result
     */
    public final T getResult() {
        return result;
    }

    /**
     * Don't be public. Write access only protected. Protected to override.
     *
     * @param result define parse result.
     */
    protected final void setResult(T result) {
        this.result = result;
    }
}
