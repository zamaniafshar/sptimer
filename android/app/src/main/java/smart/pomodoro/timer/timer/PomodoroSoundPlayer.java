package smart.pomodoro.timer.timer;

import android.content.Context;
import android.content.res.AssetFileDescriptor;
import android.content.res.AssetManager;
import android.media.AudioManager;
import android.media.MediaPlayer;
import android.os.Build;
import android.os.VibrationEffect;
import android.os.Vibrator;

import smart.pomodoro.timer.models.PomodoroTaskModel;

import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;
import io.flutter.FlutterInjector;
import io.flutter.embedding.engine.loader.FlutterLoader;

public class PomodoroSoundPlayer {
    public PomodoroSoundPlayer(Context context) {
        assetManager = context.getAssets();
        flutterLoader = FlutterInjector.instance().flutterLoader();
        flutterLoader.startInitialization(context);
        audioManager = (AudioManager) context.getSystemService(Context.AUDIO_SERVICE);
        vibrator = (Vibrator) context.getSystemService(Context.VIBRATOR_SERVICE);
    }

    private final String TonesPath = "assets/audio/tones/";
    private final String ReadStatusPath = "assets/audio/status_sounds/";
    private final FlutterLoader flutterLoader;
    private final AssetManager assetManager;
    private final AudioManager audioManager;
    private final Vibrator vibrator;


    public void playPomodoroSound(PomodoroTaskModel task) {
        if (task.vibrate) {
            vibrate();
        }
        playTone(task.toneName, task.toneVolume);
        ScheduledExecutorService executor= Executors.newSingleThreadScheduledExecutor();
        executor.schedule(()->readStatus(task),2, TimeUnit.SECONDS);
    }

    public void vibrate() {
        if(audioManager.getRingerMode() == AudioManager.RINGER_MODE_SILENT) return;
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            long[] pattern = {0, 500, 200, 500};
            vibrator.vibrate(VibrationEffect.createWaveform(pattern, -1));
        } else {
            vibrator.vibrate(500);
        }
    }

    public void setVolume(Double value) {
        if(audioManager.getRingerMode() != AudioManager.RINGER_MODE_NORMAL) return;
        double actualValue;
        if (value > 1) {
            actualValue = 1;
        } else {
            actualValue = Math.max(value, 0);
        }
        int maxVolume = audioManager.getStreamMaxVolume(AudioManager.STREAM_RING);
        int minVolume = 0;
        if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.P) {
            minVolume = audioManager.getStreamMinVolume(AudioManager.STREAM_RING);
        }
        double rawVol = (actualValue * (maxVolume - minVolume) + minVolume);
        int volume = (int) Math.round(rawVol);
        audioManager.setStreamVolume(AudioManager.STREAM_RING, volume, AudioManager.FLAG_REMOVE_SOUND_AND_VIBRATE);
    }

    public void playTone(String name, Double volume) {
        if(audioManager.getRingerMode() != AudioManager.RINGER_MODE_NORMAL) return;
        if (name.equals("none") || volume == 0.0) return;
        if (volume != null) setVolume(volume);
        play(TonesPath + name);
    }

    public void readStatus(PomodoroTaskModel taskModel) {
        if(audioManager.getRingerMode() != AudioManager.RINGER_MODE_NORMAL) return;
        if (!taskModel.readStatusAloud || taskModel.statusVolume == 0.0) return;
        setVolume(taskModel.statusVolume);
        if (taskModel.pomodoroStatus == PomodoroStatus.work) {
            play(ReadStatusPath + "its_time_to_work.mp3");
        } else if (taskModel.pomodoroStatus == PomodoroStatus.shortBreak) {
            play(ReadStatusPath + "take_short_break.mp3" );
        } else {
            play(ReadStatusPath + "take_long_break.mp3");
        }
    }

    private void play(String path) {
        try {
            String key = flutterLoader.getLookupKeyForAsset(path);
            AssetFileDescriptor afd = assetManager.openFd(key);
            MediaPlayer mediaPlayer= new MediaPlayer();
            mediaPlayer.setDataSource(afd.getFileDescriptor(), afd.getStartOffset(), afd.getLength());
            afd.close();
            mediaPlayer.setAudioStreamType(AudioManager.STREAM_RING);
            mediaPlayer.prepare();
            mediaPlayer.start();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
