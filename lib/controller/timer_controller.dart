import 'package:get/get.dart';
import 'package:pomotimer/controller/home_screen_controller.dart';
import 'package:pomotimer/data/models/pomodoro_timer_model.dart';
import 'package:pomotimer/data/services/foreground_service/timer_foreground_service.dart';
import 'package:pomotimer/ui/widgets/circle_start_button/circle_start_button_controller.dart';
import 'package:pomotimer/ui/widgets/circle_start_button/enum.dart';
import 'package:pomotimer/ui/widgets/circle_timer/circle_timer_controller.dart';
import 'package:pomotimer/ui/widgets/custom_slider/custom_slider_controller.dart';
import 'package:pomotimer/util/constants.dart';

class TimerController {
  final CircleStartButtonController _circleStartButtonController = Get.find();
  final CustomSliderController _sliderController = Get.find();
  final CircleTimerController _circleTimerController = Get.find();
  final HomeScreenController _homeScreenController = Get.find();

  TimerController() {
    _circleStartButtonController.statusListener.listen(_changeStatusListener);
  }

  void _changeStatusListener(status) async {
    switch (status) {
      case CircleButtonStatus.started:
        _startTimer();
        break;
      case CircleButtonStatus.puased:
        _circleTimerController.pause();
        break;
      case CircleButtonStatus.resumed:
        _circleTimerController.resume();
        break;
      case CircleButtonStatus.finished:
        _stopTimer();
        break;
    }
  }

  void sendAppToBackground() {
    if (!_circleStartButtonController.isStarted) return;
    _circleTimerController.pause();
    TimerForegroundService.start(
      PomodoroTimerModel(
        maxRound: _sliderController.sliderValue.toInt(),
        round: 1,
        secondsLeft: _circleTimerController.secondsLeft,
        isWorkTime: false,
      ),
    );
  }

  void initData() {
    if (TimerForegroundService.isStarted) {
      _initDataFromBackground();
    } else {
      _circleTimerController.setTimer(kSecondsOfWorkTime);
    }
  }

  void _initDataFromBackground() {}

  void _startTimer() {
    _circleTimerController.start();
    _homeScreenController.showGradiantColor(true);
    _sliderController.deactivate();
  }

  void _stopTimer() {
    _circleTimerController.stop();
    _homeScreenController.showGradiantColor(false);
    _sliderController.activate();
  }
}
