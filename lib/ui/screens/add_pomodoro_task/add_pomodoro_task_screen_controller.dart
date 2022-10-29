import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomotimer/controller/tasks_controller.dart';
import 'package:pomotimer/data/enum/tones.dart';
import 'package:pomotimer/data/models/pomodoro_task_model.dart';

class AddPomodoroTaskScreenController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final scrollController = ScrollController();
  final titleError = false.obs;
  final Rx<Tones> tone = Tones.magical.obs;
  String title = '';

  int workDuration = 25;
  int shortBreakDuration = 5;
  int longBreakDuration = 15;
  int maxPomodoroRound = 3;
  bool vibrate = true;
  double toneVolume = 0.5;
  double statusVolume = 0.5;
  bool readStatusAloud = true;

  bool get isReadStatusMuted => statusVolume == 0.0 || readStatusAloud == false;
  bool get isToneMuted => toneVolume == 0.0 || tone.value == Tones.none;

  String? titleValidator(String? text) {
    if (text == null || text.isEmpty) {
      return 'Please enter title';
    } else if (text.length > 20) {
      return 'Too long ';
    }
    return null;
  }

  void titleSaver(String? text) {
    title = text!;
  }

  Future<void> scrollToTop() async {
    await scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  bool addTask() {
    if (!formKey.currentState!.validate()) {
      scrollToTop();
      titleError.value = true;
      return false;
    }
    formKey.currentState!.save();
    titleError.value = false;
    final task = PomodoroTaskModel(
      title: title,
      workDuration: workDuration.minutes,
      shortBreakDuration: shortBreakDuration.minutes,
      longBreakDuration: longBreakDuration.minutes,
      maxPomodoroRound: maxPomodoroRound,
      tone: tone.value,
      vibrate: vibrate,
      statusVolume: statusVolume,
      toneVolume: toneVolume,
      readStatusAloud: readStatusAloud,
    );
    Get.find<TasksController>().addTask(task);
    return true;
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
