import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomotimer/ui/screens/tasks/tasks_controller.dart';
import 'package:pomotimer/data/enums/tones.dart';
import 'package:pomotimer/data/models/pomodoro_task_model.dart';

class AddPomodoroTaskScreenController extends GetxController {
  AddPomodoroTaskScreenController(PomodoroTaskModel? task)
      : workDuration = task?.workDuration.inMinutes ?? 25,
        shortBreakDuration = task?.shortBreakDuration.inMinutes ?? 5,
        longBreakDuration = task?.longBreakDuration.inMinutes ?? 15,
        maxPomodoroRound = task?.maxPomodoroRound ?? 3,
        vibrate = task?.vibrate ?? true,
        toneVolume = task?.toneVolume ?? 0.5,
        tone = (task?.tone ?? Tones.magical).obs,
        statusVolume = task?.statusVolume ?? 0.5,
        readStatusAloud = task?.readStatusAloud ?? true,
        title = task?.title ?? '',
        _id = task?.id,
        _isEditing = task != null;

  final formKey = GlobalKey<FormState>();
  final scrollController = ScrollController();
  final titleError = false.obs;
  final Rx<Tones> tone;
  final int? _id;

  String title;
  int workDuration;
  int shortBreakDuration;
  int longBreakDuration;
  int maxPomodoroRound;
  bool vibrate;
  double toneVolume;
  double statusVolume;
  bool readStatusAloud;
  bool _isEditing;

  bool get isReadStatusMuted => statusVolume == 0.0 || readStatusAloud == false;
  bool get isToneMuted => toneVolume == 0.0 || tone.value == Tones.none;
  bool get isEditing => _isEditing;

  String? titleValidator(String? text) {
    if (text == null || text.isEmpty) {
      return 'Please enter title';
    } else if (text.length > 25) {
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

  PomodoroTaskModel? addTask() {
    if (!formKey.currentState!.validate()) {
      scrollToTop();
      titleError.value = true;
      return null;
    }
    formKey.currentState!.save();
    titleError.value = false;
    final task = PomodoroTaskModel(
      id: _id,
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
    return task;
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
