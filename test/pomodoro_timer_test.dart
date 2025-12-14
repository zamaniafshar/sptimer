import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce/hive.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sptimer/common/database/database.dart';
import 'package:sptimer/data/enums/pomodoro_status.dart';
import 'package:sptimer/data/enums/timer_status.dart';
import 'package:sptimer/data/enums/tones.dart';
import 'package:sptimer/data/models/pomodoro_timer_state.dart';
import 'package:sptimer/data/models/task.dart';
import 'package:sptimer/data/repositories/tasks_reportage_repository.dart';
import 'package:sptimer/data/services/pomodoro_sound_player.dart';
import 'package:sptimer/data/services/pomodoro_timer.dart';

import 'pomodoro_timer_test.mocks.dart';

// NOTE: anything matcher in emitsInOrder used for elapsed time events

Task _createTask({
  String? id,
  String? title,
  required Duration workDuration,
  required Duration shortBreakDuration,
  required Duration longBreakDuration,
  required int maxPomodoroRound,
}) {
  return Task(
    id: id ?? '1',
    title: title ?? 'title',
    workDuration: workDuration,
    shortBreakDuration: shortBreakDuration,
    longBreakDuration: longBreakDuration,
    maxPomodoroRound: maxPomodoroRound,
    vibrate: true,
    tone: Tones.alert,
    toneVolume: 0.5,
    statusVolume: 0.5,
    readStatusAloud: true,
  );
}

@GenerateNiceMocks([MockSpec<PomodoroSoundPlayer>()])
Future<void> main() async {
  final tempDir = Directory.systemTemp.createTempSync('local_database_test');
  Hive.init(tempDir.path);
  final db = AdvancedDatabase(await Hive.openLazyBox('test_tasks'));
  late PomodoroTimer pomodoroTimer;
  late PomodoroSoundPlayer pomodoroSoundPlayer;
  late TasksReportageRepository tasksReportageRepository;

  setUp(() {
    pomodoroSoundPlayer = MockPomodoroSoundPlayer();
    tasksReportageRepository = TasksReportageRepository(db);
    final task = _createTask(
      workDuration: Duration(seconds: 25),
      shortBreakDuration: Duration(seconds: 5),
      longBreakDuration: Duration(seconds: 15),
      maxPomodoroRound: 3,
    );

    pomodoroTimer = PomodoroTimer(
      timerTickDuration: Duration(milliseconds: 100),
      task: task,
      soundPlayer: pomodoroSoundPlayer,
      tasksReportageDatabase: tasksReportageRepository,
    );
  });

  tearDown(() {
    pomodoroTimer.dispose();
  });

  test('Starting timer initializes state correctly', () {
    expectLater(
      pomodoroTimer.streamState,
      emits(
        predicate<PomodoroTimerState>(
          (state) =>
              state.timerStatus == TimerStatus.started &&
              state.pomodoroStatus == PomodoroStatus.work &&
              state.pomodoroRound == 1 &&
              state.elapsedTime == Duration.zero,
        ),
      ),
    );
    pomodoroTimer.start();
  });

  test('Cannot start timer if already running', () {
    pomodoroTimer.start();
    final initialState = pomodoroTimer.state;

    // Try to start again - should be ignored
    pomodoroTimer.start();
    expect(pomodoroTimer.state, equals(initialState));
  });

  test('Pause stops the timer', () async {
    expectLater(
      pomodoroTimer.streamState,
      emitsInOrder([
        predicate<PomodoroTimerState>(
          (state) => state.timerStatus == TimerStatus.started,
        ),
        predicate<PomodoroTimerState>(
          (state) => state.timerStatus == TimerStatus.paused,
        ),
      ]),
    );

    pomodoroTimer.start();
    await Future.delayed(Duration(milliseconds: 20));

    pomodoroTimer.pause();
  });

  test('Cannot pause if timer is not running', () {
    final initialState = pomodoroTimer.state;
    pomodoroTimer.pause();
    expect(pomodoroTimer.state, equals(initialState));
  });

  test('Resume continues the timer from paused state', () async {
    pomodoroTimer.start();
    await Future.delayed(Duration(milliseconds: 100));
    pomodoroTimer.pause();
    await Future.delayed(Duration(milliseconds: 50));

    expectLater(
      pomodoroTimer.streamState,
      emits(
        predicate<PomodoroTimerState>(
          (state) => state.timerStatus == TimerStatus.started,
        ),
      ),
    );
    pomodoroTimer.resume();
  });

  test('Cannot resume if timer is not paused', () {
    final initialState = pomodoroTimer.state;
    pomodoroTimer.resume();
    expect(pomodoroTimer.state, equals(initialState));
  });

  test('Finish resets timer to initial state', () {
    expectLater(
      pomodoroTimer.streamState,
      emitsInOrder([
        predicate<PomodoroTimerState>(
          (state) => state.timerStatus == TimerStatus.started,
        ),
        predicate<PomodoroTimerState>(
          (state) =>
              state.timerStatus == TimerStatus.finished &&
              state.pomodoroRound == 1 &&
              state.elapsedTime == Duration.zero,
        ),
      ]),
    );

    pomodoroTimer.start();
    pomodoroTimer.finish();
  });

  test('Cannot finish if timer is already finished', () {
    final initialState = pomodoroTimer.state;
    pomodoroTimer.finish();
    expect(pomodoroTimer.state, equals(initialState));
  });

  test('Restart resets elapsed time and round to 1', () async {
    final timer = PomodoroTimer(
      timerTickDuration: Duration(milliseconds: 50),
      task: _createTask(
        workDuration: Duration(milliseconds: 200),
        shortBreakDuration: Duration(milliseconds: 100),
        longBreakDuration: Duration(milliseconds: 150),
        maxPomodoroRound: 3,
      ),
      soundPlayer: pomodoroSoundPlayer,
      tasksReportageDatabase: tasksReportageRepository,
    );

    timer.start();

    await expectLater(
      timer.streamState,
      emitsThrough(
        predicate<PomodoroTimerState>(
          (s) =>
              s.timerStatus == TimerStatus.started &&
              s.pomodoroRound > 1 &&
              s.elapsedTime > Duration.zero,
        ),
      ),
    );

    expectLater(
      timer.streamState,
      emitsInOrder([
        predicate<PomodoroTimerState>(
          (state) =>
              state.timerStatus == TimerStatus.started &&
              state.pomodoroRound == 1 &&
              state.elapsedTime == Duration.zero,
        ),
        anything,
        anything,
        predicate<PomodoroTimerState>(
          (state) => state.elapsedTime > Duration.zero,
        ),
      ]),
    );
    timer.restart();
  });

  test('Restart resets elapsed time and round to 1 when timer paused', () async {
    final timer = PomodoroTimer(
      timerTickDuration: Duration(milliseconds: 50),
      task: _createTask(
        workDuration: Duration(milliseconds: 200),
        shortBreakDuration: Duration(milliseconds: 100),
        longBreakDuration: Duration(milliseconds: 150),
        maxPomodoroRound: 3,
      ),
      soundPlayer: pomodoroSoundPlayer,
      tasksReportageDatabase: tasksReportageRepository,
    );

    timer.start();

    Future.delayed(Duration(milliseconds: 300), () => timer.pause());

    await expectLater(
      timer.streamState,
      emitsThrough(
        predicate<PomodoroTimerState>(
          (s) =>
              s.timerStatus == TimerStatus.paused &&
              s.pomodoroRound > 1 &&
              s.elapsedTime > Duration.zero,
        ),
      ),
    );

    expectLater(
      timer.streamState,
      emitsInOrder([
        predicate<PomodoroTimerState>(
          (state) =>
              state.timerStatus == TimerStatus.started &&
              state.pomodoroRound == 1 &&
              state.elapsedTime == Duration.zero,
        ),
        anything,
        anything,
        predicate<PomodoroTimerState>(
          (state) => state.elapsedTime > Duration.zero,
        ),
      ]),
    );
    timer.restart();
  });

  test('Cannot restart if timer is already finished', () {
    final initialState = pomodoroTimer.state;
    pomodoroTimer.restart();
    expect(pomodoroTimer.state, equals(initialState));
  });

  test('Elapsed time updates on each tick', () async {
    pomodoroTimer.start();

    expectLater(
      pomodoroTimer.streamState,
      emitsInOrder([
        predicate<PomodoroTimerState>(
          (state) => state.timerStatus == TimerStatus.started,
        ),
        predicate<PomodoroTimerState>(
          (state) => state.elapsedTime > Duration.zero,
        ),
      ]),
    );
  });

  test('Remaining duration decreases as elapsed time increases', () async {
    pomodoroTimer.start();
    await Future.delayed(Duration(milliseconds: 300));

    final state = pomodoroTimer.state;
    final remainingDuration = state.remainingDuration;
    final expectedRemaining = state.currentMaxDuration - state.elapsedTime;

    expect(remainingDuration, equals(expectedRemaining));
    expect(remainingDuration, lessThan(state.currentMaxDuration));
  });

  test('Disposes resources properly', () async {
    pomodoroTimer.start();
    await pomodoroTimer.dispose();

    expect(
      () => pomodoroTimer.streamState.listen((_) {}),
      returnsNormally,
    );
  });

  test('Sound player is initialized on timer creation', () {
    verify(pomodoroSoundPlayer.init()).called(1);
  });

  test('Transitions from work to short break after work duration', () async {
    final shortTask = _createTask(
      workDuration: Duration(milliseconds: 100),
      shortBreakDuration: Duration(seconds: 5),
      longBreakDuration: Duration(seconds: 15),
      maxPomodoroRound: 2,
    );

    final timer = PomodoroTimer(
      timerTickDuration: Duration(milliseconds: 120),
      task: shortTask,
      soundPlayer: pomodoroSoundPlayer,
      tasksReportageDatabase: tasksReportageRepository,
    );

    expectLater(
      timer.streamState,
      emitsInOrder([
        predicate<PomodoroTimerState>(
          (state) =>
              state.timerStatus == TimerStatus.started &&
              state.pomodoroStatus == PomodoroStatus.work,
        ),
        anything,
        predicate<PomodoroTimerState>(
          (state) => state.pomodoroStatus == PomodoroStatus.shortBreak,
        ),
      ]),
    );

    timer.start();
  });

  test('Transitions from short break to work with incremented round', () async {
    final shortTask = _createTask(
      workDuration: Duration(milliseconds: 100),
      shortBreakDuration: Duration(milliseconds: 100),
      longBreakDuration: Duration(milliseconds: 15),
      maxPomodoroRound: 3,
    );

    final timer = PomodoroTimer(
      timerTickDuration: Duration(milliseconds: 100),
      task: shortTask,
      soundPlayer: pomodoroSoundPlayer,
      tasksReportageDatabase: tasksReportageRepository,
    );

    expectLater(
      timer.streamState,
      emitsInOrder([
        predicate<PomodoroTimerState>(
          (state) =>
              state.timerStatus == TimerStatus.started &&
              state.pomodoroStatus == PomodoroStatus.work &&
              state.pomodoroRound == 1,
        ),
        anything,
        predicate<PomodoroTimerState>(
          (state) => state.pomodoroStatus == PomodoroStatus.shortBreak,
        ),
        anything,
        predicate<PomodoroTimerState>(
          (state) => state.pomodoroStatus == PomodoroStatus.longBreak && state.pomodoroRound == 2,
        ),
      ]),
    );
    timer.start();
  });

  test('Completes task after final long break', () async {
    final shortTask = _createTask(
      workDuration: Duration(milliseconds: 50),
      shortBreakDuration: Duration(milliseconds: 50),
      longBreakDuration: Duration(milliseconds: 50),
      maxPomodoroRound: 1,
    );

    final timer = PomodoroTimer(
      task: shortTask,
      soundPlayer: pomodoroSoundPlayer,
      tasksReportageDatabase: tasksReportageRepository,
    );
    final initState = timer.state;

    expectLater(
      timer.streamState,
      emitsInOrder([
        predicate<PomodoroTimerState>(
          (state) => state.timerStatus == TimerStatus.started,
        ),
        anything,
        predicate<PomodoroTimerState>(
          (state) => state.pomodoroStatus == PomodoroStatus.longBreak,
        ),
        anything,
        initState,
      ]),
    );

    timer.start();
  });

  test('Skips long break when duration is zero', () async {
    final shortTask = _createTask(
      workDuration: Duration(milliseconds: 50),
      shortBreakDuration: Duration(milliseconds: 50),
      longBreakDuration: Duration.zero,
      maxPomodoroRound: 1,
    );

    final timer = PomodoroTimer(
      task: shortTask,
      soundPlayer: pomodoroSoundPlayer,
      tasksReportageDatabase: tasksReportageRepository,
    );

    expectLater(
      timer.streamState.map((s) => s.timerStatus),
      emitsInOrder([
        TimerStatus.started,
        // this emit is for updating elapsed time
        TimerStatus.started,
        TimerStatus.finished,
      ]),
    );

    timer.start();
  });

  // group('Task Reportage', () {
  //   test('Saves completed task reportage when task finishes', () async {
  //     final shortTask = Task(
  //       id: '7',
  //       title: 'completed task',
  //       workDuration: Duration(milliseconds: 50),
  //       shortBreakDuration: Duration(milliseconds: 50),
  //       longBreakDuration: Duration(milliseconds: 50),
  //       maxPomodoroRound: 1,
  //       vibrate: true,
  //       tone: Tones.alert,
  //       toneVolume: 0.5,
  //       statusVolume: 0.5,
  //       readStatusAloud: true,
  //     );

  //     final timer = PomodoroTimer(
  //       timerTickDuration: Duration(milliseconds: 5),
  //       task: shortTask,
  //       soundPlayer: pomodoroSoundPlayer,
  //       tasksReportageDatabase: tasksReportageRepository,
  //     );

  //     timer.start();
  //     await Future.delayed(Duration(milliseconds: 150));

  //     final reportages = await tasksReportageRepository.getTodayReportages();
  //     expect(reportages, isNotEmpty);

  //     final completedReportage = reportages.firstWhere(
  //       (r) => r.taskId == shortTask.id,
  //     );

  //     expect(completedReportage.taskStatus, equals(TaskStatus.completed));
  //     expect(completedReportage.taskTitle, equals(shortTask.title));
  //     expect(completedReportage.taskId, equals(shortTask.id));
  //     expect(completedReportage.startDate, isNotNull);
  //     expect(completedReportage.endDate, isNotNull);
  //     expect(
  //       completedReportage.endDate.isAfter(completedReportage.startDate),
  //       isTrue,
  //     );

  //     await timer.dispose();
  //   });

  //   test('Saves uncompleted task reportage when finish() is called', () async {
  //     final shortTask = Task(
  //       id: '8',
  //       title: 'uncompleted task',
  //       workDuration: Duration(milliseconds: 50),
  //       shortBreakDuration: Duration(milliseconds: 50),
  //       longBreakDuration: Duration(milliseconds: 50),
  //       maxPomodoroRound: 3,
  //       vibrate: true,
  //       tone: Tones.alert,
  //       toneVolume: 0.5,
  //       statusVolume: 0.5,
  //       readStatusAloud: true,
  //     );

  //     final timer = PomodoroTimer(
  //       timerTickDuration: Duration(milliseconds: 5),
  //       task: shortTask,
  //       soundPlayer: pomodoroSoundPlayer,
  //       tasksReportageDatabase: tasksReportageRepository,
  //     );

  //     timer.start();
  //     await Future.delayed(Duration(milliseconds: 30));
  //     timer.finish();
  //     await Future.delayed(Duration(milliseconds: 30));

  //     final reportages = await tasksReportageRepository.getTodayReportages();
  //     final uncompletedReportage = reportages.firstWhere(
  //       (r) => r.taskId == shortTask.id,
  //     );

  //     expect(uncompletedReportage.taskStatus, equals(TaskStatus.uncompleted));
  //     expect(uncompletedReportage.taskTitle, equals(shortTask.title));

  //     await timer.dispose();
  //   });

  //   test('Reportage contains correct start and end dates', () async {
  //     final shortTask = Task(
  //       id: '9',
  //       title: 'date test task',
  //       workDuration: Duration(milliseconds: 50),
  //       shortBreakDuration: Duration(milliseconds: 50),
  //       longBreakDuration: Duration(milliseconds: 50),
  //       maxPomodoroRound: 1,
  //       vibrate: true,
  //       tone: Tones.alert,
  //       toneVolume: 0.5,
  //       statusVolume: 0.5,
  //       readStatusAloud: true,
  //     );

  //     final timer = PomodoroTimer(
  //       timerTickDuration: Duration(milliseconds: 5),
  //       task: shortTask,
  //       soundPlayer: pomodoroSoundPlayer,
  //       tasksReportageDatabase: tasksReportageRepository,
  //     );

  //     final beforeStart = DateTime.now();
  //     timer.start();
  //     await Future.delayed(Duration(milliseconds: 150));
  //     final afterEnd = DateTime.now();

  //     final reportages = await tasksReportageRepository.getTodayReportages();
  //     final reportage = reportages.firstWhere(
  //       (r) => r.taskId == shortTask.id,
  //     );

  //     expect(reportage.startDate.isAfter(beforeStart), isTrue);
  //     expect(reportage.endDate.isBefore(afterEnd), isTrue);
  //     expect(reportage.endDate.isAfter(reportage.startDate), isTrue);

  //     await timer.dispose();
  //   });

  //   test('Multiple task completions create separate reportages', () async {
  //     final task1 = Task(
  //       id: '10',
  //       title: 'task 1',
  //       workDuration: Duration(milliseconds: 50),
  //       shortBreakDuration: Duration(milliseconds: 50),
  //       longBreakDuration: Duration(milliseconds: 50),
  //       maxPomodoroRound: 1,
  //       vibrate: true,
  //       tone: Tones.alert,
  //       toneVolume: 0.5,
  //       statusVolume: 0.5,
  //       readStatusAloud: true,
  //     );

  //     final task2 = Task(
  //       id: '11',
  //       title: 'task 2',
  //       workDuration: Duration(milliseconds: 50),
  //       shortBreakDuration: Duration(milliseconds: 50),
  //       longBreakDuration: Duration(milliseconds: 50),
  //       maxPomodoroRound: 1,
  //       vibrate: true,
  //       tone: Tones.alert,
  //       toneVolume: 0.5,
  //       statusVolume: 0.5,
  //       readStatusAloud: true,
  //     );

  //     final timer1 = PomodoroTimer(
  //       timerTickDuration: Duration(milliseconds: 5),
  //       task: task1,
  //       soundPlayer: pomodoroSoundPlayer,
  //       tasksReportageDatabase: tasksReportageRepository,
  //     );

  //     final timer2 = PomodoroTimer(
  //       timerTickDuration: Duration(milliseconds: 5),
  //       task: task2,
  //       soundPlayer: pomodoroSoundPlayer,
  //       tasksReportageDatabase: tasksReportageRepository,
  //     );

  //     timer1.start();
  //     await Future.delayed(Duration(milliseconds: 150));

  //     timer2.start();
  //     await Future.delayed(Duration(milliseconds: 150));

  //     final reportages = await tasksReportageRepository.getTodayReportages();
  //     final task1Reportages = reportages.where((r) => r.taskId == task1.id);
  //     final task2Reportages = reportages.where((r) => r.taskId == task2.id);

  //     expect(task1Reportages.length, greaterThanOrEqualTo(1));
  //     expect(task2Reportages.length, greaterThanOrEqualTo(1));

  //     await timer1.dispose();
  //     await timer2.dispose();
  //   });

  //   test('Reportage has unique ID', () async {
  //     final shortTask = Task(
  //       id: '12',
  //       title: 'unique id test',
  //       workDuration: Duration(milliseconds: 50),
  //       shortBreakDuration: Duration(milliseconds: 50),
  //       longBreakDuration: Duration(milliseconds: 50),
  //       maxPomodoroRound: 1,
  //       vibrate: true,
  //       tone: Tones.alert,
  //       toneVolume: 0.5,
  //       statusVolume: 0.5,
  //       readStatusAloud: true,
  //     );

  //     final timer = PomodoroTimer(
  //       timerTickDuration: Duration(milliseconds: 5),
  //       task: shortTask,
  //       soundPlayer: pomodoroSoundPlayer,
  //       tasksReportageDatabase: tasksReportageRepository,
  //     );

  //     timer.start();
  //     await Future.delayed(Duration(milliseconds: 150));

  //     final reportages = await tasksReportageRepository.getTodayReportages();
  //     final reportage = reportages.firstWhere(
  //       (r) => r.taskId == shortTask.id,
  //     );

  //     expect(reportage.id, isNotNull);
  //     expect(reportage.id, isNotEmpty);

  //     await timer.dispose();
  //   });
  // });
}
