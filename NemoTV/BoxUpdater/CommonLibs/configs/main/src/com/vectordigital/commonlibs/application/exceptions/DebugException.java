package com.vectordigital.commonlibs.application.exceptions;

/**
 * Created by a.karmanov on 02.10.13.
 */
public class DebugException extends RuntimeException {
    public DebugException() {
        super();
    }

    public DebugException(String detailMessage) {
        super(detailMessage);
    }

    public DebugException(String detailMessage, Throwable throwable) {
        super(detailMessage, throwable);
    }

    public DebugException(Throwable throwable) {
        super(throwable);
    }
}
