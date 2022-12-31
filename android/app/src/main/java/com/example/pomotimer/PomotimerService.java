
package com.example.pomotimer;

import android.app.Notification;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.app.Service;
import android.content.Context;
import android.content.Intent;
import android.graphics.Color;
import android.os.Binder;
import android.os.Build;
import android.os.IBinder;
import android.os.PowerManager;
import androidx.annotation.RequiresApi;
import androidx.core.app.NotificationCompat;
import com.example.pomotimer.models.PomodoroTaskModel;
import com.example.pomotimer.models.PomodoroTaskReportageModel;
import com.example.pomotimer.timer.PomodoroStatus;
import com.example.pomotimer.timer.Pomotimer;
import java.util.HashMap;
import java.util.Map;



public class PomotimerService extends Service {
    public class PomotimerBinder extends Binder {
        public PomotimerService getService() {
            return PomotimerService.this;
        }
    }

    private final PomotimerBinder pomotimerBinder = new PomotimerBinder();
    private final int notificationId = 1;
    private final String channelId = "pomotimer_service_id";
    private final String channelName = "pomotimer_service";
    private String taskTitle;
    private NotificationCompat.Builder builder;
    private Pomotimer pomotimer;
    private PowerManager.WakeLock wakeLock;


    @Override
    public void onCreate() {
        super.onCreate();
        PowerManager powerManager = (PowerManager) getSystemService(POWER_SERVICE);
        wakeLock = powerManager.newWakeLock(PowerManager.PARTIAL_WAKE_LOCK, "pomotimer::MyWakelockTag");
        wakeLock.acquire();
    }

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        PomodoroTaskModel pomodoroTaskModel =
                PomodoroTaskModel.fromMap((HashMap<String, Object>) intent.getSerializableExtra(Constants.pomodoroTaskModelKey));
        PomodoroTaskReportageModel taskReportageModel =
                PomodoroTaskReportageModel.fromMap((HashMap<String, Object>) intent.getSerializableExtra(Constants.pomodoroTaskReportageModel));
        taskTitle = pomodoroTaskModel.title;
        pomotimer = new Pomotimer(
                pomodoroTaskModel,
                taskReportageModel,
                this::updateNotification,
                this::onTaskFinish,
                this
        );
        startForeground();

        pomotimer.start();
        return START_NOT_STICKY;
    }

    @Override
    public void onDestroy() {
        wakeLock.release();
        pomotimer.cancel();
        super.onDestroy();

    }

    @Override
    public IBinder onBind(Intent intent) {
        return pomotimerBinder;

    }


    public Map<String, Object> toMapPomotimerSate() {
        Map<String, Object> map = new HashMap<>();
        map.put(Constants.pomodoroTaskModelKey, pomotimer.pomodoroTaskModel().toMap());
        map.put(Constants.pomodoroTaskReportageModel, pomotimer.taskReportageModel.toMap());
        return map;
    }

    private void onTaskFinish() {
        stopForeground(true);
        showCompletedTaskNotification();
        stopSelf();
    }

    @RequiresApi(Build.VERSION_CODES.O)
    private void createNotificationChannel() {
        NotificationChannel channel = new NotificationChannel(channelId,
                channelName, NotificationManager.IMPORTANCE_NONE);
        channel.setLightColor(Color.BLUE);
        channel.setLockscreenVisibility(Notification.VISIBILITY_PUBLIC);
        NotificationManager manager = (NotificationManager) getSystemService(Context.NOTIFICATION_SERVICE);
        manager.createNotificationChannel(channel);

    }

    private void startForeground() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            createNotificationChannel();
        }
        Intent intent = new Intent(this,MainActivity.class);
        PendingIntent pendingIntent = null;
        if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.M) {
            pendingIntent = PendingIntent.getActivity(this,2000,intent,
                    PendingIntent.FLAG_UPDATE_CURRENT | PendingIntent.FLAG_IMMUTABLE );
        }
        builder = new NotificationCompat.Builder(this, channelId);
        builder.setContentIntent(pendingIntent)
                .setOngoing(true)
                .setOnlyAlertOnce(true)
                .setSmallIcon(R.drawable.notif_pomotimer)
                .setContentTitle(taskTitle)
                .setContentText(getNotificationContent())
                .setCategory(Notification.CATEGORY_SERVICE);

        startForeground(1, builder.build());
    }

    private void updateNotification() {
        builder.setContentText(getNotificationContent());
        NotificationManager manager = (NotificationManager) getSystemService(Context.NOTIFICATION_SERVICE);
        manager.notify(notificationId, builder.build());
    }

    private void showCompletedTaskNotification() {
        NotificationCompat.Builder builder = new NotificationCompat.Builder(this, channelId);
        builder
                .setOnlyAlertOnce(true)
                .setSmallIcon(R.drawable.notif_pomotimer)
                .setContentTitle(taskTitle)
                .setContentText("Completed")
                .setCategory(Notification.CATEGORY_SERVICE);
        NotificationManager manager = (NotificationManager) getSystemService(Context.NOTIFICATION_SERVICE);
        manager.notify(2, builder.build());

    }

    private String getNotificationContent() {
        String seconds = String.valueOf(pomotimer.remainingDuration % 60);
        String minutes = String.valueOf(pomotimer.remainingDuration / 60);
        if (seconds.length() < 2) seconds = "0" + seconds;
        if (minutes.length() < 2) minutes = "0" + minutes;
        return minutes + ":" + seconds;
    }

}
