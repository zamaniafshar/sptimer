import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pomotimer/data/enums/tones.dart';
import 'package:pomotimer/data/models/pomodoro_task_model.dart';
import 'package:pomotimer/ui/screens/add_pomodoro_task/add_pomodoro_task_screen_controller.dart';
import 'package:pomotimer/ui/screens/add_pomodoro_task/widgets/animated_slide_visibility.dart';
import 'package:pomotimer/ui/screens/add_pomodoro_task/widgets/list_tile_switch.dart';
import 'package:pomotimer/ui/widgets/background_container.dart';
import 'package:pomotimer/utils/utils.dart';

import 'widgets/horizontal_number_picker.dart';
import 'widgets/tone_picker.dart';
import 'widgets/volume_picker/volume_picker.dart';

class AddPomodoroTaskScreen extends StatefulWidget {
  const AddPomodoroTaskScreen({Key? key, this.task}) : super(key: key);
  final PomodoroTaskModel? task;
  @override
  State<AddPomodoroTaskScreen> createState() => _AddPomodoroTaskScreenState();
}

class _AddPomodoroTaskScreenState extends State<AddPomodoroTaskScreen> {
  late final AddPomodoroTaskScreenController controller;

  @override
  void initState() {
    controller = Get.put(AddPomodoroTaskScreenController(widget.task));
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<AddPomodoroTaskScreenController>();
    super.dispose();
  }

  String get title => controller.isEditing ? 'Edit Task' : 'Add New Task';
  String get buttonText => controller.isEditing ? 'Save Edit' : 'Add New Task';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFECECEC),
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          splashRadius: 30.r,
          icon: Icon(
            Icons.arrow_back_ios,
            size: 27.r,
          ),
        ),
        title: Text(title),
      ),
      body: Stack(
        children: [
          ListView(
            controller: controller.scrollController,
            padding: EdgeInsets.fromLTRB(10.w, 15.h, 10.w, 80.h),
            children: [
              Obx(
                () => BackgroundContainer(
                  padding: EdgeInsets.fromLTRB(
                    15.w,
                    0,
                    15.w,
                    controller.titleError.value ? 10.h : 0,
                  ),
                  child: Form(
                    key: controller.formKey,
                    child: TextFormField(
                      initialValue: controller.title,
                      validator: controller.titleValidator,
                      onSaved: controller.titleSaver,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Task name',
                      ),
                    ),
                  ),
                ),
              ),
              30.verticalSpace,
              BackgroundContainer(
                height: 420.h,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        HorizontalNumberPicker(
                          min: 1,
                          max: 10,
                          title: 'Rounds',
                          suffix: 'Intervals',
                          height: 80.h,
                          width: constraints.maxWidth,
                          initialNumber: controller.maxPomodoroRound,
                          onSelectedItemChanged: (int selectedNumber) {
                            controller.maxPomodoroRound = selectedNumber;
                          },
                        ),
                        HorizontalNumberPicker(
                          min: 15,
                          max: 90,
                          title: 'Work interval',
                          suffix: 'Minutes',
                          initialNumber: controller.workDuration,
                          height: 80.h,
                          width: constraints.maxWidth,
                          onSelectedItemChanged: (int selectedNumber) {
                            controller.workDuration = selectedNumber;
                          },
                        ),
                        HorizontalNumberPicker(
                          min: 1,
                          max: 15,
                          title: 'Short break',
                          suffix: 'Minutes',
                          height: 80.h,
                          width: constraints.maxWidth,
                          initialNumber: controller.shortBreakDuration,
                          onSelectedItemChanged: (int selectedNumber) {
                            controller.shortBreakDuration = selectedNumber;
                          },
                        ),
                        HorizontalNumberPicker(
                          min: 1,
                          max: 30,
                          title: 'Long break',
                          suffix: 'Minutes',
                          height: 80.h,
                          width: constraints.maxWidth,
                          initialNumber: controller.longBreakDuration,
                          onSelectedItemChanged: (int selectedNumber) {
                            controller.longBreakDuration = selectedNumber;
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(height: 30.h),
              BackgroundContainer(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 50.h,
                      child: ListTileSwitch(
                        defaultValue: controller.vibrate,
                        title: 'Vibration',
                        description: 'Add vibration when an event comes.',
                        onChange: (bool value) {
                          controller.vibrate = value;
                        },
                      ),
                    ),
                    20.verticalSpace,
                    ValueStateBuilder<bool>(
                      initialValue: false,
                      builder: (context, show, updater) {
                        final theme = Theme.of(context);
                        return AnimatedSlideVisibility(
                          show: show,
                          maxHeight: 100.h,
                          minHeight: 50.h,
                          title: Container(
                            color: theme.colorScheme.surface,
                            height: 50.h,
                            child: ListTileSwitch(
                              defaultValue: controller.readStatusAloud,
                              title: 'Read Status',
                              description: 'Read pomodoro timer status aloud.',
                              onChange: (bool value) {
                                controller.readStatusAloud = value;
                              },
                              titleSuffix: GestureDetector(
                                onTap: () {
                                  updater(!show);
                                },
                                child: Icon(
                                  show ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                                ),
                              ),
                            ),
                          ),
                          child: VolumePicker(
                            initialValue: controller.statusVolume,
                            active: true,
                            onChange: (value) {
                              controller.statusVolume = value;
                            },
                          ),
                        );
                      },
                    ),
                    const TonePicker(),
                  ],
                ),
              )
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.all(8.r),
              child: SizedBox(
                height: 50.h,
                width: 300.w,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  onPressed: () {
                    final result = controller.addTask();
                    if ((result != null)) {
                      Navigator.pop(context, result);
                    }
                  },
                  child: Text(buttonText),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
