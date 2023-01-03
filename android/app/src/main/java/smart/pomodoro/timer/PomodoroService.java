
package smart.pomodoro.timer;

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
import smart.pomodoro.timer.models.PomodoroTaskModel;
import smart.pomodoro.timer.models.PomodoroTaskReportageModel;
import smart.pomodoro.timer.timer.PomodoroTimer;
import java.util.HashMap;
import java.util.Map;



public class PomodoroService extends Service {
    public class PomodoroBinder extends Binder {
        public PomodoroService getService() {
            return PomodoroService.this;
        }
    }

    private final PomodoroBinder pomodoroBinder = new PomodoroBinder();
    private final int notificationId = 1;
    private final String channelId = "pomodoro_service_id";
    private final String channelName = "pomodoro_service";
    private String taskTitle;
    private NotificationCompat.Builder builder;
    private PomodoroTimer pomodoroTimer;
    private PowerManager.WakeLock wakeLock;


    @Override
    public void onCreate() {
        super.onCreate();
        PowerManager powerManager = (PowerManager) getSystemService(POWER_SERVICE);
        wakeLock = powerManager.newWakeLock(PowerManager.PARTIAL_WAKE_LOCK, "sptimer::MyWakelockTag");
        wakeLock.acquire();
    }

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        PomodoroTaskModel pomodoroTaskModel =
                PomodoroTaskModel.fromMap((HashMap<String, Object>) intent.getSerializableExtra(Constants.pomodoroTaskModelKey));
        PomodoroTaskReportageModel taskReportageModel =
                PomodoroTaskReportageModel.fromMap((HashMap<String, Object>) intent.getSerializableExtra(Constants.pomodoroTaskReportageModel));
        taskTitle = pomodoroTaskModel.title;
        pomodoroTimer = new PomodoroTimer(
                pomodoroTaskModel,
                taskReportageModel,
                this::updateNotification,
                this::onTaskFinish,
                this
        );
        startForeground();

        pomodoroTimer.start();
        return START_NOT_STICKY;
    }

    @Override
    public void onDestroy() {
        wakeLock.release();
        pomodoroTimer.cancel();
        super.onDestroy();

    }

    @Override
    public IBinder onBind(Intent intent) {
        return pomodoroBinder;

    }


    public Map<String, Object> toMapPomodoroState() {
        Map<String, Object> map = new HashMap<>();
        map.put(Constants.pomodoroTaskModelKey, pomodoroTimer.pomodoroTaskModel().toMap());
        map.put(Constants.pomodoroTaskReportageModel, pomodoroTimer.taskReportageModel.toMap());
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
                .setSmallIcon(R.drawable.notif_sptimer)
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
                .setSmallIcon(R.drawable.notif_sptimer)
                .setContentTitle(taskTitle)
                .setContentText("Completed")
                .setCategory(Notification.CATEGORY_SERVICE);
        NotificationManager manager = (NotificationManager) getSystemService(Context.NOTIFICATION_SERVICE);
        manager.notify(2, builder.build());

    }

    private String getNotificationContent() {
        String seconds = String.valueOf(pomodoroTimer.remainingDuration % 60);
        String minutes = String.valueOf(pomodoroTimer.remainingDuration / 60);
        if (seconds.length() < 2) seconds = "0" + seconds;
        if (minutes.length() < 2) minutes = "0" + minutes;
        return minutes + ":" + seconds;
    }

}
