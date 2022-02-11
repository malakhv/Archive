/* *
 * Copyright (C) 2018 DevLear - All Rights Reserved.
 *
 * This file is a part of BeerHub application.
 *
 * Confidential and Proprietary.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 * */

package com.devlear.app.beerhub.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;

/**
 * Class contains some things to work with zip archives.
 * @author Mikhail.Malakhov
 * */
@SuppressWarnings({"unused"})
public final class ZipUtils {

    /** The tag for LogCat. */
    private static final String TAG = ZipUtils.class.getSimpleName();

    /** The default buffer size for stream operations. */
    // TODO When moving this class to library, please keep it outside and share with FileUtils
    private static final int DEFAULT_BUFFER_SIZE = 8192;

    /**
     * Unzips specified file to specified path. If zip file has root dir, it will be
     * unzipped as {@code unzipPath/zip_root_dir/*}.
     * */
    @SuppressWarnings("ResultOfMethodCallIgnored")
    public static void unzipTo(File zipFile, File unzipPath) throws IOException {

        // Checking zipFile
        if (!zipFile.exists()) {
            throw new FileNotFoundException("The input zip file not found.");
        }
        if (!zipFile.canRead()) {
            throw new IOException("Cannot read input zip file.");
        }

        // Checking unzip path
        if (!unzipPath.canWrite()) {
            throw new IOException("Cannot write to output zip file.");
        }

        // Unzipping file to specified path
        final ZipInputStream zipInputStream = new ZipInputStream(new FileInputStream(zipFile));
        ZipEntry zipEntry = zipInputStream.getNextEntry();
        byte[] buffer = new byte[DEFAULT_BUFFER_SIZE];
        int read = 0;
        while(zipEntry != null) {
            final File f = new File(unzipPath, zipEntry.getName());
            if (!zipEntry.isDirectory()) {
                // Sometimes, we should unzip files in media dir before media dir entry. WTF???
                FileOutputStream fos = new FileOutputStream(f);
                while ((read = zipInputStream.read(buffer)) > 0) {
                    fos.write(buffer, 0, read);
                }
                fos.close();
            } else {
                f.mkdirs();
            }
            zipInputStream.closeEntry();
            zipEntry = zipInputStream.getNextEntry();
        }
        zipInputStream.closeEntry();
        zipInputStream.close();
    }

    /**
     * Unzips specified file to specified path. If zip file has root dir, it will be
     * unzipped as {@code unzipPath/zip_root_dir/*}.
     * */
    public static void unzipTo(String  zipFile, String  unzipPath) throws IOException {
        final File zf = new File(zipFile);
        final File up = new File(unzipPath);
        unzipTo(zf, up);
    }

    /**
     * This class has only static data, not need to create instance.
     * */
    private ZipUtils() { /* Empty */ }
}
