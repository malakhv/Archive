package com.vectordigital.commonlibs.json.helper;

import com.vectordigital.commonlibs.json.parser.ContentHandler;
import com.vectordigital.commonlibs.json.parser.ParseException;

import java.io.IOException;
import java.util.Stack;

/**
 * @author wild Swift
 */
public class JsonContentHandler implements ContentHandler {
    protected Stack<JsonNode> currentNodes;
    protected String currentKey;

    public JsonContentHandler(JsonRootNode jsonRootNode) {
        currentNodes = new Stack<JsonNode>();
        currentNodes.add(jsonRootNode);
    }

    public void startJSON() throws ParseException, IOException {
    }

    public void endJSON() throws ParseException, IOException {
    }

    public boolean startObject() throws ParseException, IOException {
        if (currentKey != null) {
            currentNodes.push(currentNodes.peek().getNode(currentKey));
        }
        currentNodes.peek().getJsonObjectListener().onStart();
        return true;
    }

    public boolean endObject() throws ParseException, IOException {
        currentNodes.peek().getJsonObjectListener().onEnd();
        if (currentNodes.size() > 1) {
            currentNodes.pop();
        }
        return true;
    }

    public boolean startObjectEntry(String s) throws ParseException, IOException {
        currentKey = s;
        return true;
    }

    public boolean endObjectEntry() throws ParseException, IOException {
        currentKey = null;
        return true;
    }

    public boolean startArray() throws ParseException, IOException {
        return true;
    }

    public boolean endArray() throws ParseException, IOException {
        return true;
    }

    public boolean primitive(Object value) throws ParseException, IOException {
        currentNodes.peek().getJsonObjectListener().onField(currentKey, value);
        return true;
    }
}
