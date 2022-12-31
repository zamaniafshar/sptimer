
package com.example.pomotimer;

import android.app.ActivityManager;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.ServiceConnection;
import android.os.IBinder;
import androidx.annotation.NonNull;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity implements MethodChannel.MethodCallHandler {
    private final String ActivityChannel = "ActivityChannel";
    private PomotimerService pomotimerService;
    private PomotimerSateDatabase pomotimerSateDatabase;
    private boolean isBound = false;
    private final ServiceConnection serviceConnection = new ServiceConnection() {
        @Override
        public void onServiceConnected(ComponentName componentName, IBinder iBinder) {
            PomotimerService.PomotimerBinder binder = (PomotimerService.PomotimerBinder) iBinder;
            pomotimerService = binder.getService();
            isBound = true;
        }

        @Override
        public void onServiceDisconnected(ComponentName componentName) {
            pomotimerService=null;
            isBound = false;
        }
    };

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        MethodChannel channel = new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), ActivityChannel);
        channel.setMethodCallHandler(this);
        pomotimerSateDatabase = new PomotimerSateDatabase(this);
        if (isServiceRunning()) {
            Intent intent = new Intent(this, PomotimerService.class);
            bindService(intent, serviceConnection, Context.BIND_AUTO_CREATE);
        }
    }

    @Override
    public void onDestroy() {
        if (isBound) {
            unbindService(serviceConnection);
        }
        super.onDestroy();
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        switch (call.method) {
            case "startService":
                try {
                    Map<String, Object> arg = (HashMap<String, Object>) call.arguments;
                    Intent intent = new Intent(this, PomotimerService.class);
                    intent.putExtra(Constants.pomodoroTaskModelKey, (HashMap<String, Object>) arg.get(Constants.pomodoroTaskModelKey));
                    intent.putExtra(Constants.pomodoroTaskReportageModel,
                            (HashMap<String, Object>) arg.get(Constants.pomodoroTaskReportageModel));
                    startService(intent);
                    bindService(intent, serviceConnection, Context.BIND_AUTO_CREATE);
                    result.success(true);
                } catch (Exception e) {
                    result.success(false);
                }
                break;
            case "isServiceRunning":
                boolean serviceRunning = isServiceRunning();
                result.success(serviceRunning);
                break;
            case "saveState":
                try {
                    Map<String, Object> arg = (HashMap<String, Object>) call.arguments;
                    ExecutorService executor = Executors.newSingleThreadExecutor();
                   executor.execute(() -> {
                       pomotimerSateDatabase.saveState(arg);
                       result.success(true);
                   });
                } catch (Exception e) {
                    result.success(false);
                }
                break;

            case "getState":
                try {
                    ExecutorService executor = Executors.newSingleThreadExecutor();
                    executor.execute(() -> result.success(pomotimerSateDatabase.getState()));
                } catch (Exception e) {
                    result.success(null);
                }
                break;

            case "stopService":
                Map<String, Object> map = pomotimerService.toMapPomotimerSate();
                Intent intent = new Intent(this, PomotimerService.class);
                unbindService(serviceConnection);
                isBound = false;
                stopService(intent);
                result.success(map);

                break;

            default:
                result.notImplemented();

        }
    }


    private boolean isServiceRunning() {
        ActivityManager manager = (ActivityManager) this.getSystemService(Context.ACTIVITY_SERVICE);
        for (ActivityManager.RunningServiceInfo service : manager.getRunningServices(Integer.MAX_VALUE)) {
            if (PomotimerService.class.getName().equals(service.service.getClassName())) {
                return true;
            }
        }
        return false;
    }

}