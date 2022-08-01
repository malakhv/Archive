package tv.nemo.box.updater.request;

import android.util.Pair;

import com.vectordigital.commonlibs.exceptions.ServerApiException;
import com.vectordigital.commonlibs.server.LocalNetworkCache;
import com.vectordigital.commonlibs.server.SimpleServerApi;

import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class UpdaterAPI extends SimpleServerApi {
    private static class NemoServerCache implements LocalNetworkCache{
        private class Entity extends Pair<Date, String> {
            public Entity(Date first, String second) {
                super(first, second);
            }
        }
        private Map<String, Entity> cacheMap = new LinkedHashMap<String, Entity>();

        @Override
        public void storeData(String id, Date storeDate, String eTag) {
            cacheMap.put(id, new Entity(storeDate, eTag));
        }

        @Override
        public Date getCacheDate(String id) {
            if(cacheMap.containsKey(id))
                return cacheMap.get(id).first;
            return null;
        }

        @Override
        public String getETag(String id) {
            if(cacheMap.containsKey(id))
                return cacheMap.get(id).second;
            return null;
        }
    }

    public UpdaterAPI(){
        super(new NemoServerCache());
    }

    public Boolean isActiveDevice(String deviceID, String platform) throws ServerApiException {
        return processRequest(new ActivateRequest(deviceID, platform), null, false);
    }

    public List<AppData> getAppList(String deviceID, String platform)
            throws ServerApiException {
        return processRequest(new AppListRequest(deviceID, platform), null, false);
    }
}
