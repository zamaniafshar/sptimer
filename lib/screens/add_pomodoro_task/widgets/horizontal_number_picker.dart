import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sptimer/utils/extensions/extensions.dart';
import 'package:sptimer/utils/helpers/value_state_builder.dart';

class HorizontalNumberPicker extends StatefulWidget {
  const HorizontalNumberPicker({
    Key? key,
    required this.min,
    required this.max,
    required this.initialNumber,
    required this.title,
    required this.suffix,
    required this.height,
    required this.width,
    this.isActive = true,
    this.onSelectedItemChanged,
  }) : super(key: key);

  final int min;
  final int max;
  final int initialNumber;
  final String title;
  final String suffix;
  final double height;
  final double width;
  final bool isActive;
  final void Function(int selectedNumber)? onSelectedItemChanged;

  @override
  State<HorizontalNumberPicker> createState() => _HorizontalNumberPickerState();
}

class _HorizontalNumberPickerState extends State<HorizontalNumberPicker> {
  late final List<int> numbers = List.generate(
    (widget.max + 1) - widget.min,
    (index) => index + widget.min,
  );

  late final controller = FixedExtentScrollController(
    initialItem: numbers.indexOf(widget.initialNumber),
  );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final localization = context.localization;
    final inActiveColor = widget.isActive ? null : theme.colorScheme.onBackground.withOpacity(0.3);
    final mediumTextStyle =
        theme.primaryTextTheme.bodyLarge!.copyWith(inherit: true, color: inActiveColor);
    final minTextStyle =
        theme.primaryTextTheme.bodyMedium!.copyWith(inherit: true, color: inActiveColor);
    final centerTextStyle = TextStyle(fontSize: 18.sp, color: Colors.white, inherit: true);

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: theme.textTheme.labelLarge!.copyWith(color: inActiveColor),
              ),
              Text(
                widget.suffix,
                style: theme.textTheme.labelMedium!.copyWith(color: inActiveColor),
              ),
            ],
          ),
          Expanded(
            child: Stack(
              children: [
                Center(
                  child: Container(
                    width: 40.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      color: inActiveColor ?? theme.colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                ),
                RotatedBox(
                  quarterTurns: -1,
                  child: ValueStateBuilder(
                    initialValue: widget.initialNumber,
                    builder: (_, value, updater) {
                      return ListWheelScrollView.useDelegate(
                        diameterRatio: 3,
                        controller: controller,
                        itemExtent: widget.width / 5,
                        onSelectedItemChanged: (int index) {
                          final selectedNumber = index + widget.min;
                          widget.onSelectedItemChanged?.call(selectedNumber);
                          updater(selectedNumber);
                        },
                        physics: widget.isActive
                            ? const FixedExtentScrollPhysics()
                            : const NeverScrollableScrollPhysics(),
                        childDelegate: ListWheelChildBuilderDelegate(
                          childCount: numbers.length,
                          builder: (context, index) {
                            final item = index + widget.min;
                            TextStyle textStyle;
                            if (item == value) {
                              // Center number text style
                              textStyle = centerTextStyle;
                            } else if ((item - value).abs() == 2) {
                              // 2 Left number text style
                              textStyle = minTextStyle;
                            } else if ((item - value).abs() == 1) {
                              // 1 Left number text style
                              textStyle = mediumTextStyle;
                            } else {
                              // Default text style
                              textStyle = const TextStyle(color: Colors.black12, inherit: true);
                            }

                            return RotatedBox(
                              quarterTurns: 1,
                              child: Center(
                                child: AnimatedDefaultTextStyle(
                                  duration: const Duration(milliseconds: 150),
                                  style: textStyle,
                                  child: Text(
                                    '${numbers[index]}',
                                    strutStyle: StrutStyle.fromTextStyle(textStyle),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
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
