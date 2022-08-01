package tv.nemo.box.updater;

import android.app.Activity;
import android.app.FragmentManager;
import android.app.FragmentTransaction;
import android.app.ProgressDialog;
import android.content.pm.PackageManager;
import android.os.Build;
import android.os.Bundle;
import android.provider.Settings;
import android.util.Log;

import com.vectordigital.commonlibs.exceptions.ServerApiException;
import com.vectordigital.commonlibs.system.AsyncTask;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

import tv.nemo.box.updater.file.FileController;
import tv.nemo.box.updater.fragments.ErrorFragment;
import tv.nemo.box.updater.fragments.UpdateFragment;
import tv.nemo.box.updater.request.UpdaterAPI;
import tv.nemo.box.updater.request.data.ApplicationData;

public class UpdateActivity extends Activity implements UpdateFragment.UpdateListener, ErrorFragment.ErrorListener {

    private ArrayList<String> applicationsInfo;
    private ArrayList<String> urls;
    private ProgressDialog pDialog;

    private FragmentManager fragmentManager = getFragmentManager();
    private UpdaterAPI updaterAPI = new UpdaterAPI();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        Log.d("MODEL ", Build.DISPLAY);
        Log.d("MODEL ", Build.ID);
        setContentView(R.layout.update_activity);
        pDialog = new ProgressDialog(this);
        checkActive();
    }

    @Override
    public void checkActive() {
        new Thread() {
            @Override
            public void run() {

                boolean isActive = false;
                try {
                    isActive = updaterAPI.isActiveDevice(Settings.Secure.getString(getContentResolver(), Settings.Secure.ANDROID_ID), "android_box");
                } catch (ServerApiException e) {
                    e.printStackTrace();
                }

                // not registered device
                if (!isActive) {
                    runOnUiThread(new Runnable() {
                        @Override
                        public void run() {
                            // error form
                            FragmentTransaction fragmentTransaction = fragmentManager.beginTransaction();
                            Bundle bundle = new Bundle();
                            bundle.putString("DEVICE_ID", Settings.Secure.getString(getContentResolver(), Settings.Secure.ANDROID_ID));
                            final ErrorFragment errorFragment = new ErrorFragment();
                            errorFragment.setArguments(bundle);
                            fragmentTransaction.replace(R.id.app_fragment, errorFragment);
                            fragmentTransaction.commit();
                            android.os.Handler handler = new android.os.Handler(getMainLooper());
                            handler.post(new Runnable() {
                                @Override
                                public void run() {
                                    if (errorFragment.getView() != null)
                                        errorFragment.getView().requestFocus();
                                }
                            });
                        }
                    });

                    //device is registered in admin sys
                } else {
                    List<ApplicationData> applicationDataList = null;
                    try {
                        applicationDataList = updaterAPI.getApplicationsOfDevice(Settings.Secure.getString(getContentResolver(), Settings.Secure.ANDROID_ID), "android_box");
                    } catch (ServerApiException e) {
                        //todo
                    }

                    applicationsInfo = new ArrayList<String>();
                    urls = new ArrayList<String>();
                    for (int i = 0; i < applicationDataList.size(); i++) {
                        if (!checkVersion(applicationDataList.get(i).getAppID(), applicationDataList.get(i).getVersion())) {
                            urls.add(applicationDataList.get(i).getUrl());
                            applicationsInfo.add("Приложение " + applicationDataList.get(i).getDescription()
                                    + "обновится до версии " + applicationDataList.get(i).getVersion());
                        }
                    }

                    /* Just for test */
                     /* for (int i = 0; i < 5; i++) {
                        urls.add("http://yastatic.net/morda-logo/i/logo.png");
                        applicationsInfo.add("Приложение " + i + " обновится до версии X");
                    }*/

                    runOnUiThread(new Runnable() {
                        @Override
                        public void run() {
                            //setContentView(R.layout.update_activity);
                            FragmentTransaction fragmentTransaction = fragmentManager.beginTransaction();
                            Bundle bundle = new Bundle();

                            bundle.putStringArrayList("LIST", applicationsInfo);
                            final UpdateFragment updateFragment = new UpdateFragment();
                            updateFragment.setArguments(bundle);
                            //updateFragment.setApplicationsInfo(applicationsInfo);

                            fragmentTransaction.replace(R.id.app_fragment, updateFragment);
                            fragmentTransaction.commit();
                            android.os.Handler handler = new android.os.Handler(getMainLooper());
                            handler.post(new Runnable() {
                                @Override
                                public void run() {
                                    updateFragment.getView().requestFocus();
                                }
                            });
                        }
                    });
                }
            }
        }.start();


    }


    private boolean checkVersion(String appID, String version) {
        // get version
        String versionName = "";
        int num = -1;

        try {
            versionName = getPackageManager().getPackageInfo(appID, 0).versionName;
            num = getPackageManager().getPackageInfo(appID, 0).versionCode;
        } catch (PackageManager.NameNotFoundException e) {
            e.printStackTrace();
        }
        return ((versionName + "." + num).equals(version)) ? true : false;
    }


    @Override
    public void downloadFiles() {
        new DownloadFileFromURL().execute(urls.toArray(new String[urls.size()]));
    }

    @Override
    public void closeActivity() {
        finish();
    }


    private class DownloadFileFromURL extends AsyncTask<String, Long, String> {

        private FileController fileController = new FileController();

        @Override
        protected void onPreExecute() {
            super.onPreExecute();

            pDialog.setMessage("Downloading file. Please wait...");
            pDialog.setIndeterminate(false);
            pDialog.setMax(100);
            pDialog.setProgressStyle(ProgressDialog.STYLE_HORIZONTAL);
            pDialog.setCancelable(false);
            pDialog.show();

        }

        @Override
        protected String doInBackground(String... params) {

            /* Максимальное количество попыток повторной загрузки при редиректе */
            final byte maxLoadCount = 5;

            for (int i = 0; i < params.length; i++) {
                URL url = null;

                try {
                    url = new URL(params[i]);
                } catch (MalformedURLException e) {
                    //todo
                }
                HttpURLConnection.setFollowRedirects(true);
                HttpURLConnection urlConnection = null;
                try {

                    /* Текущее значение количества попыток повторной загрузки при редиректе */
                    byte loadCount = 0;

                    /* Если равно true - был факт редиректа и нужно запустить загрузку еще раз */
                    boolean needReload = false;

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

                        /**
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
                                ++loadCount < maxLoadCount;

                        /**
                         * Если нужно попытаться загрузить данные еще раз, копируем новый адрес и
                         * разрываем соединение
                         * */
                        if (needReload) {
                            url = urlConnection.getURL();
                            urlConnection.disconnect();
                        }

                    } while (needReload);

                    /* Размер данных */
                    int lengthOfFile = urlConnection.getContentLength();

                    File dir = new File(FileController.PATH_DOWNLOAD );
                   //+ "temp" + fileController.getNameDownloadFiles().size() + ".apk"

                    if (!dir.exists()) {
                        dir.mkdirs();
                        //file.createNewFile();
                    }

                    String nameFile = "temp" + fileController.getNameDownloadFiles().size() + ".apk";
                    fileController.getNameDownloadFiles().add(nameFile);

                    FileOutputStream fos = new FileOutputStream(new  File (dir, nameFile));
                    //urlConnection.connect();
                    InputStream is = urlConnection.getInputStream();
                    int len;
                    byte[] buffer = new byte[1024];
                    long total = 0;

                    while ((len = is.read(buffer)) >= 0) {
                        total += len;
                        fos.write(buffer, 0, len);
                        publishProgress((100 / params.length) * i + (total * (100 / params.length)) / lengthOfFile);
                    }
                    fos.close();
                    is.close();

                } catch (FileNotFoundException e) {
                    Log.e(UpdateActivity.class.getName(), "File is not found. Download url - " + url.toString(), e);
                } catch (IOException e) {
                    Log.e(UpdateActivity.class.getName(), "Error during file downloads. Download url - " + url.toString(), e);
                }
            }
            return null;
        }


        @Override
        protected void onProgressUpdate(Long... values) {
            super.onProgressUpdate(values);
            pDialog.setProgress(values[0].intValue());
        }

        @Override
        protected void onPostExecute(String s) {
            super.onPostExecute(s);
            pDialog.dismiss();
            finish();
            File dir = new File(FileController.PATH_DOWNLOAD);
            if (dir.exists()) {
                for (String fileName : fileController.getNameDownloadFiles()) {
                    File file = new File(dir, fileName);
                    if (!file.isDirectory()) {
                        //Intent intent = new Intent(Intent.ACTION_VIEW);

                        //Uri uri = Uri.fromFile(file);
//                                            Runtime.getRuntime().exec("su");
//                                           Runtime.getRuntime().exec("pm install " + "/storage/emulated/legacy/Download/TV-demo.apk");

                        /*String command;
                        String filename = file.getAbsolutePath().replace(" ", "\\ ");
                        command = "adb install -r " + filename;
                        Process proc = null;
                        try {
                            proc = Runtime.getRuntime().exec(new String[] { "$ su", "-c", command });
                            proc.waitFor();
                        } catch (Exception e) {
                            e.printStackTrace();
                        }*/


                        PackageManager pm = getPackageManager();
                        //PackageInstallObserver observer = new PackageInstallObserver();
                        //observer.apkpath = apk_filepath;
                        //pm.installPackage(Uri.fromFile(file), null, pm., null);
                        //pm.install

                        //intent.setDataAndType(uri, "application/vnd.android.package-archive");
                        //intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK); // without this flag android returned a intent error!
                        //startActivity(intent);
                    }
                }



            }
        }
    }


}
