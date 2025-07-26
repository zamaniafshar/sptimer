import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sptimer/common/extensions/extensions.dart';
import 'package:sptimer/common/widgets/neumorphic/neumorphic_switch.dart';

class ListTileSwitch extends StatefulWidget {
  const ListTileSwitch({
    Key? key,
    this.initialValue = true,
    this.titleSuffix,
    required this.title,
    required this.description,
    required this.onChange,
  }) : super(key: key);

  final String title;
  final String description;
  final bool initialValue;
  final void Function(bool) onChange;
  final Widget? titleSuffix;

  @override
  State<ListTileSwitch> createState() => _ListTileSwitchState();
}

class _ListTileSwitchState extends State<ListTileSwitch> {
  late bool value = widget.initialValue;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Text(
                  widget.title,
                  style: theme.textTheme.labelLarge,
                ),
                if (widget.titleSuffix != null) widget.titleSuffix!
              ],
            ),
            SizedBox(height: 5.h),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: 45.h,
                maxWidth: 230.w,
              ),
              child: Text(
                widget.description,
                style: theme.primaryTextTheme.bodyMedium,
                maxLines: 2,
              ),
            ),
          ],
        ),
        Center(
          child: SizedBox(
            width: 60.w,
            child: AppNeumorphicSwitch(
              value: value,
              onChanged: (newValue) {
                value = newValue;
                widget.onChange(newValue);
                setState(() {});
              },
            ),
          ),
        ),
      ],
    );
  }
}
