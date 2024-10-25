import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sptimer/config/localization/app_localization.dart';
import 'painters/custom_slider_thumb.dart';
import 'painters/custom_track_slider.dart';

class VolumePicker extends StatefulWidget {
  const VolumePicker({
    Key? key,
    required this.initialValue,
    required this.onChange,
    required this.active,
  }) : super(key: key);
  final bool active;
  final double initialValue;
  final void Function(double value) onChange;
  @override
  State<VolumePicker> createState() => _VolumePickerState();
}

class _VolumePickerState extends State<VolumePicker> {
  late final Rx<double> sliderValue;
  late final Rx<IconData> icon;
  late ThemeData theme;

  @override
  void initState() {
    sliderValue = widget.initialValue.obs;
    icon = getIcon.obs;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    theme = Theme.of(context);
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(VolumePicker oldWidget) {
    if (oldWidget.active != widget.active) icon.value = getIcon;
    super.didUpdateWidget(oldWidget);
  }

  IconData get getIcon {
    if (sliderValue.value >= 0.5) {
      return Icons.volume_up;
    } else if (sliderValue.value == 0.0) {
      return Icons.volume_off;
    } else if (sliderValue.value < 0.5 || (!widget.active)) {
      return Icons.volume_down;
    }
    return Icons.volume_down;
  }

  void setSliderValue(double value) {
    if (widget.active) {
      sliderValue.value = value;
      icon.value = getIcon;
    }
    widget.onChange(value);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          // Neumorphic(
          //   style: NeumorphicStyle(
          //     boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(30)),
          //     depth: -10,
          //     shadowDarkColorEmboss: theme.shadowColor.withOpacity(0.5),
          //     shadowLightColorEmboss: theme.colorScheme.shadow.withOpacity(0.1),
          //     intensity: 0.75,
          //     lightSource: LightSource.topLeft,
          //     color: theme.colorScheme.inverseSurface,
          //   ),
          //   child: SizedBox(
          //     height: 45.h,
          //     width: double.infinity,
          //   ),
          // ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Row(
              children: [
                RotatedBox(
                  quarterTurns: AppLocalization.ofParent(context).isEnglish ? 0 : 2,
                  child: Obx(
                    () => Icon(
                      icon.value,
                      color: widget.active ? Colors.black54 : Colors.black26,
                      size: 30.r,
                    ),
                  ),
                ),
                15.horizontalSpace,
                Expanded(
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      overlayShape: RoundSliderOverlayShape(overlayRadius: 30.r),
                      thumbShape: CustomSliderThumb(
                        thumbRadius: 15.r,
                        primaryColor: theme.primaryColor,
                        thumbColor: theme.colorScheme.surface,
                      ),
                      trackShape: CustomSliderTrack(
                        activeColors: [
                          theme.primaryColorLight,
                          theme.primaryColor,
                        ],
                        inActiveColors: [
                          Colors.black12,
                          Colors.black12,
                        ],
                      ),
                      overlayColor: theme.primaryColorLight.withOpacity(0.5),
                    ),
                    child: Obx(
                      () => Slider(
                        min: 0,
                        max: 1.0,
                        value: sliderValue.value,
                        onChanged: setSliderValue,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
