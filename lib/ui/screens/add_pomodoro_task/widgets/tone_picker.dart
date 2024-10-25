import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sptimer/data/enums/tones.dart';
import 'package:sptimer/config/localization/app_localization_data.dart';
import 'package:sptimer/data/services/pomodoro_sound_player.dart';
import 'package:sptimer/config/localization/app_localization.dart';
import 'package:sptimer/controller/add_pomodoro_task_screen_controller.dart';
import 'package:sptimer/utils/utils.dart';

import 'volume_picker/volume_picker.dart';

class TonePicker extends StatelessWidget {
  TonePicker({
    Key? key,
  }) : super(key: key);

  final AddPomodoroTaskScreenController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localization = AppLocalization.of(context);

    return Obx(
      () => ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(
          localization.addPomodoroScreenToneAndVolume,
          style: theme.textTheme.labelLarge!,
        ),
        subtitle: Text(
          '${localization.addPomodoroScreenSelectedTone} ${controller.tone.value.name}',
          style: theme.primaryTextTheme.bodyMedium,
        ),
        onTap: () {
          showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            isScrollControlled: true,
            builder: (context) {
              return const Scaffold(body: _TonePickerBottomSheet());
            },
          );
        },
      ),
    );
  }
}

class _TonePickerBottomSheet extends StatefulWidget {
  const _TonePickerBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  State<_TonePickerBottomSheet> createState() => _TonePickerBottomSheetState();
}

class _TonePickerBottomSheetState extends State<_TonePickerBottomSheet> {
  final AddPomodoroTaskScreenController controller = Get.find();
  final scrollController = ScrollController();
  final player = PomodoroSoundPlayer();
  late ThemeData theme;
  late AppLocalizationData localization;

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 200), () {
      scrollController.animateTo(
        controller.tone.value.index * 50.h,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
    player.init();
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
    scrollController.dispose();
    player.dispose();
    super.dispose();
  }

  Future<void> playTone() async {
    if (controller.isToneMuted) return;
    if (await player.cantPlaySound()) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      showMuteAlertSnackbar(
        context,
        localization.addPomodoroScreenSoundSettingMute,
        height: 60.h,
      );

      return;
    }

    await player.playTone(controller.tone.value);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: theme.colorScheme.surface,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsetsDirectional.only(top: 20.h, start: 20.h, end: 20.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  localization.addPomodoroScreenToneAndVolume,
                  style: theme.textTheme.headlineSmall,
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.close,
                    size: 30.r,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SimpleStateBuilder(
              builder: (context, updater) {
                return ListView.separated(
                  itemCount: Tones.values.length,
                  controller: scrollController,
                  separatorBuilder: (context, index) {
                    return Divider(indent: 72.w);
                  },
                  itemBuilder: (context, index) {
                    return RadioListTile<Tones>(
                      value: Tones.values[index],
                      groupValue: controller.tone.value,
                      selected: true,
                      onChanged: (value) {
                        controller.tone.value = value!;
                        updater();
                        playTone();
                      },
                      title: Text(
                        Tones.values[index].name,
                        style: theme.textTheme.labelLarge,
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Container(
            color: theme.colorScheme.surface,
            padding: EdgeInsets.all(15.r),
            child: VolumePicker(
              initialValue: 0.35,
              active: true,
              onChange: (value) {
                controller.toneVolume = value;
                if (value >= 0.1) player.setVolume(value);
              },
            ),
          ),
        ],
      ),
    );
  }
}
