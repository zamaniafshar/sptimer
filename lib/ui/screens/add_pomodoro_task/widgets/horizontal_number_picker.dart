import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:pomotimer/data/models/app_texts.dart';
import 'package:pomotimer/localization/app_localization.dart';

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

  late final FixedExtentScrollController controller = FixedExtentScrollController(
    initialItem: numbers.indexOf(widget.initialNumber),
  );

  late ThemeData theme;
  late Color? inActiveColor;
  late AppTexts appTexts;
  late TextStyle centerTextStyle;
  late TextStyle minTextStyle;
  late TextStyle mediumTextStyle;
  late int selectedNumber = widget.initialNumber;

  @override
  void didUpdateWidget(covariant HorizontalNumberPicker oldWidget) {
    if (oldWidget.isActive != widget.isActive) initStylesAndColors();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    theme = Theme.of(context);
    appTexts = AppLocalization.of(context);
    initStylesAndColors();
    super.didChangeDependencies();
  }

  void initStylesAndColors() {
    inActiveColor = widget.isActive ? null : theme.colorScheme.onBackground.withOpacity(0.3);
    mediumTextStyle =
        theme.primaryTextTheme.bodyLarge!.copyWith(inherit: true, color: inActiveColor);
    minTextStyle = theme.primaryTextTheme.bodyMedium!.copyWith(inherit: true, color: inActiveColor);
    centerTextStyle = TextStyle(fontSize: 18.sp, color: Colors.white, inherit: true);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  child: ValueBuilder<dynamic>(
                    builder: (_, update) {
                      return ListWheelScrollView.useDelegate(
                        diameterRatio: 3,
                        controller: controller,
                        itemExtent: widget.width / 5,
                        onSelectedItemChanged: (int index) {
                          selectedNumber = index + widget.min;
                          widget.onSelectedItemChanged?.call(selectedNumber);
                          update(null);
                        },
                        physics: widget.isActive
                            ? const FixedExtentScrollPhysics()
                            : const NeverScrollableScrollPhysics(),
                        childDelegate: ListWheelChildBuilderDelegate(
                          childCount: numbers.length,
                          builder: (context, index) {
                            final item = index + widget.min;
                            TextStyle textStyle;
                            if (item == selectedNumber) {
                              // Center number text style
                              textStyle = centerTextStyle;
                            } else if ((item - selectedNumber).abs() == 2) {
                              // 2 Left number text style
                              textStyle = minTextStyle;
                            } else if ((item - selectedNumber).abs() == 1) {
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
                                    appTexts.convertNumber('${numbers[index]}'),
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
