package com.vectordigital.commonlibs.server;

import java.util.Date;

/**
 * Basic interface for http transport cache
 *
 * @author Wild Swift
 */
public interface LocalNetworkCache {
    /**
     * Stores data in cache
     *
     * @param id        request id
     * @param storeDate last update date
     * @param eTag      content verifier
     */
    public void storeData(String id, Date storeDate, String eTag);

    /**
     * Get last update date for the data
     *
     * @param id request id
     * @return last updated date
     */
    public Date getCacheDate(String id);

    /**
     * Get data identifier
     *
     * @param id request id
     * @return Data identifier
     */
    public String getETag(String id);
}
