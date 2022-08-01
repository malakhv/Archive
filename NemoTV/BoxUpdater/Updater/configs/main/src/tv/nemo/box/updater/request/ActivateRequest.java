package tv.nemo.box.updater.request;


import com.vectordigital.commonlibs.exceptions.ServerApiException;

import org.json.JSONException;
import org.json.JSONObject;

import tv.nemo.box.updater.Config;

public class ActivateRequest extends JsonRequest<Boolean> {

    private static final String API_DEVICE_REGISTER_DEVICE_JSON = "/api/device/register_device.json";

    public ActivateRequest(String deviceID, String platform) {
        super(Config.SERVER_URL + API_DEVICE_REGISTER_DEVICE_JSON);
        //super("http://192.168.4.90:8085" + API_DEVICE_REGISTER_DEVICE_JSON);
        JSONObject body = new JSONObject();
        try {
            body.put("device_id", deviceID);
            body.put("platform", platform);
            body.put("activation_key", deviceID);
        } catch (JSONException e) {
            e.printStackTrace();
        }

        appendParameter("", body.toString());
    }

    @Override
    protected Boolean convertParams(JSONObject params) throws ServerApiException, JSONException {
        boolean isOk = params.getString("status").equals("activated");
        /*if (!isOk) {
            throw new ServerApiException("register is not ok");
        } */
        return isOk;
    }
}
