/* *
 * Copyright (C) 2020 DevLear - All Rights Reserved.
 *
 * This file is a part of BeerHub application.
 *
 * Confidential and Proprietary.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 * */

package com.devlear.app.beerhub.content;

import java.io.File;

/**
 * Class for decode application content.
 * @author Mikhail.Malakhov
 * */
@SuppressWarnings("WeakerAccess")
final class Crypto {

    /** The value returned from native code and means that decode operation was successfully. */
    private static final int DECODE_SUCCESS = 0;

    // Load native lib
    static {
        System.loadLibrary("crypto_jni");
    }

    /**
     * Decodes the {@code in} file and stores result to {@code out} file.
     * */
    public static boolean decode(File in, File out) {
        if (in == null || !in.exists() || !in.canRead() || out == null) {
            return false;
        }
        return decode_native(in.getAbsolutePath(), out.getAbsolutePath()) == DECODE_SUCCESS;
    }

    /**
     * This class has only static data, not need to create instance.
     * */
    private Crypto() { /* empty */ }

    // The native implementation of "decode" function
    static native int decode_native(String in, String out);

}
