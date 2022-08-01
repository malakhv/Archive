package tv.nemo.box.updater;

import android.app.Activity;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.ProgressBar;
import android.widget.TextView;

import com.vectordigital.commonlibs.exceptions.ServerApiException;
import com.vectordigital.commonlibs.system.AsyncTask;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.List;

import tv.nemo.box.updater.request.UpdaterAPI;
import tv.nemo.box.updater.request.AppData;
import tv.nemo.box.updater.utils.BoxUtils;
import tv.nemo.box.updater.utils.NetUtils;
import tv.nemo.box.updater.utils.PackageUtils;

public class ActMain extends Activity implements View.OnClickListener {

    /**
     * Режим работы приложения: release (0) или testing (1). В режиме release при обновлении
     * сравниваем только имя версии, в режиме testing сравниваем все компоненты версии приложения.
     * */
    private int MODE = 1;

    /**
     * Возможные состояния Activity и соостветствующие им заголовки окна и сообщения. Каждое из
     * состояний характеризует определенный этап процедуры обновления. Activity может находиться в
     * одном из следующих состояний:<br/><br/>
     *
     *      NO_STATE        - Состояние не определено<br/>
     *      ACT_CHECK       - Проверка активации устройства<br/>
     *      ACT_ERROR       - Ошибка активации, устройство не было активировано<br/>
     *      CON_ERROR       - Сетевое подключение отсутствует<br/>
     *      SRV_ERROR       - Сервер обновлений временно не доступен<br/>
     *      UPD_CHECK       - Проверка обновлений<br/>
     *      UPD_EXISTS      - Обновления найдены<br/>
     *      UPD_NOT_EXISTS  - Обновления не найдены<br/>
     *      UPD_DOWNLOAD    - Обновления загружаются<br/>
     *      UPD_ABORT       - Пользователь прервал загрузку обновлений<br/>
     *      UPD_INSTALL     - Обновления устанавливаются<br/>
     *      UPD_DONE        - Процедура обновления успешно завершена<br/>
     * */
    private enum ActState {

        /** Состояние не определено. */
        NO_STATE(0, 0, R.string.btn_cancel_text_close, R.drawable.img_cloud_1),

        /** Проверка активации устройства. */
        ACT_CHECK (R.string.title_update_check, R.string.state_act_check_msg,
                R.string.btn_cancel_text_cancel, R.drawable.img_cloud_1),

        /** Ошибка активации. Устройство не было активировано. */
        ACT_ERROR (R.string.title_update_check, R.string.state_act_error_msg,
                R.string.btn_cancel_text_close, R.drawable.img_cloud_1),

        /** Сетевое подключение отсутствует. */
        CON_ERROR(R.string.title_update_check, R.string.state_con_error_msg,
                R.string.btn_cancel_text_close, R.drawable.img_cloud_1),

        /** Сервер обновлений временно не доступен. */
        SRV_ERROR(R.string.title_update_check, R.string.state_srv_error_msg,
                R.string.btn_cancel_text_close, R.drawable.img_cloud_1),

        /** Проверка обновлений. */
        UPD_CHECK (R.string.title_update_check, R.string.state_upd_check_msg,
                R.string.btn_cancel_text_cancel, R.drawable.img_cloud_1),

        /** Обновления найдены. */
        UPD_EXISTS (R.string.title_update_exists, R.string.state_upd_exists_msg,
                R.string.btn_cancel_text_cancel, R.drawable.img_cloud_2),

        /** Обновления не найдены. */
        UPD_NOT_EXISTS(R.string.title_update_check, R.string.state_upd_no_exists_msg,
                R.string.btn_cancel_text_close, R.drawable.img_cloud_1),

        /** Обновления загружаются. */
        UPD_DOWNLOAD(R.string.title_update_exists , R.string.state_upd_updating_msg,
                R.string.btn_cancel_text_abort, R.drawable.img_cloud_2),

        /** Пользователь прервал загрузку обновлений. */
        UPD_ABORT(R.string.title_update_exists , R.string.state_upd_abort_msg,
                R.string.btn_cancel_text_close, R.drawable.img_cloud_2),

        /** Обновления устанавливаются. */
        UPD_INSTALL(R.string.title_update_exists , R.string.state_upd_install_msg,
                R.string.btn_cancel_text_abort, R.drawable.img_cloud_2),

        /** Процедура обновления успешно завершена. */
        UPD_DONE(R.string.title_update_done , R.string.state_upd_done_msg,
                R.string.btn_cancel_text_close, R.drawable.img_cloud_1);

        /** Идентификатор заголовка окна в ресурсах приложения */
        private int titleId = 0;

        /** Идентификатор сообщения в ресурсах приложения */
        private int msgId = 0;

        /** Идентификатор надписи на кнопке "Отмена" в ресурсах приложения */
        private int btnId = 0;

        /** Идентификатор картинки в Progress Bar */
        private int imgId = 0;

        /** Конструктор */
        private ActState(int titleId, int msgId, int btnId, int imgId) {
            this.titleId = titleId; this.msgId = msgId; this.btnId = btnId; this.imgId = imgId; }

        /** Возвращает идентификатор ресурса заголовка окна для текущего значения перечисления. */
        public int getTitleId() { return titleId; }

        /** Возвращает идентификатор ресурса сообщения для текущего значения перечисления. */
        public int getMsgId() { return msgId; }

        /**
         * Возвращает идентификатор ресурса надписи на кнопке "Отмена" для текущего значения
         * перечисления.
         * */
        public int getBtnId() { return btnId; }

        /**
         * Возвращает идентификатор ресурса изображения в Progress Bar для текущего значения
         * перечисления.
         * */
        public int getImgId() { return imgId; }

        /** Возвращает значение по умолчанию */
        public static ActState getDef() { return NO_STATE; }

    }

    /** Текущее состояние Activity. */
    private ActState actState = ActState.getDef();

    /** Список URL для скачивания обновлений. */
    //private String[] appUrls = null;

    /** Список обновлений. */
    private AppData[] updList = null;

    private UpdaterAPI updaterAPI = new UpdaterAPI();

    /** Серийный номер устройства. */
    private String serialNumber = BoxUtils.SERIAL_UNKNOWN;

    /** Объект для загрузки файлов обновлений в фоновом потоке. */
    private DownloadFileFromURL updDownloader = null;

    /** Имя файла для обновления Updater'а (самого себя) */
    private String itselfFileName = null;

    /**
     * Компоненты пользовательского интерфейса.
     * */

    /** Заголовок окна. */
    private TextView title = null;
    /** Текущий статус. */
    private TextView state = null;

    /** Кнопка "Обновить". */
    private Button btnUpdate = null;
    /** Кнопка "Отмена". */
    private Button btnCancel = null;

    /** Список приложений для обновления. */
    private ListView appList = null;

    /** Progress Bar */
    private ProgressBar progressBar = null;

    /** Прогресс загрузки в % (текст) */
    private TextView progressText = null;

    /** Картинка в Progress Bar */
    private ImageView progressImage = null;

    /** Установка нового состояния Activity. */
    private void setActState(ActState newState) {
        if (actState != newState) updateState(actState, newState);
    }

    /**
     * Обновляет Activity в соответствии с новым состоянием.
     * */
    private void updateState(ActState oldState, ActState newState) {

        /* Меняем текущее состояние */
        actState = newState;

        /* Обновляем заголовок окна */
        title.setText(this.getString(actState.getTitleId()));

        /* Обновляем текст сообщения */
        if (actState != ActState.ACT_ERROR)
            state.setText(this.getString(actState.getMsgId()));
        else
            state.setText(this.getString(actState.getMsgId(), serialNumber));

        /* Изображение в Progress Bar */
        progressImage.setImageResource(actState.getImgId());

        /* Кнопка "Отмена" неактивна только во время установки приложений */
        btnCancel.setEnabled(actState != ActState.UPD_INSTALL);
        btnCancel.setFocusable(actState != ActState.UPD_INSTALL);
        btnCancel.setActivated(actState != ActState.UPD_INSTALL);

        /* Кнопка "Обновить" активна, только когда есть обновления */
        btnUpdate.setEnabled(actState == ActState.UPD_EXISTS);
        btnUpdate.setActivated(actState == ActState.UPD_EXISTS);
        btnUpdate.setFocusable(actState == ActState.UPD_EXISTS);

        /* Надпись на кнопке "Отмена" */
        btnCancel.setText(actState.getBtnId());

        /* Список приложений виден только когда есть обновления */
        appList.setVisibility(actState == ActState.UPD_EXISTS ? View.VISIBLE : View.INVISIBLE);

        /* Проверка Активации */
        if (actState == ActState.ACT_CHECK) { checkActivation(); return; }

        /* Проверка обновлений */
        if (actState == ActState.UPD_CHECK) { checkUpdates(); return; }

        /* Обновления найдены */
        if (actState == ActState.UPD_EXISTS) { btnUpdate.requestFocus(); return; }

        /* Загрузка обновлений */
        if (actState == ActState.UPD_DOWNLOAD || actState == ActState.UPD_INSTALL ||
                actState == ActState.UPD_ABORT || actState == ActState.CON_ERROR ||
                actState == ActState.SRV_ERROR) {
            resetProgress();
        }

    }

    /** Сброс Progress Bar */
    public void resetProgress() {

        /* Сброс значения надписи */
        progressText.setText("0%");

        /*
         * Если идет загрузка обновлений (UPD_DOWNLOAD), показываем надпись и убираем картинку,
         * иначе наоборот
         * */
        if (actState == ActState.UPD_DOWNLOAD) {
            progressText.setVisibility(View.VISIBLE);
            progressImage.setVisibility(View.INVISIBLE);
        } else {
            progressText.setVisibility(View.INVISIBLE);
            progressImage.setVisibility(View.VISIBLE);
        }

        /* Обнуляем значение в Progress Bar */
        progressBar.setProgress(0);
    }

    /** Обновляем текущий прогресс. */
    public void updateProgress(int progress) {

        /* Не доходим до максимума, иначе появляются проблемы отрисовки в круглом Progress Bar */
        if (progress == progressBar.getMax()) return;

        /* Обновляем значения в Progress Bar и надписи */
        progressBar.setProgress(progress);
        progressText.setText(String.valueOf(progress) + "%");

    }

    /**
     * Инициализация компонентов пользовательского интерфейса.
     * */
    private void initUi() {
        /* Заголовок окна */
        title = (TextView) findViewById(R.id.title);

        /* Текущий статус */
        state = (TextView) findViewById(R.id.status);

        /* Кнопка "ОК" */
        btnUpdate = (Button) findViewById(R.id.btn_update);
        btnUpdate.setOnClickListener(this);

        /* Кнопка "Cancel" */
        btnCancel = (Button) findViewById(R.id.btn_cancel);
        btnCancel.setOnClickListener(this);

        /* Список обновлений */
        appList = (ListView) findViewById(R.id.list);

        /* Progress Bar */
        progressBar = (ProgressBar) findViewById(R.id.progressBar);
        progressText = (TextView) findViewById(R.id.progressText);
        progressImage = (ImageView) findViewById(R.id.progressImage);

    }

    /**
     * Создание Activity.
     * */
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.act_main);

        /* Инициализация компонентов UI */
        initUi();

        // TODO Для тестирования ситуации "Устройство не активировано" можно добавить к serialNumber любой символ
        /* Получаем серийный номер устройства */
        serialNumber = BoxUtils.getSerial();

        /* Устанавливаем состояние Activity */
        setActState(ActState.ACT_CHECK);

    }

    /**
     * Установка приложений в "тихом" режиме.
     * */
    private int installApp(String fileName) {
        int ret = PackageUtils.installByShell(this.getApplicationContext(), fileName, " -r -f ");
        return ret;
    }

    /**
     * Проверка активации устройства.
     * */
    public void checkActivation() {

        /* Если нет сети, меняем состояние и выходим */
        if (!NetUtils.isConnected(this)) { setActState(ActState.CON_ERROR); return; }

        /* Создаем поток, в котором и будем проверять активировано устройство или нет */
        new Thread() {
            @Override
            public void run() {

                boolean activation = false;

                /* Запрос данных об активации устройства у сервера */
                try {
                    activation = updaterAPI.isActiveDevice(serialNumber, "android_box");
                } catch (ServerApiException e) {
                    runOnUiThread(new Runnable() {
                        @Override
                        public void run() { setActState(ActState.SRV_ERROR); } });
                    return;
                }

                /* Проверка активации */
                if (activation)
                    // Устройство активировано
                    runOnUiThread(new Runnable() {
                        @Override
                        public void run() { setActState(ActState.UPD_CHECK); }});
                else
                    // Ошибка активации
                    runOnUiThread(new Runnable() {
                        @Override
                        public void run() { setActState(ActState.ACT_ERROR); } });
            }
        }.start();

    }

    /**
     * Получение списка приложений, которые необходимо обновить.
     * */
    private void checkUpdates() {

        /* Создаем поток, в котором будем получать список приложений */
        new Thread() {

            @Override
            public void run() {

                /* Список приложений */
                List<AppData> appDataList;

                /* Запрос данных о приложениях у сервера */
                try {
                    appDataList = updaterAPI.getAppList(serialNumber, "android_box");
                } catch (ServerApiException e) {
                    appDataList = null;
                }

                // TODO Для тестирования ситуации "Сервер временно не доступен" нужно выполнить: appDataList = null

                /* Если список не удалось получить, возможно проблемы на сервере */
                if (appDataList == null) {

                    /* Сервер обновлений временно не доступен */
                    runOnUiThread(new Runnable() {
                        @Override
                        public void run() { setActState(ActState.SRV_ERROR); } });

                    /* Выходим */
                    return;
                }

                /* Проверка пришедших от сервера данных */
                if (appDataList.size() > 0) {

                    /* Проверка версий приложений */
                    for (int i = appDataList.size() - 1; i >= 0; i--) {
                        AppData appData = appDataList.get(i);
                        if (equalsVersion(appData.getAppID(), appData.getVersion(), MODE))
                            // Если приложение не нужно обновлять, удаляем его из списка
                            appDataList.remove(i);
                    }

                    /* Проверка нужно ли обновлять себя */
                    /*for (int i = appDataList.size() - 1; i >= 0; i--) {
                        AppData appData = appDataList.get(i);
                        if (appData.getAppID().equals(getPackageName())) appDataList.remove(i);
                    } */

                    // TODO Для стресс теста в этом месте можно увеличить размер списка простым копированием
                    //appDataList.addAll(appDataList); // 8
                    //appDataList.addAll(appDataList); // 16
                    //appDataList.addAll(appDataList); // 32

                    // TODO Для тестирования ситуации "Обновления не найдены" нужно заменить ">" на "<" в условии
                    /* Проверяем, есть ли приложения, которые нужно обновить */
                    if (appDataList.size() > 0) {

                        /* Обновления найдены */
                        //final List<AppData> finalAppDataList = appDataList;
                        updList = appDataList.toArray(new AppData[appDataList.size()]);
                        runOnUiThread(new Runnable() {
                            @Override
                            public void run() {
                                //loadAppList(finalAppDataList);
                                loadAppList();
                                setActState(ActState.UPD_EXISTS);
                            }
                        });

                        /* Выходим */
                        return;
                    }
                }

                /* Обновления не найдены */
                runOnUiThread(new Runnable() {
                    @Override
                    public void run() { setActState(ActState.UPD_NOT_EXISTS); } });

            }

        }.start();

    }

    /**
     * Формирование списка приложений, для которых обновление найдено.
     * */
    private void loadAppList() {

        /* Проверка updList */
        if (updList == null || updList.length <= 0) return;

        /* Размер списка приложений */
        int size = updList.length;

        /* Элементы списка */
        String[] items = new String[size];

        /* Формирование элементов списка */
        for (int i = 0; i < size; i++)
            items[i] = updList[i].getTitle() + " до версии " + updList[i].getVersion();

        /* Настройка адаптера */
        appList.setAdapter(new ArrayAdapter<String>(this, R.layout.list_item, items));

    }

    /**
     * Проверка версии приложения. Может работать в двух режимах, release (mode=0) и
     * testing (mode=1).
     * */
    private boolean equalsVersion(String packageName, String version, int mode) {

        /* Проверка входных параметров */
        if (packageName == null || packageName.length() <= 0) return false;

        /* Получаем код и имя версии установленного приложения */
        int verCode = -1;
        String verName = "";
        try {
            PackageInfo info = getPackageManager().getPackageInfo(packageName, 0);
            verName = info.versionName;
            verCode = info.versionCode;
        } catch (PackageManager.NameNotFoundException e) {
            e.printStackTrace();
        }

        /* Сравниваем и возвращаем значение */
        if(mode == 0) {
            String tmp = version.substring(0, version.lastIndexOf("."));
            return  verName.equals(tmp);
        } else
            return  (verName + "." + verCode).equals(version);
    }

    /**
     * Обработчик нажатия кнопок в Activity.
     * */
    @Override
    public void onClick(View view) {

        /* Получаем id кнопки */
        if (view == null) return;
        int id = view.getId();

        /* Кнопка "Обновить" */
        if (id == R.id.btn_update) {

            /* Обновляем состояние */
            setActState(ActState.UPD_DOWNLOAD);

            /* Запускаем загрузку файлов */
            updDownloader = new DownloadFileFromURL();
            //updDownloader.execute(appUrls);
            updDownloader.execute(updList);

        }

        /* Кнопка "Отмена" */
        if (id == R.id.btn_cancel) {

            /* Если находимся в состоянии скачивания обновлений, прерываем загрузку */
            if (actState == ActState.UPD_DOWNLOAD) {
                if (updDownloader != null) updDownloader.cancel(true); return;
            }

            if (actState == ActState.UPD_DONE) {
                if (itselfFileName != null) installApp(itselfFileName);
            }

            /* Выходим из приложения */
            close();

        }

    }

    /** Пустой обработчик кнопки "Back". */
    @Override
    public void onBackPressed() {}

    /**
     * Activity переходит в состояние "Stop".
     * */
    @Override
    protected void onStop() {
        super.onStop();
        if (actState == ActState.UPD_INSTALL) return;
        if (!this.isFinishing()) close();
    }

    /**
     * Завершает работу Activity.
     * */
    private void close() {

        /* Если сейчас скачиваются обновления, пытаемся остановить поток */
        if (updDownloader != null) { updDownloader.cancel(false); updDownloader = null; }

        /* Выходим */
        finish();

    }

    private class DownloadFileFromURL extends AsyncTask<AppData, Long, String> {

        /** Максимальное количество попыток повторной загрузки при редиректе. */
        private static final int MAX_REDIRECT_COUNT = 5;

        /** Информация о последней ошибке */
        private Exception lastError = null;

        /** Путь закачки обновлений. */
        public static final String DOWNLOAD_PATH = "/storage/emulated/legacy/Download/Nemo/";

        /** Вызывается перед методом doInBackground. */
        @Override
        protected void onPreExecute() { super.onPreExecute(); resetProgress(); }

        @Override
        protected String doInBackground(AppData... params) {

            /* Проверка входных параметров */
            if (params == null || params.length <= 0)  return "Wrong parameters";

            /* Поток для получения данных от web-сервера */
            InputStream iStream;

            /* Поток для записи данных в файл */
            FileOutputStream oStream;

            /* Переменная для хранения информации о текущем приложении */
            AppData appData;

            /* Загрузка файлов */
            for (int i = 0; i < params.length; i++) {

                /* Если поток был отменен - завершаем цикл */
                if (isCancelled()) break;

                HttpURLConnection.setFollowRedirects(true);
                HttpURLConnection urlConnection;

                appData = params[i];

                try {

                    /* Текущее значение количества попыток повторной загрузки при редиректе */
                    byte loadCount = 0;

                    /* Если равно true - был факт редиректа и нужно запустить загрузку еще раз */
                    boolean needReload;

                    /* Ссылка на файл для загрузки */
                    //URL url = new URL(params[i]);
                    URL url = new URL(appData.getUrl());

                    /* Настройка соединения и попытка получения данных */
                    do {

                        /* Настройка соединения */
                        urlConnection = (HttpURLConnection) url.openConnection();
                        urlConnection.setReadTimeout(60000);
                        urlConnection.setConnectTimeout(15000);
                        urlConnection.setDoInput(true);
                        urlConnection.connect();

                        /* Получение кода ответа сервера */
                        int responseCode = urlConnection.getResponseCode();

                        /*
                         * Проверка на факт редиректа и превышения количества попыток
                         * повторных загрузок. Возможные HTTP коды при редиректе:
                         *
                         *  "300" Multiple Choices (несколько вариантов на выбор)
                         *  "301" Moved Permanently (перемещено навсегда)
                         *  "302" Temporary Redirect (временный редирект)
                         *  "303" See Other (затребованный ресурс можно найти по др. адресу)
                         *  "304" Not Modified (содержимое не изменялось)
                         *  "305" Use Proxy (доступ должен осуществляться через прокси)
                         *  "306" (Unused) (не используется)
                         *
                         *  Если needReload будет равно true - попытаемся загрузить данные еще раз
                         *
                         * */
                        needReload = (responseCode >= 300 && responseCode <= 304) &&
                                ++loadCount < MAX_REDIRECT_COUNT;

                        /*
                         * Если нужно попытаться загрузить данные еще раз, копируем новый адрес и
                         * разрываем соединение
                         * */
                        if (needReload && !isCancelled()) {
                            url = urlConnection.getURL();
                            urlConnection.disconnect();
                        }

                    } while (needReload);

                    /* Размер данных */
                    int lengthOfFile = urlConnection.getContentLength();

                    File dir = new File(DOWNLOAD_PATH);
                    /* Если каталога не существует, создаём его */
                    if (!dir.exists()) dir.mkdirs();

                    /* Имя файла */
                    String fileName = "temp" + i + ".apk";

                    /* Если поток был отменен - завершаем цикл */
                    if (isCancelled()) break;

                    oStream = new FileOutputStream(new File(dir, fileName));
                    iStream = urlConnection.getInputStream();

                    int len;
                    byte[] buffer = new byte[1024];
                    long total = 0;

                    while ((len = iStream.read(buffer)) >= 0 && !isCancelled()) {
                        total += len;
                        oStream.write(buffer, 0, len);
                        publishProgress((100 / params.length) * i + (total * (100 / params.length))
                                / lengthOfFile);
                    }

                    /* Закрываем потоки данных */
                    oStream.close();
                    iStream.close();

                    /*
                     * Если файл успешно загружен, запоминаем его имя для соответствующего элемента
                     * в списке обновлений.
                     * */
                    appData.setFileName(DOWNLOAD_PATH + fileName);

                } catch (Exception e) {
                    Log.e(ActMain.class.getName(), e.getMessage()); lastError = e; return null;
                }
            }

            /* Если поток был отменен - выходим */
            if (isCancelled()) return null;

            /*
             * Все файлы загружены, можно начинать установку
             * */

            /*
             * Переменная, для хранения имени скачанного файла приложения Updater
             * (если нужно обновить себя).
             * */
            String itselfFileName = null;

            /* Имя пакета приложения */
            String itselfPackage = getPackageName();

            /* Обновляем состояние Activity */
            runOnUiThread(new Runnable() {
                @Override
                public void run() { setActState(ActState.UPD_INSTALL); } });

            /* Устанавливаем приложения */
            for (int i = 0; i < params.length; i++) {

                if (!params[i].getAppID().equals(itselfPackage))
                    installApp(params[i].getFileName());
                else
                    itselfFileName =params[i].getFileName();
            }

            /* Выходим */
            return itselfFileName;

        }

        /** Обновление информации о текущем прогрессе. */
        @Override
        protected void onProgressUpdate(Long... values) {

            /* Если поток был отменен - выходим */
            if (isCancelled()) return;

            /* Проверка входных параметров */
            if (values == null || values.length <= 0) return;

            /* Обновляем progress bar */
            updateProgress(values[0].intValue());

        }

        /** Вызывается после метода doInBackground. */
        @Override
        protected void onPostExecute(String s) {
            updDownloader = null;
            if (lastError == null) {
                itselfFileName = s;
                setActState(ActState.UPD_DONE);
            } else setActState(ActState.SRV_ERROR);
        }

        /** Вызывается после метода doInBackground, если поток был прерван. */
        @Override
        protected void onCancelled() { setActState(ActState.UPD_ABORT); updDownloader = null; }

    }

}