import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'animated_text.dart';
import 'package:pomotimer/util/util.dart';

class TimerText extends StatelessWidget {
  const TimerText({
    Key? key,
    required this.animateBack,
    required this.secondsLeft,
  }) : super(key: key);

  final bool animateBack;
  final int secondsLeft;

  String get text {
    final String minutes = secondsLeft.secToMinutes.toString().padLeft(2, '0');
    final String seconds = secondsLeft.secLeft.toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (int i = 0; i <= 4; i++)
            AnimatedText(
              text: text[i],
              animateBack: animateBack,
            ),
        ],
      ),
    );
  }
}
