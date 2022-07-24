import 'package:get/get.dart';
import 'package:pomotimer/controller/ui_controller.dart';
import 'package:pomotimer/data/pomodoro_timer.dart';

class MainController {
  MainController() {
    init();
  }
  final UiController uiController = Get.find();

  void init() {
    uiController.init(null);
  }

  void sendAppToBackground() {}

  void initData() {}
}
