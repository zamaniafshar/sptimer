import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sptimer/data/enums/tones.dart';
import 'package:sptimer/data/services/pomodoro_sound_player.dart';
import 'package:sptimer/common/extensions/extensions.dart';
import 'package:sptimer/common/widgets/overlays/mute_alert_toast.dart';

import 'volume_picker/volume_picker.dart';

class TonePicker extends StatelessWidget {
  const TonePicker({
    Key? key,
    required this.initialValue,
    required this.onSelectedItemChanged,
    required this.volume,
    required this.onVolumeChanged,
  }) : super(key: key);

  final Tones initialValue;
  final ValueChanged<Tones> onSelectedItemChanged;
  final double volume;
  final ValueChanged<double> onVolumeChanged;

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
        '${localization.selectedTone} ${initialValue.name}',
        style: theme.primaryTextTheme.bodyMedium,
      ),
      onTap: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          isScrollControlled: true,
          builder: (context) {
            return _TonePickerBottomSheet(
              initialValue: initialValue,
              onSelectedItemChanged: onSelectedItemChanged,
              volume: volume,
              onVolumeChanged: onVolumeChanged,
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
    required this.onSelectedItemChanged,
    required this.volume,
    required this.onVolumeChanged,
  }) : super(key: key);

  final Tones initialValue;
  final ValueChanged<Tones> onSelectedItemChanged;
  final double volume;
  final ValueChanged<double> onVolumeChanged;

  @override
  State<_TonePickerBottomSheet> createState() => _TonePickerBottomSheetState();
}

class _TonePickerBottomSheetState extends State<_TonePickerBottomSheet> {
  final scrollController = ScrollController();
  final player = PomodoroSoundPlayer();
  late Tones _selectedTone;

  @override
  void initState() {
    super.initState();
    _selectedTone = widget.initialValue;
    Future.delayed(const Duration(milliseconds: 200), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          widget.initialValue.index * 50.h,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      }
    });
    player.init();
    player.setVolume(widget.volume);
  }

  @override
  void dispose() {
    scrollController.dispose();
    player.dispose();
    super.dispose();
  }

  Future<void> _playTone(Tones tone) async {
    if (widget.volume == 0.0) return;
    if (await player.cantPlaySound()) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      showMuteAlertToastMessage(
        context,
      );
      return;
    }

    await player.playTone(tone);
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final localization = context.localization;

    return Container(
      color: theme.colorScheme.surface,
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
          SizedBox(
            height: 300.h, // give it a fixed height or it will overflow
            child: ListView.separated(
              itemCount: Tones.values.length,
              controller: scrollController,
              separatorBuilder: (context, index) {
                return Divider(indent: 72.w);
              },
              itemBuilder: (context, index) {
                final tone = Tones.values[index];
                return RadioListTile<Tones>(
                  value: tone,
                  groupValue: _selectedTone,
                  onChanged: (value) {
                    if (value == null) return;
                    setState(() {
                      _selectedTone = value;
                    });
                    widget.onSelectedItemChanged(value);
                    _playTone(value);
                  },
                  title: Text(
                    tone.name,
                    style: theme.textTheme.labelLarge,
                  ),
                );
              },
            ),
          ),
          Container(
            color: theme.colorScheme.surface,
            padding: EdgeInsets.all(15.r),
            child: VolumePicker(
              initialValue: widget.volume,
              active: true,
              onChange: (value) {
                widget.onVolumeChanged(value);
                player.setVolume(value);
              },
            ),
          ),
        ],
      ),
    );
  }
}
