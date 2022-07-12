import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'controller/rounded_rotational_lines_controller.dart';
import 'controller/timer_animations_controller.dart';
import 'constants.dart';
import 'custom_painters/circular_line_painter.dart';
import 'custom_painters/clock_lines_painter.dart';
import 'custom_painters/rounded_background_line_painter.dart';
import 'custom_painters/rounded_rotational_lines_painter.dart';
import 'widgets/timer_text.dart';

class CircleTimer extends StatelessWidget {
  const CircleTimer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double radius = 90.r;
    final double strokeWidth = 25.r;
    final double areaSize = radius * 2 + strokeWidth;
    final Size customPaintSize = Size.square(areaSize);

    return SizedBox(
      width: areaSize,
      height: areaSize,
      child: Stack(
        alignment: Alignment.center,
        children: [
          RepaintBoundary(
            child: CustomPaint(
              painter: RoundedBackgroundLinePainter(
                radius: radius,
                strokeWidth: strokeWidth,
              ),
            ),
          ),
          RepaintBoundary(
            child: GetBuilder<RoundedRotationalLinesController>(
              id: clockLines_getbuilder,
              builder: (controller) => CustomPaint(
                painter: ClockLinesPainter(
                  hide: controller.isStarted,
                  radius: radius + strokeWidth + 10.r,
                ),
              ),
            ),
          ),
          RepaintBoundary(
            child: GetBuilder<TimerAnimationsController>(
              id: circularLine_getbuilder,
              builder: (controller) => CustomPaint(
                size: customPaintSize,
                painter: CircularLinePainter(
                  radius: radius,
                  strokeWidth: strokeWidth,
                  currentDeg: controller.circularLineDeg,
                ),
              ),
            ),
          ),
          RepaintBoundary(
            child: GetBuilder<RoundedRotationalLinesController>(
              id: roundedRotationalLines_getbuilder,
              builder: (controller) => CustomPaint(
                size: customPaintSize,
                painter: RoundedRotationalLinesPainter(
                  showRotationalLines: controller.isStarted,
                  radius: radius,
                  strokeWidth: strokeWidth,
                  spaceBetweenRotationalLines:
                      controller.spaceBetweenRotationalLinesAnimation * 10.r,
                  rotationalLinesDeg: controller.rotationalLinesDeg,
                ),
              ),
            ),
          ),
          RepaintBoundary(
            child: Container(
              alignment: Alignment.center,
              width: areaSize,
              height: areaSize,
              child: Neumorphic(
                style: const NeumorphicStyle(
                  lightSource: LightSource.left,
                  boxShape: NeumorphicBoxShape.circle(),
                  depth: 2,
                ),
                child: CircleAvatar(
                  radius: radius,
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  child: GetBuilder<TimerAnimationsController>(
                    id: text_getbuilder,
                    builder: (controller) {
                      return TimerText(
                        secondsLeft: controller.remainingSeconds,
                        animateBack: !controller.isTimerStarted,
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
