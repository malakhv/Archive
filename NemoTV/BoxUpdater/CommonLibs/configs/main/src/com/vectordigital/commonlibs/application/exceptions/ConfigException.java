package com.vectordigital.commonlibs.application.exceptions;

/**
 * Created by a.karmanov on 02.10.13.
 */
public class ConfigException extends DebugException {
    public ConfigException() {
        super();
    }

    public ConfigException(String detailMessage) {
        super(detailMessage);
    }

    public ConfigException(String detailMessage, Throwable throwable) {
        super(detailMessage, throwable);
    }

    public ConfigException(Throwable throwable) {
        super(throwable);
    }
}
