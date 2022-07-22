import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'countdown_timer_controller.dart';
import 'controller/rounded_rotational_lines_controller.dart';
import 'controller/timer_animations_controller.dart';
import 'constants.dart';
import 'custom_painters/circular_line_painter.dart';
import 'custom_painters/clock_lines_painter.dart';
import 'custom_painters/rounded_background_line_painter.dart';
import 'custom_painters/rounded_rotational_lines_painter.dart';
import 'widgets/countdown_timer_text.dart';

class CountdownTimer extends StatelessWidget {
  const CountdownTimer({
    required this.countdownTimerController,
    Key? key,
  }) : super(key: key);

  final CountdownTimerController countdownTimerController;

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
              global: false,
              id: clockLines_getbuilder,
              init: countdownTimerController.roundedRotationalLinesController,
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
              global: false,
              id: circularLine_getbuilder,
              init: countdownTimerController.timerAnimationsController,
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
              global: false,
              id: roundedRotationalLines_getbuilder,
              init: countdownTimerController.roundedRotationalLinesController,
              builder: (controller) => CustomPaint(
                size: customPaintSize,
                painter: RoundedRotationalLinesPainter(
                  showRotationalLines: controller.isStarted,
                  radius: radius,
                  strokeWidth: strokeWidth,
                  spaceBetweenRotationalLines:
                      controller.spaceBetweenRotationalLines * 10.r,
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
                    global: false,
                    id: text_getbuilder,
                    init: countdownTimerController.timerAnimationsController,
                    builder: (controller) {
                      return CountdownTimerText(
                        remainingDuration: controller.remainingDuration,
                        // TODO: refactor it
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
