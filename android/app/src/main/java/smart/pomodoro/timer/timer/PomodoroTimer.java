package smart.pomodoro.timer.timer;

import android.content.Context;

import smart.pomodoro.timer.Constants;
import smart.pomodoro.timer.PomodoroSateDatabase;
import smart.pomodoro.timer.models.PomodoroTaskModel;
import smart.pomodoro.timer.models.PomodoroTaskReportageModel;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

public class PomodoroTimer {
    public PomodoroTimer(
            PomodoroTaskModel initState,
            PomodoroTaskReportageModel taskReportageModel,
            Runnable listener,
            Runnable onFinish,
            Context context
    ) {
        this.pomodoroRound = initState.pomodoroRound;
        this.maxPomodoroRound = initState.maxPomodoroRound;
        this.longBreakDuration = initState.longBreakDuration;
        this.shortBreakDuration = initState.shortBreakDuration;
        this.workDuration = initState.workDuration;
        this.pomodoroStatus = initState.pomodoroStatus;
        this.timerStatus = initState.timerStatus;
        this.initState = initState;
        this.taskReportageModel = taskReportageModel;
        this.remainingDuration = initState.remainingDuration;
        this.listener = listener;
        this.onFinish = onFinish;
        this.stateDatabase = new PomodoroSateDatabase(context);
        this.pomodoroSoundPlayer = new PomodoroSoundPlayer(context);

    }

    private final PomodoroTaskModel initState;
    private final PomodoroSateDatabase stateDatabase;
    private final PomodoroSoundPlayer pomodoroSoundPlayer;
    private ScheduledExecutorService executor;
    private final Runnable listener;
    private final Runnable onFinish;
    public PomodoroTaskReportageModel taskReportageModel;
    public int pomodoroRound;
    public int maxPomodoroRound;
    public int longBreakDuration;
    public int shortBreakDuration;
    public int remainingDuration;
    public int workDuration;
    public PomodoroStatus pomodoroStatus;
    public TimerStatus timerStatus;


    public PomodoroTaskModel pomodoroTaskModel() {
        return new PomodoroTaskModel(
                remainingDuration,
                initState.id,
                initState.title,
                workDuration,
                shortBreakDuration,
                longBreakDuration,
                maxPomodoroRound,
                pomodoroRound,
                pomodoroStatus,
                timerStatus,
                initState.vibrate,
                initState.toneName,
                initState.toneVolume,
                initState.statusVolume,
                initState.readStatusAloud
        );
    }


    public void start() {
        timerStatus = TimerStatus.start;
        executor = Executors.newSingleThreadScheduledExecutor();
        Runnable runnable = this::everySecond;
        executor.scheduleAtFixedRate(runnable, 1, 1, TimeUnit.SECONDS);

    }

    public void cancel() {
        executor.shutdown();
        timerStatus = TimerStatus.cancel;
        pomodoroStatus = PomodoroStatus.work;
        remainingDuration = calculateMaxDuration(pomodoroStatus);
        pomodoroRound = 0;
    }

    private void everySecond() {
        remainingDuration--;
        listener.run();
        if (remainingDuration <= 0) {
            executor.shutdown();
            onRoundFinish();
        }
    }

    private int calculateMaxDuration(PomodoroStatus status) {
        if (status == PomodoroStatus.work) {
            return workDuration;
        } else if (status == PomodoroStatus.shortBreak) {
            return shortBreakDuration;
        } else {
            return longBreakDuration;
        }
    }

    private void onTaskFinish() {
        cancel();
        pomodoroSoundPlayer.playTone(initState.toneName, initState.toneVolume);
        saveTask();
        onFinish.run();
    }

    private void saveTask() {
        Map<String, Object> map = new HashMap<>();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd kk:mm:ss");
        Date now = new Date();
        taskReportageModel.endDate = dateFormat.format(now);
        taskReportageModel.taskStatus = 1;
        map.put(Constants.pomodoroTaskModelKey, pomodoroTaskModel().toMap());
        map.put(Constants.pomodoroTaskReportageModel, taskReportageModel.toMap());
        stateDatabase.saveState(map);
    }

    private void onRoundFinish() {
        if (pomodoroStatus == PomodoroStatus.longBreak) {
            onTaskFinish();
            return;

        } else if (pomodoroRound == maxPomodoroRound - 1 && pomodoroStatus == PomodoroStatus.work) {
            if (longBreakDuration == 0) {
                onTaskFinish();
                return;
            }
            pomodoroRound = maxPomodoroRound;
            pomodoroStatus = PomodoroStatus.longBreak;
        } else if (pomodoroStatus == PomodoroStatus.shortBreak) {
            pomodoroRound++;
            pomodoroStatus = PomodoroStatus.work;
        } else if (pomodoroStatus == PomodoroStatus.work) {
            pomodoroStatus = PomodoroStatus.shortBreak;
        }
        pomodoroSoundPlayer.playPomodoroSound(pomodoroTaskModel());
        remainingDuration = calculateMaxDuration(pomodoroStatus);
        listener.run();
        start();
    }
}
