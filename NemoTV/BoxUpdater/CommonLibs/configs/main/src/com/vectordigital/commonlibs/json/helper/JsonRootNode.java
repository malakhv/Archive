package com.vectordigital.commonlibs.json.helper;

import com.vectordigital.commonlibs.json.parser.ContentHandler;

/**
 * @author Wild Swift
 */
public class JsonRootNode extends JsonNode {
    public ContentHandler getHandler() {
        return new JsonContentHandler(this);
    }

}
