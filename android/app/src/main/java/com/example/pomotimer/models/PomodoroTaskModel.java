package com.example.pomotimer.models;

import com.example.pomotimer.Constants;
import com.example.pomotimer.timer.PomodoroStatus;
import com.example.pomotimer.timer.TimerStatus;

import java.util.HashMap;
import java.util.Map;

public class PomodoroTaskModel {
    public PomodoroTaskModel(
            int remainingDuration,
            int id,
            String title,
            int workDuration,
            int shortBreakDuration,
            int longBreakDuration,
            int maxPomodoroRound,
            int pomodoroRound,
            PomodoroStatus pomodoroStatus,
            TimerStatus timerStatus,
            boolean vibrate,
            String toneName,
            double toneVolume,
            double statusVolume,
            boolean readStatusAloud
    ) {
        this.remainingDuration = remainingDuration;
        this.id = id;
        this.title = title;
        this.workDuration = workDuration;
        this.shortBreakDuration = shortBreakDuration;
        this.longBreakDuration = longBreakDuration;
        this.maxPomodoroRound = maxPomodoroRound;
        this.pomodoroRound = pomodoroRound;
        this.pomodoroStatus = pomodoroStatus;
        this.timerStatus = timerStatus;
        this.vibrate = vibrate;
        this.toneName = toneName;
        this.toneVolume = toneVolume;
        this.statusVolume = statusVolume;
        this.readStatusAloud = readStatusAloud;
    }

    public int remainingDuration;
    public int id;
    public String title;
    public int workDuration;
    public int shortBreakDuration;
    public int longBreakDuration;
    public int maxPomodoroRound;
    public int pomodoroRound;
    public PomodoroStatus pomodoroStatus;
    public TimerStatus timerStatus;
    public boolean vibrate;
    public String toneName;
    public double toneVolume;
    public double statusVolume;
    public boolean readStatusAloud;


    public Map<String, Object> toMap() {
        Map<String, Object> map = new HashMap<>();
        map.put(Constants.kRemainingDuration, remainingDuration);
        map.put(Constants.kWorkDuration, workDuration);
        map.put(Constants.kShortBreakDuration, shortBreakDuration);
        map.put(Constants.kLongBreakDuration, longBreakDuration);
        map.put(Constants.kPomodoroRound, pomodoroRound);
        map.put(Constants.kMaxRound, maxPomodoroRound);
        map.put(Constants.kPomodoroStatus, pomodoroStatus.ordinal());
        map.put(Constants.kTimerStatus, timerStatus.ordinal());
        map.put(Constants.kTitle, title);
        map.put(Constants.kTaskId, id);
        map.put(Constants.kVibrate, vibrate);
        map.put(Constants.kTone, toneName);
        map.put(Constants.kToneVolume, toneVolume);
        map.put(Constants.kStatusVolume, statusVolume);
        map.put(Constants.kReadStatusAloud, readStatusAloud);
        return map;
    }


    public static PomodoroTaskModel fromMap(Map<String, Object> data) {
        return new PomodoroTaskModel(
                (int) data.get(Constants.kRemainingDuration),
                (int) data.get(Constants.kTaskId),
                (String) data.get(Constants.kTitle),
                (int) data.get(Constants.kWorkDuration),
                (int) data.get(Constants.kShortBreakDuration),
                (int) data.get(Constants.kLongBreakDuration),
                (int) data.get(Constants.kMaxRound),
                (int) data.get(Constants.kPomodoroRound),
                PomodoroStatus.values()[(int) data.get(Constants.kPomodoroStatus)],
                TimerStatus.values()[(int) data.get(Constants.kTimerStatus)],
                (Boolean) data.get(Constants.kVibrate),
                (String) data.get(Constants.kTone),
                (Double) data.get(Constants.kToneVolume),
                (Double) data.get(Constants.kStatusVolume),
                (Boolean) data.get(Constants.kReadStatusAloud)
        );
    }


}
