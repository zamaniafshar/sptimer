import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomotimer/controller/tasks_controller.dart';
import 'package:pomotimer/data/models/pomodoro_model.dart';

class AddPomodoroTaskScreenController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final scrollController = ScrollController();
  final titleError = false.obs;
  String title = '';

  int workDuration = 25;
  int shortBreakDuration = 5;
  int longBreakDuration = 15;
  int maxPomodoroRound = 3;

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
      curve: Curves.decelerate,
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
