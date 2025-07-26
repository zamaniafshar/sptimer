import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sptimer/common/service_locator/service_locator.dart';
import 'package:sptimer/data/models/task.dart';
import 'package:sptimer/data/repositories/tasks_repository.dart';
import 'package:sptimer/logic/add_edit_task/add_edit_task_cubit.dart';
import 'package:sptimer/view/add_edit_task/widgets/animated_slide_visibility.dart';
import 'package:sptimer/view/add_edit_task/widgets/list_tile_switch.dart';
import 'package:sptimer/common/extensions/extensions.dart';
import 'package:sptimer/common/widgets/neumorphic/background_container.dart';

import 'widgets/horizontal_number_picker.dart';
import 'widgets/tone_picker.dart';
import 'widgets/volume_picker/volume_picker.dart';

@RoutePage()
class AddEditTaskScreen extends StatefulWidget implements AutoRouteWrapper {
  const AddEditTaskScreen({Key? key, this.task}) : super(key: key);
  final Task? task;

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => AddEditTaskCubit(
        tasksRepository: locator(),
        task: task,
      ),
      child: this,
    );
  }

  @override
  State<AddEditTaskScreen> createState() => _AddEditTaskScreenState();
}

class _AddEditTaskScreenState extends State<AddEditTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _showReadAloudVolumePicker = false;

  @override
  Widget build(BuildContext context) {
    final localization = context.localization;
    final theme = context.theme;
    final cubit = context.read<AddEditTaskCubit>();
    final state = context.watch<AddEditTaskCubit>().state;

    final title = state.isEditing ? localization.editTaskTitle : localization.addTask;

    final buttonText = state.isEditing ? localization.editTaskTitle : localization.addTask;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: AppBackButton(),
        title: Text(title),
      ),
      body: BlocListener<AddEditTaskCubit, AddEditTaskState>(
        listener: (context, state) {
          if (state.error is SoundSettingsSetMutedError) {
            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(
            //     content: Text(localization.soundSettingsMuteMessage),
            //   ),
            // );
          }
        },
        child: Stack(
          children: [
            ListView(
              padding: EdgeInsetsDirectional.fromSTEB(10.w, 15.h, 10.w, 80.h),
              children: [
                BackgroundContainer(
                  height: 60.h,
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Center(
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                        initialValue: state.title,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return localization.taskNameError;
                          }
                          return null;
                        },
                        onChanged: cubit.updateTitle,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: localization.taskName,
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
                            initialNumber: state.maxPomodoroRound,
                            onSelectedItemChanged: cubit.updateMaxPomodoroRound,
                          ),
                          HorizontalNumberPicker(
                            min: 15,
                            max: 90,
                            title: localization.workIntervals,
                            suffix: localization.minutes,
                            initialNumber: state.workDuration.inMinutes,
                            height: 80.h,
                            width: constraints.maxWidth,
                            onSelectedItemChanged: (int selectedNumber) {
                              cubit.updateWorkDuration(Duration(minutes: selectedNumber));
                            },
                          ),
                          HorizontalNumberPicker(
                            min: 1,
                            max: 15,
                            title: localization.shortBreak,
                            suffix: localization.minutes,
                            height: 80.h,
                            width: constraints.maxWidth,
                            initialNumber: state.shortBreakDuration.inMinutes,
                            onSelectedItemChanged: (int selectedNumber) {
                              cubit.updateShortBreakDuration(Duration(minutes: selectedNumber));
                            },
                          ),
                          HorizontalNumberPicker(
                            min: 15,
                            max: 30,
                            title: localization.longBreak,
                            suffix: localization.minutes,
                            height: 80.h,
                            width: constraints.maxWidth,
                            initialNumber: state.longBreakDuration.inMinutes,
                            onSelectedItemChanged: (int selectedNumber) {
                              cubit.updateLongBreakDuration(Duration(minutes: selectedNumber));
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
                        initialValue: state.vibrate,
                        title: localization.vibrationTitle,
                        description: localization.vibrationDescription,
                        onChange: (_) => cubit.toggleVibrate(),
                      ),
                      20.verticalSpace,
                      AnimatedSlideVisibility(
                        show: _showReadAloudVolumePicker,
                        maxHeight: 110.h,
                        minHeight: 60.h,
                        childHeight: 60.h,
                        title: Container(
                          color: theme.colorScheme.surface,
                          child: ListTileSwitch(
                            initialValue: state.readStatusAloud,
                            title: localization.readStatusTitle,
                            description: localization.readPomodoroStatusDescription,
                            onChange: (_) => cubit.toggleReadStatusAloud(),
                            titleSuffix: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _showReadAloudVolumePicker = !_showReadAloudVolumePicker;
                                });
                              },
                              child: Icon(
                                _showReadAloudVolumePicker
                                    ? Icons.arrow_drop_up
                                    : Icons.arrow_drop_down,
                              ),
                            ),
                          ),
                        ),
                        child: VolumePicker(
                          initialValue: state.statusVolume,
                          active: true,
                          onChange: cubit.updateStatusVolume,
                        ),
                      ),
                      TonePicker(
                        initialValue: state.tone,
                        onSelectedItemChanged: cubit.updateTone,
                        volume: state.toneVolume,
                        onVolumeChanged: cubit.updateToneVolume,
                      ),
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
                    onPressed: () async {
                      final isValid = _formKey.currentState!.validate();
                      if (!isValid) return;

                      await cubit.addOrEdit();

                      Navigator.pop(context);
                    },
                    child: Text(buttonText),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppBackButton extends StatelessWidget {
  const AppBackButton({
    super.key,
    this.onBack,
  });

  final void Function()? onBack;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onBack ?? () => Navigator.pop(context),
      splashRadius: 24.r,
      iconSize: 24.sp,
      icon: Icon(
        Icons.arrow_back_ios_new_rounded,
      ),
    );
  }
}
