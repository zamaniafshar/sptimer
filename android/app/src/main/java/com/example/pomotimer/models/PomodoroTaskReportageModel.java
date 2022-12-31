package com.example.pomotimer.models;

import com.example.pomotimer.Constants;
import java.util.HashMap;
import java.util.Map;



public class PomodoroTaskReportageModel {
    public PomodoroTaskReportageModel(
            Integer id,
            String startDate,
            String endDate,
            int taskStatus,
            int pomodoroTaskId,
            String taskName

    ) {
        this.id = id;
        this.startDate = startDate;
        this.endDate = endDate;
        this.taskStatus = taskStatus;
        this.pomodoroTaskId = pomodoroTaskId;
        this.taskName = taskName;
    }

    public Integer id;
    public String startDate;
    public String endDate;
    public int taskStatus;
    public int pomodoroTaskId;
    public String taskName;


    public Map<String, Object> toMap() {
        Map<String, Object> map = new HashMap<>();
        map.put(Constants.kTaskReportageId, id);
        map.put(Constants.kPomodoroTaskId, pomodoroTaskId);
        map.put(Constants.kStartDate, startDate);
        map.put(Constants.kEndDate, endDate);
        map.put(Constants.kTaskName, taskName);
        map.put(Constants.kStatus, taskStatus);
        return map;
    }

    public static PomodoroTaskReportageModel fromMap(Map<String, Object> data) {
        return new PomodoroTaskReportageModel(
                (Integer) data.get(Constants.kTaskReportageId),
                (String) data.get(Constants.kStartDate),
                null,
                (int) data.get(Constants.kStatus),
                (int) data.get(Constants.kPomodoroTaskId),
                (String) data.get(Constants.kTaskName)
        );
    }
}
