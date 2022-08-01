package tv.nemo.box.updater.utils;

import android.content.Context;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;

/**
 * Класс, который содержит методы для работы с информацией о сетевых соединениях на устройстве.
 *
 * @author Mikhail Malakhov, 28.10.2014
 *
 */
public class NetUtils {

    /**
     * Проверяет, есть ли в данный момент сетевое соединение или нет.
     * */
    public static boolean isConnected(Context context) {

        /* Получаем объект менеджера подключений */
        ConnectivityManager mngr = (ConnectivityManager) context.getSystemService(
                Context.CONNECTIVITY_SERVICE);

        /* Информация о сети */
        NetworkInfo networkInfo = mngr.getActiveNetworkInfo();

        /* Проверяем наличие сетевого соединения и возвращаем значение. */
        return networkInfo != null && networkInfo.isConnected();

    }

}
