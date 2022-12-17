import 'package:pomotimer/data/databases/tasks_reportage_database.dart';
import 'package:pomotimer/data/enums/task_status.dart';
import 'package:pomotimer/data/models/pomodoro_app_state_data.dart';
import 'package:pomotimer/data/models/pomodoro_task_model.dart';
import 'package:pomotimer/data/models/pomodoro_task_reportage_model.dart';
import 'package:pomotimer/data/services/pomodoro_sound_player/pomodoro_sound_player.dart';
import 'package:pomotimer/data/timers/pomodoro_timer.dart';

class PomodoroTaskTimer extends PomodoroTimer {
  PomodoroTaskTimer({
    PomodoroTaskReportageModel? taskReportageModel,
    required TasksReportageDatabase tasksReportageDatabase,
  })  : _tasksReportageDatabase = tasksReportageDatabase,
        _taskReportageModel = taskReportageModel;

  final PomodoroSoundPlayer _soundPlayer = PomodoroSoundPlayer();
  final TasksReportageDatabase _tasksReportageDatabase;
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
  }) async {
    _initState = initState;
    _soundPlayer.init();
    super.init(
      initState: initState,
      intervalTime: intervalTime,
      onRoundFinish: () async {
        _soundPlayer.playPomodoroSound(pomodoroTask);
        await onRoundFinish?.call();
      },
      onFinish: () async {
        await saveTaskReport();
        _soundPlayer.playTone(_initState.tone);
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
      taskStatus: TaskStatus.remain,
    );
  }

  Future<void> saveTaskReport() async {
    final now = DateTime.now();
    if (_taskReportageModel!.startDate.difference(now) > const Duration(minutes: 5)) {
      _taskReportageModel = _taskReportageModel!.copyWith(
        endDate: now,
        taskStatus: super.pomodoroStatus.isLongBreakTime ? TaskStatus.done : TaskStatus.remain,
      );
      await _tasksReportageDatabase.add(_taskReportageModel!);
    }
    _taskReportageModel = null;
  }
}
