import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HorizontalNumberPicker extends StatefulWidget {
  const HorizontalNumberPicker({
    Key? key,
    required this.min,
    required this.max,
    required this.initialNumber,
    required this.height,
    required this.width,
    required this.title,
    required this.suffix,
    this.onSelectedItemChanged,
  }) : super(key: key);

  final int min;
  final int max;
  final int initialNumber;
  final String title;
  final String suffix;
  final double height;
  final double width;
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
  late TextStyle centerTextStyle;
  late TextStyle minTextStyle;
  late TextStyle mediumTextStyle;
  late int selectedNumber = widget.initialNumber;

  @override
  void didChangeDependencies() {
    theme = Theme.of(context);
    mediumTextStyle = theme.primaryTextTheme.bodyLarge!.copyWith(inherit: true);
    minTextStyle = theme.primaryTextTheme.bodyMedium!.copyWith(inherit: true);
    centerTextStyle = TextStyle(fontSize: 18.sp, color: Colors.white);
    super.didChangeDependencies();
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
                style: theme.textTheme.labelLarge,
              ),
              Text(
                widget.suffix,
                style: theme.textTheme.labelMedium,
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
                      color: theme.colorScheme.primaryContainer,
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
                        physics: const FixedExtentScrollPhysics(),
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
                              textStyle = const TextStyle(color: Colors.black12);
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
