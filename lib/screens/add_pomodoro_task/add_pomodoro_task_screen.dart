import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sptimer/data/models/task.dart';
import 'package:sptimer/screens/add_pomodoro_task/widgets/animated_slide_visibility.dart';
import 'package:sptimer/screens/add_pomodoro_task/widgets/list_tile_switch.dart';
import 'package:sptimer/utils/extensions/extensions.dart';
import 'package:sptimer/utils/widgets/background_container.dart';

import 'widgets/horizontal_number_picker.dart';
import 'widgets/tone_picker.dart';
import 'widgets/volume_picker/volume_picker.dart';

class AddPomodoroTaskScreen extends StatefulWidget {
  const AddPomodoroTaskScreen({Key? key, this.task}) : super(key: key);
  final Task? task;
  @override
  State<AddPomodoroTaskScreen> createState() => _AddPomodoroTaskScreenState();
}

class _AddPomodoroTaskScreenState extends State<AddPomodoroTaskScreen> {
  bool get isEditing => widget.task != null;

  String get title => isEditing ? context.localization.addTask : context.localization.editTaskTitle;

  String get buttonText =>
      isEditing ? context.localization.addTask : context.localization.editTaskTitle;

  @override
  Widget build(BuildContext context) {
    final localization = context.localization;
    final theme = context.theme;

    return Scaffold(
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
            padding: EdgeInsetsDirectional.fromSTEB(10.w, 15.h, 10.w, 80.h),
            children: [
              Obx(
                () => BackgroundContainer(
                  padding: EdgeInsetsDirectional.fromSTEB(
                    15.w,
                    0,
                    15.w,
                    controller.titleError.value ? 10.h : 0,
                  ),
                  child: Form(
                    key: controller.formKey,
                    child: TextFormField(
                      initialValue: controller.title,
                      validator: (text) => controller.titleValidator(text, localization),
                      onSaved: controller.titleSaver,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: localization.addPomodoroScreenTaskName,
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
                          title: localization.rounds,
                          suffix: localization.intervals,
                          height: 80.h,
                          width: constraints.maxWidth,
                          initialNumber: controller.maxPomodoroRound,
                          onSelectedItemChanged: controller.onMaxPomodoroRoundChange,
                        ),
                        HorizontalNumberPicker(
                          min: 15,
                          max: 90,
                          title: localization.workIntervals,
                          suffix: localization.minutes,
                          initialNumber: controller.workDuration,
                          height: 80.h,
                          width: constraints.maxWidth,
                          onSelectedItemChanged: (int selectedNumber) {
                            controller.workDuration = selectedNumber;
                          },
                        ),
                        Obx(
                          () => HorizontalNumberPicker(
                            min: 1,
                            max: 15,
                            isActive: controller.isShortBreakPickerActive,
                            title: localization.shortBreak,
                            suffix: localization.minutes,
                            height: 80.h,
                            width: constraints.maxWidth,
                            initialNumber: controller.shortBreakDuration,
                            onSelectedItemChanged: (int selectedNumber) {
                              controller.shortBreakDuration = selectedNumber;
                            },
                          ),
                        ),
                        HorizontalNumberPicker(
                          min: 0,
                          max: 30,
                          title: localization.longBreak,
                          suffix: localization.minutes,
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
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ListTileSwitch(
                      initialValue: controller.vibrate,
                      title: localization.vibrationTitle,
                      description: localization.vibrationDescription,
                      onChange: (bool value) {
                        controller.vibrate = value;
                      },
                    ),
                    20.verticalSpace,
                    ValueStateBuilder<bool>(
                      initialValue: false,
                      builder: (context, show, updater) {
                        final theme = context.theme;
                        return AnimatedSlideVisibility(
                          show: show,
                          maxHeight: 110.h,
                          minHeight: 60.h,
                          childHeight: 60.h,
                          title: Container(
                            color: theme.colorScheme.surface,
                            child: ListTileSwitch(
                              initialValue: controller.readStatusAloud,
                              title: localization.readStatusTitle,
                              description: localization.readPomodoroStatusDescription,
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
                    TonePicker(),
                  ],
                ),
              )
            ],
          ),
          Align(
            alignment: AlignmentDirectional.bottomCenter,
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
