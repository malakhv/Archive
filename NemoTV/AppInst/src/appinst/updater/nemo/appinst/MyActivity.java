package appinst.updater.nemo.appinst;

import android.app.Activity;
import android.content.Context;
import android.content.pm.ApplicationInfo;
import android.content.pm.IPackageDeleteObserver;
import android.content.pm.IPackageInstallObserver;
import android.content.pm.PackageManager;
import android.net.Uri;
import android.os.Bundle;
import android.os.IBinder;
import android.os.RemoteException;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.TextView;

import java.io.File;


public class MyActivity extends Activity {

    private TextView tvMessage = null;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_my);
        tvMessage = (TextView) this.findViewById(R.id.tvMessage);
    }


    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.my, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();
        if (id == R.id.action_settings) {
            return true;
        }
        return super.onOptionsItemSelected(item);
    }


    private String APK_FILE_NAME = "App.apk";

    /**
     * Обработчик нажатия кнопок
     * */
    public void onClick(View v) {

        /* Если v = null, выходим */
        if (v == null) return;

        /* Идентификатор View */
        int id = v.getId();

        /* Полное имя APK файла */
        String fileName = "/storage/external_storage/sdcard1/" + APK_FILE_NAME;

        /* URI */
        Uri uri = Uri.fromFile(new File(fileName));

        /* Тихий способ 1 (shell) */
        if (id == R.id.btn1) {
            int r = PackageUtils.installSilent(this.getApplicationContext(), fileName, " -r -f ");
            tvMessage.setText(String.valueOf(r));
        }

        /* Тихий способ 2 (PM) */
        if (id == R.id.btn2) {
            int r = PackageUtils.installByPm(this.getApplicationContext(), fileName, new IPackageInstallObserver() {
                @Override
                public void packageInstalled(String s, int i) throws RemoteException {
                    tvMessage.setText(s + ":" + String.valueOf(i));
                }
                @Override
                public IBinder asBinder() {return null;}
            });

            tvMessage.append(String.valueOf(r));
            //tvMessage.setText(installSilentByPm(this, fileName));
            //String message = installSilent1(this.getApplicationContext(), fileName, " -r -f ");
            //tvMessage.setText(message);
            return;
        }

        /* Удаление (shell) */
        if (id == R.id.btn3) {
            int r = PackageUtils.uninstallSilent(this.getApplicationContext(),
                    "appforupdate.app.test.appforupdate", false);
            tvMessage.setText("Delete: " + String.valueOf(r));
            return;
        }

        /* Удаление (PM) */
        if (id == R.id.btn4) {
            int r = PackageUtils.deleteByPm(this.getApplicationContext(),
                    "appforupdate.app.test.appforupdate", null);
            tvMessage.setText("Delete: " + String.valueOf(r));
            //deleteSilentByPm(this, "appforupdate.app.test.appforupdate");
        }

    }

    /******************************************************************************************/

    public static String installSilent1(Context context, String filePath, String pmParams) {
        if (filePath == null || filePath.length() == 0) {
            return "INSTALL_FAILED_INVALID_URI";
        }

        File file = new File(filePath);
        if (file == null || file.length() <= 0 || !file.exists() || !file.isFile()) {
            return "INSTALL_FAILED_INVALID_URI";
        }

        /**
         * if context is system app, don't need root permission, but should add <uses-permission
         * android:name="android.permission.INSTALL_PACKAGES" /> in mainfest
         **/
        StringBuilder command = new StringBuilder().append("LD_LIBRARY_PATH=/vendor/lib:/system/lib pm install ")
                .append(pmParams == null ? "" : pmParams).append(" ").append(filePath.replace(" ", "\\ "));

        ShellUtils.CmdResult cmdResult = ShellUtils.execCmd(command.toString(), !isSystemApplication(context), true);

        if (cmdResult.isSuccess()) return "INSTALL_SUCCEEDED";
        if (!cmdResult.hasErrorMsg()) return "INSTALL_FAILED_OTHER";
        return cmdResult.getErrorMsg();

    }

    public String installSilentByPm(Context context, String filePath) {
        File file = new File(filePath);
        if (PackageUtils.isValidApkFile(file)) {
            PackageManager pm = getPackageManager();
            pm.installPackage(Uri.fromFile(file),null, pm.INSTALL_REPLACE_EXISTING, null);
            return "ok";
        }
        return "error";
    }

    public void deleteSilentByPm(Context context, String packageName) {

        PackageManager pm = getPackageManager();
        pm.deletePackage(packageName, new IPackageDeleteObserver() {
            @Override
            public void packageDeleted(String s, int i) throws RemoteException {
                tvMessage.setText(s + " : " + i);
            }

            @Override
            public IBinder asBinder() {return null;}
        }, PackageManager.DELETE_ALL_USERS);

    }

    /**
     * whether context is system application
     *
     * @param context
     * @return
     */
    public static boolean isSystemApplication(Context context) {
        if (context == null) return false;
        return isSystemApplication(context, context.getPackageName());
    }


    /**
     * whether packageName is system application
     *
     * @param context
     * @param packageName
     * @return
     */
    public static boolean isSystemApplication(Context context, String packageName) {
        if (context == null) return false;
        return isSystemApplication(context.getPackageManager(), packageName);
    }

    public static boolean isSystemApplication(PackageManager packageManager, String packageName) {
        if (packageManager == null || packageName == null || packageName.length() == 0) {
            return false;
        }

        try {
            ApplicationInfo app = packageManager.getApplicationInfo(packageName, 0);
            return (app != null && (app.flags & ApplicationInfo.FLAG_SYSTEM) > 0);
        } catch (PackageManager.NameNotFoundException e) {
            e.printStackTrace();
        }
        return false;
    }

 }