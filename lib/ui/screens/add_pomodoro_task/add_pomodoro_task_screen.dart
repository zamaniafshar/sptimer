import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sptimer/config/localization/app_localization_data.dart';
import 'package:sptimer/data/models/pomodoro_task_model.dart';
import 'package:sptimer/config/localization/app_localization.dart';
import 'package:sptimer/ui/screens/add_pomodoro_task/add_pomodoro_task_screen_controller.dart';
import 'package:sptimer/ui/screens/add_pomodoro_task/widgets/animated_slide_visibility.dart';
import 'package:sptimer/ui/screens/add_pomodoro_task/widgets/list_tile_switch.dart';
import 'package:sptimer/ui/widgets/widgets.dart';
import 'package:sptimer/utils/utils.dart';

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
  late ThemeData theme;
  late AppLocalizationData localization;
  @override
  void initState() {
    controller = Get.put(AddPomodoroTaskScreenController(widget.task));
    super.initState();
  }

  @override
  void didChangeDependencies() {
    theme = Theme.of(context);
    localization = AppLocalization.of(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    Get.delete<AddPomodoroTaskScreenController>();
    super.dispose();
  }

  String get title => controller.isEditing
      ? localization.addPomodoroScreenEditTitle
      : localization.addPomodoroScreenAddTitle;

  String get buttonText => controller.isEditing
      ? localization.addPomodoroScreenEditButton
      : localization.addPomodoroScreenAddButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.backgroundColor,
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
                          title: localization.addPomodoroScreenRounds,
                          suffix: localization.addPomodoroScreenIntervals,
                          height: 80.h,
                          width: constraints.maxWidth,
                          initialNumber: controller.maxPomodoroRound,
                          onSelectedItemChanged: controller.onMaxPomodoroRoundChange,
                        ),
                        HorizontalNumberPicker(
                          min: 15,
                          max: 90,
                          title: localization.addPomodoroScreenWorkIntervals,
                          suffix: localization.addPomodoroScreenMinutes,
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
                            title: localization.addPomodoroScreenShortBreak,
                            suffix: localization.addPomodoroScreenMinutes,
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
                          title: localization.addPomodoroScreenLongBreak,
                          suffix: localization.addPomodoroScreenMinutes,
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
                      defaultValue: controller.vibrate,
                      title: localization.addPomodoroScreenVibrationTitle,
                      description: localization.addPomodoroScreenVibrationDescription,
                      onChange: (bool value) {
                        controller.vibrate = value;
                      },
                    ),
                    20.verticalSpace,
                    ValueStateBuilder<bool>(
                      initialValue: false,
                      builder: (context, show, updater) {
                        final theme = Theme.of(context);
                        return AnimatedSlideVisibility(
                          show: show,
                          maxHeight: 110.h,
                          minHeight: 60.h,
                          childHeight: 60.h,
                          title: Container(
                            color: theme.colorScheme.surface,
                            child: ListTileSwitch(
                              defaultValue: controller.readStatusAloud,
                              title: localization.addPomodoroScreenReadStatusTitle,
                              description: localization.addPomodoroScreenReadStatusDescription,
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
