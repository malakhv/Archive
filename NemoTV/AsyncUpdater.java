package tv.nemo.box.updater;

import android.util.Log;

import com.vectordigital.commonlibs.system.AsyncTask;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;

import tv.nemo.box.updater.request.AppData;

/**
 * Created by malakhv on 05.11.14.
 */
public class AsyncUpdater extends AsyncTask<AppData, Object, Exception> {

    /** Путь закачки обновлений. */
    public static final String DOWNLOAD_PATH = "/storage/emulated/legacy/Download/Nemo/";

    /** Максимальное количество попыток повторной загрузки при редиректе. */
    private static final int MAX_REDIRECT_COUNT = 5;

    /** Информация о последней ошибке */
    private Exception lastError = null;

    /** Обновлять ли самого себя, или нет */
    private boolean installItself = false;

    /**
     * Интерфейс, описывающий методы обратного вызова.
     * */
    public static interface UpdaterCallbacks {
        public void onDownloadProgress(int progress, AppData appData, Exception e);
        public void onUpdateComplete(Exception e);
        public void onUpdateCancel();
    }

    /** Конструктор. */
    public AsyncUpdater() {
        super();
        /* Создаем каталог, если его еще нет */
        File dir = new File(FileList.DOWNLOAD_PATH);
        if (!dir.exists()) dir.mkdirs();
    }

    /**
     * Скачивает и устанавливает обновления в фоновом режиме.
     */
    @Override
    protected Exception doInBackground(AppData... params) {

        /* Проверка входных параметров */
        if (params == null || params.length <= 0)
            return new IllegalArgumentException("params is null or empty");

        /* Настройка редиректа */
        HttpURLConnection.setFollowRedirects(true);

        /* Переменная для получения данных по протоколу HTTP */
        HttpURLConnection urlConnection;

        /* Поток для получения данных от web-сервера */
        InputStream iStream;
        /* Поток для записи данных в файл */
        FileOutputStream oStream;

        /* Переменная для хранения текущей информации об обновлении */
        AppData appData;

        /* Текущее значение количества попыток повторной загрузки при редиректе */
        byte attemptCount = 0;

        /* Если равно true - был факт редиректа и нужно запустить загрузку еще раз */
        boolean needAttempt = false;

        /* Скачиваем обновления для каждого элемента массива params */
        for (int i = 0; i < params.length; i++) {

            /* Если была попытка завершить поток, выходим */
            if (isCancelled()) return null;

            /* Текущее обновление (просто для удобства) */
            appData = params[i];

            /* Ссылка для скачивания файла */
            URL url;
            try {
                url = new URL(appData.getUrl());
            } catch (MalformedURLException e) { return e; }

             /* Настройка соединения и загрузка данных */
            try {

                /* Сбрасываем значение количества попыток редиректа */
                attemptCount = 0;

                do {

                    /* Настройка соединения */
                    urlConnection = (HttpURLConnection) url.openConnection();
                    urlConnection.setReadTimeout(60000);
                    urlConnection.setConnectTimeout(15000);
                    urlConnection.setDoInput(true);
                    urlConnection.connect();

                    /* Получение кода ответа сервера */
                    int responseCode = urlConnection.getResponseCode();

                    /* Определяем, нужна ли еще одна попытка (был ли редирект) */
                    needAttempt = (responseCode >= 300 && responseCode <= 304) &&
                            ++attemptCount < MAX_REDIRECT_COUNT;

                } while (needAttempt);

                /* Если была попытка завершить поток, выходим */
                if (isCancelled()) return null;

                /* Размер данных */
                int l = urlConnection.getContentLength();

                /* Имя файла */
                String fileName = DOWNLOAD_PATH + "temp" + i + ".apk";

                /* Поток для записи данных в файл */
                oStream = new FileOutputStream(new File(fileName));

                /* Поток для чтения файлов */
                iStream = urlConnection.getInputStream();

                /* Запись файла на диск */
                int len;
                byte[] buffer = new byte[1024];
                long total = 0;
                while ((len = iStream.read(buffer)) >= 0 && !isCancelled()) {
                    total += len;
                    oStream.write(buffer, 0, len);
                    publishProgress((100 / params.length) * i + (total * (100 / params.length)) / l);
                }

                /* Закрываем потоки данных */
                oStream.close();
                iStream.close();

                /*
                 * Если исключений не возникло - считаем что файл успешно скачан и записан
                 * на диск, можно сохранять имя.
                 * */
                appData.setFileName(fileName);

            } catch (Exception e) { return e; }

            /* Если была попытка завершить поток, выходим */
            if (isCancelled()) return null;

        }

        return null;
    }
}