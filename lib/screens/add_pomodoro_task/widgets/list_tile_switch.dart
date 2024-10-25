import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ListTileSwitch extends StatelessWidget {
  const ListTileSwitch({
    Key? key,
    this.defaultValue = true,
    this.titleSuffix,
    required this.title,
    required this.description,
    required this.onChange,
  }) : super(key: key);

  final String title;
  final String description;
  final bool defaultValue;
  final void Function(bool) onChange;
  final Widget? titleSuffix;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
                  title,
                  style: theme.textTheme.labelLarge,
                ),
                if (titleSuffix != null) titleSuffix!
              ],
            ),
            SizedBox(height: 5.h),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: 45.h,
                maxWidth: 230.w,
              ),
              child: Text(
                description,
                style: theme.primaryTextTheme.bodyMedium,
                maxLines: 2,
              ),
            ),
          ],
        ),
        ValueBuilder<bool?>(
          initialValue: defaultValue,
          builder: (value, update) {
            return Center(
              child: SizedBox(
                width: 60.w,
                child: Switch(
                  value: value!,
                  onChanged: (newValue) {
                    update(newValue);
                  },
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
