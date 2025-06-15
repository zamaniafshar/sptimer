import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sptimer/data/enums/tones.dart';
import 'package:sptimer/data/services/pomodoro_sound_player.dart';
import 'package:sptimer/common/extensions/extensions.dart';
import 'package:sptimer/common/helpers/simple_state_builder.dart';
import 'package:sptimer/common/widgets/mute_alert_snackbar.dart';

import 'volume_picker/volume_picker.dart';

class TonePicker extends StatefulWidget {
  TonePicker({
    Key? key,
  }) : super(key: key);

  final Tones initialValue;

  @override
  State<TonePicker> createState() => _TonePickerState();
}

class _TonePickerState extends State<TonePicker> {
  late Tones selectedTone = widget.initialValue;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final localization = context.localization;

    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        localization.toneAndVolumeTitle,
        style: theme.textTheme.labelLarge!,
      ),
      subtitle: Text(
        '${localization.selectedTone} ${selectedTone.name}',
        style: theme.primaryTextTheme.bodyMedium,
      ),
      onTap: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          isScrollControlled: true,
          builder: (context) {
            return _TonePickerBottomSheet(
              initialValue: widget.initialValue,
            );
          },
        );
      },
    );
  }
}

class _TonePickerBottomSheet extends StatefulWidget {
  const _TonePickerBottomSheet({
    Key? key,
    required this.initialValue,
  }) : super(key: key);

  final Tones initialValue;

  @override
  State<_TonePickerBottomSheet> createState() => _TonePickerBottomSheetState();
}

class _TonePickerBottomSheetState extends State<_TonePickerBottomSheet> {
  final scrollController = ScrollController();
  final player = PomodoroSoundPlayer();

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 200), () {
      scrollController.animateTo(
        widget.initialValue.index * 50.h,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
    player.init();
    super.initState();
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
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      showMuteAlertSnackbar(
        context,
        context.localization.addPomodoroScreenSoundSettingMute,
        height: 60.h,
      );

      return;
    }

    await player.playTone(controller.tone.value);
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final localization = context.localization;

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
                  localization.toneAndVolumeTitle,
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
