package com.vectordigital.commonlibs.json.helper;

import java.util.HashMap;
import java.util.Map;

/**
 * @author Wild Swift
 */
public class JsonNode {
    private JsonObjectListener jsonObjectListener;
    private Map<String, JsonNode> children = new HashMap<String, JsonNode>();

    public JsonNode getNode(String key) {
        if (!children.containsKey(key)) {
            children.put(key, new JsonNode());
        }
        return children.get(key);
    }

    public JsonObjectListener getJsonObjectListener() {
        return jsonObjectListener;
    }

    public void setJsonObjectListener(JsonObjectListener jsonObjectListener) {
        this.jsonObjectListener = jsonObjectListener;
    }
}
