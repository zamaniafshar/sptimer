import 'package:get/get.dart';
import 'package:pomotimer/ui/screens/start_pomodoro_task_screen/start_pomodoro_task_screen_controller.dart';
import 'package:pomotimer/data/models/pomodoro_task_model.dart';
import 'package:pomotimer/data/pomodoro_timer/pomodoro_timer.dart';
import 'package:pomotimer/data/services/foreground_service/timer_foreground_service.dart';
import 'package:pomotimer/util/constants/constants.dart';

class MainController {
  MainController() {
    init();
  }
  final StartPomodoroTaskScreenController uiController = Get.find();
  final TimerForegroundService service = TimerForegroundService();
  late PomodoroTimer _timer;

  Future<void> init() async {
    // print('init ');
    // await service.init();
    // print('service init');
    // PomodoroTimerModel data;
    // if (await service.isRunning) {
    //   print('stop service');
    //   data = await service.stopService();
    // }else{

    // }
    // print(data?.remainingDuration);
    // _timer = PomodoroTimer(
    //   initData: data,
    //   onRestartTimer: onPomodoroTimerRestart,
    //   onFinish: onPomodoroTimerFinish,
    // );
    // uiController.init(data);
  }

  Future<void> onAppPaused() async {
    // if (uiController.isTimerStarted) await service.startService(uiController.data);
  }
}
