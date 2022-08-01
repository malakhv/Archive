private class UpdateInstaller extends AsyncTask<AppData, Long, Exception> {

        /** Путь закачки обновлений. */
        public static final String DOWNLOAD_PATH = "/storage/emulated/legacy/Download/Nemo/";

        /** Максимальное количество попыток повторной загрузки при редиректе. */
        private static final int MAX_REDIRECT_COUNT = 5;

        /** Конструктор. */
        public UpdateInstaller() {
            super();
            /* Создаем каталог, если его еще нет */
            File dir = new File(FileList.DOWNLOAD_PATH);
            if (!dir.exists()) dir.mkdirs();
        }

        /**
         * Выполняет фоновую установку и загрузку обновлений.
         * */
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
                     * Если исключений не возникло - считаем что файл успешно скачан и записан на
                     * диск, можно сохранять имя.
                     * */
                    appData.setFileName(fileName);

                } catch (Exception e) { return e; }

            }

            /* Если была попытка завершить поток, выходим */
            if (isCancelled()) return null;

            /* Загрузка завершена, обновляем состояние Activity */
            runOnUiThread(new Runnable() {
                @Override
                public void run() { setActState(ActState.UPD_INSTALL); } });

            /* Установка приложений */
            for (int i = 0; i < params.length; i++) {

                /* Текущее обновление (просто для удобства) */
                appData = params[i];

                // TODO убрать константу и вписать ког получения текущего пакета приложения
                if ("tv.nemo.box.updater".equals(appData.getAppID())) continue;

                /* Проверяем, есть ли имя файла и запускаем установку */
                if( appData.hasFileName()) installApp(appData.getFileName());

            }

            /* Если дошли до этого места - считаем, что ошибок нет */
            return null;
        }

        /** Обновление информации о текущем прогрессе. */
        @Override
        protected void onProgressUpdate(Long... values) {

            /* Если была попытка завершить поток, выходим */
            if (isCancelled()) return;

            /* Проверка входных параметров */
            if (values == null || values.length <= 0) return;

            /* Обновляем progress bar */
            updateProgress(values[0].intValue());

        }

        /** Вызывается после метода doInBackground. */
        @Override
        protected void onPostExecute(Exception e) {
            updDownloader = null;
            if (e == null)
                setActState(ActState.UPD_DONE);
            else
                setActState(ActState.SRV_ERROR);
        }

        /** Вызывается после метода doInBackground, если поток был прерван. */
        @Override
        protected void onCancelled() { updDownloader = null; setActState(ActState.UPD_ABORT); }

    }
