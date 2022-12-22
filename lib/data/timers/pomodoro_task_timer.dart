import 'package:pomotimer/data/databases/tasks_reportage_database.dart';
import 'package:pomotimer/data/enums/task_status.dart';
import 'package:pomotimer/data/models/pomodoro_app_state_data.dart';
import 'package:pomotimer/data/models/pomodoro_task_model.dart';
import 'package:pomotimer/data/models/pomodoro_task_reportage_model.dart';
import 'package:pomotimer/data/services/pomodoro_sound_player/pomodoro_sound_player.dart';
import 'package:pomotimer/data/timers/pomodoro_timer.dart';

class PomodoroTaskTimer extends PomodoroTimer {
  PomodoroTaskTimer({
    TasksReportageDatabase? tasksReportageDatabase,
  }) : _tasksReportageDatabase = tasksReportageDatabase;

  final PomodoroSoundPlayer _soundPlayer = PomodoroSoundPlayer();
  final TasksReportageDatabase? _tasksReportageDatabase;
  PomodoroTaskReportageModel? _taskReportageModel;

  late PomodoroTaskModel _initState;

  PomodoroTaskModel get pomodoroTask => _initState.copyWith(
        pomodoroRound: super.pomodoroRound,
        currentMaxDuration: super.currentMaxDuration,
        remainingDuration: super.remainingDuration,
        pomodoroStatus: super.pomodoroStatus,
        timerStatus: super.timerStatus,
      );
  PomodoroAppSateData get pomodoroAppSateData => PomodoroAppSateData(
        pomodoroTaskModel: pomodoroTask,
        pomodoroTaskReportageModel: _taskReportageModel,
      );
  PomodoroTaskReportageModel? get taskReportage => _taskReportageModel;
  Future<bool> get isSoundPlayerMuted => _soundPlayer.isSoundPlayerMuted(pomodoroTask);

  @override
  Future<void> init({
    required PomodoroTaskModel initState,
    Duration intervalTime = const Duration(seconds: 1),
    Future<void> Function()? onRoundFinish,
    Future<void> Function()? onFinish,
    bool isForegroundService = false,
    PomodoroTaskReportageModel? taskReportageModel,
  }) async {
    _initState = initState;
    _taskReportageModel = taskReportageModel;
    _soundPlayer.init();
    super.init(
      initState: initState,
      intervalTime: intervalTime,
      onRoundFinish: () async {
        _soundPlayer.playPomodoroSound(pomodoroTask);
        await onRoundFinish?.call();
      },
      onFinish: () async {
        isForegroundService
            ? await _soundPlayer.playTone(_initState.tone)
            : _soundPlayer.playTone(_initState.tone);
        await onFinish?.call();
      },
    );
  }

  void dispose() {
    _soundPlayer.dispose();
  }

  @override
  void start() {
    super.start();
    if (_taskReportageModel != null) return;
    _taskReportageModel = PomodoroTaskReportageModel(
      pomodoroTaskId: _initState.id!,
      taskName: _initState.title,
      startDate: DateTime.now(),
      taskStatus: TaskStatus.uncompleted,
    );
  }

  Future<void> saveTaskReport({bool isCompleted = false}) async {
    if (_taskReportageModel == null) return;
    final now = DateTime.now();
    if (now.difference(_taskReportageModel!.startDate) > const Duration(minutes: 5)) {
      _taskReportageModel = _taskReportageModel!.copyWith(
        endDate: now,
        taskStatus: isCompleted ? TaskStatus.completed : TaskStatus.uncompleted,
      );
      await _tasksReportageDatabase!.add(_taskReportageModel!);
    }
    _taskReportageModel = null;
  }
}
