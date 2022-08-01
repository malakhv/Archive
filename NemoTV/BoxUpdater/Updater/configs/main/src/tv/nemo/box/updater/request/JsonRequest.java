package tv.nemo.box.updater.request;

import com.vectordigital.commonlibs.exceptions.ServerApiException;
import com.vectordigital.commonlibs.server.json.JsonDomRequest;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.Iterator;
import java.util.Map;
import java.util.TreeMap;

/**
 * Базовый класс описывающий запросы к серверу.
 * */
public abstract class JsonRequest<T> extends JsonDomRequest<T> {

    protected JsonRequest(String url) {
        super(url);
    }

    protected abstract T convertParams(JSONObject params) throws ServerApiException, JSONException;

    @Override
    protected T convertJson(JSONObject obj) throws ServerApiException, JSONException {
        if (obj.has("error")) {
            JSONObject error = obj.getJSONObject("error").getJSONObject("data");
            TreeMap<String, String> extData = new TreeMap<String, String>(String.CASE_INSENSITIVE_ORDER);
            Iterator keys = error.keys();
            while (keys.hasNext()) {
                String next = (String) keys.next();
                if ("context".equals(next) || "subcode".equals(next)) continue;
                extData.put(next, String.valueOf(error.get(next)));
            }

            String[] params = new String[extData.size()];
            int i = 0;
            for (Map.Entry<String, String> entry : extData.entrySet()) {
                params[i++] = entry.getValue();
            }
        }
        final Object result = obj.get("result");
        if (result instanceof JSONObject) {
            return convertParams((JSONObject) result);
        } else {
            return convertParams(new JSONObject() {{
                put("result", result);
            }});
        }
    }

    @Override
    protected T convertJson(JSONArray obj) throws ServerApiException, JSONException {
        return null;
    }
}
