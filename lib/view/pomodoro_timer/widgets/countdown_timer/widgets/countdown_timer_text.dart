import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sptimer/common/extensions/extensions.dart';
import 'animated_text.dart';

class CountdownTimerText extends StatelessWidget {
  const CountdownTimerText({
    Key? key,
    required this.animateBack,
    required this.remainingDuration,
  }) : super(key: key);

  final bool animateBack;
  final Duration remainingDuration;

  @override
  Widget build(BuildContext context) {
    final text = remainingDuration.formatRemainingTime;

    return SizedBox(
      height: 90.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (int i = 0; i <= 4; i++)
            AnimatedText(
              text: text[i],
              width: 20.w,
              reverse: animateBack,
              textStyle: context.theme.textTheme.headlineSmall!.copyWith(
                fontSize: 35.sp,
                fontWeight: FontWeight.bold,
              ),
              animateWhenReverse: true,
            ),
        ],
      ),
    );
  }
}
