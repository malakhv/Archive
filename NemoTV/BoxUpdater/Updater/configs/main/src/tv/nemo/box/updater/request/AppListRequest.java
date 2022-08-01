package tv.nemo.box.updater.request;

import com.vectordigital.commonlibs.exceptions.ServerApiException;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.List;

import tv.nemo.box.updater.Config;

/**
 * Created by malakhv on 29.10.14.
 */
public class AppListRequest extends JsonRequest<List<AppData>> {

    /** URL запроса. */
    private static final String API_DEVICE_LIST_APPLICATIONS_JSON = "/api/device/application_list.json";

    /** Конструктор. */
    public AppListRequest(String deviceID, String platform) {

        super(Config.SERVER_URL + API_DEVICE_LIST_APPLICATIONS_JSON);
        //super("http://192.168.4.90:8085" + API_DEVICE_LIST_APPLICATIONS_JSON);

        /** Параметры запроса */
        JSONObject body = new JSONObject();
        try {
            body.put("device_id", deviceID);
            body.put("platform", platform);
        } catch (JSONException e) {
            e.printStackTrace();
        }
        appendParameter("", body.toString());
    }

    protected List<AppData> convertParams(JSONObject params) throws ServerApiException, JSONException {
        List<AppData> applicationsData = new ArrayList<AppData>();
        JSONArray updateList = params.getJSONArray("application_list");
        for (int i = 0; i < updateList.length(); i++) {
            JSONObject update = updateList.getJSONObject(i);

            applicationsData.add(new AppData(update.getString("url"), update.getString("app_id"),
                    update.getString("version"), update.getString("title")));

        }
        return applicationsData;
    }
}
