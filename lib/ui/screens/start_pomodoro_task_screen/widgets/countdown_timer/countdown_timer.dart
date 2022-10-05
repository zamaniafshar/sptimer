import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'controller/countdown_timer_controller.dart';
import 'constants.dart';
import 'custom_painters/circular_line_painter.dart';
import 'custom_painters/clock_lines_painter.dart';
import 'custom_painters/circular_background_line_painter.dart';
import 'custom_painters/circular_rotational_lines_painter.dart';
import 'widgets/countdown_timer_text.dart';
import 'widgets/gradient_text.dart';

class CountdownTimer extends StatelessWidget {
  const CountdownTimer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double radius = 90.r;
    final double strokeWidth = 25.r;
    final double areaSize = radius * 2 + strokeWidth;
    final Size customPaintSize = Size.square(areaSize);
    final theme = Theme.of(context);
    final colors = [
      theme.primaryColorLight,
      theme.cardColor,
      theme.primaryColor,
      theme.colorScheme.primaryContainer,
    ];

    return SizedBox(
      width: areaSize,
      height: areaSize,
      child: Stack(
        alignment: Alignment.center,
        children: [
          RepaintBoundary(
            child: CustomPaint(
              painter: CircularBackgroundLinePainter(
                radius: radius,
                strokeWidth: strokeWidth,
                backgroundColor: theme.primaryColorLight.withOpacity(0.1),
                shadowColor: theme.primaryColorDark.withOpacity(0.3),
              ),
            ),
          ),
          RepaintBoundary(
            child: GetBuilder<CountdownTimerController>(
              id: kClockLines_getbuilder,
              builder: (controller) => CustomPaint(
                painter: ClockLinesPainter(
                  hide: controller.isStarted,
                  radius: radius + strokeWidth + 10.r,
                  colors: colors,
                ),
              ),
            ),
          ),
          RepaintBoundary(
            child: GetBuilder<CountdownTimerController>(
              id: kCircularLine_getbuilder,
              builder: (controller) => CustomPaint(
                size: customPaintSize,
                painter: CircularLinePainter(
                  radius: radius,
                  strokeWidth: strokeWidth,
                  currentDeg: controller.circularLineDeg,
                  colors: colors,
                ),
              ),
            ),
          ),
          RepaintBoundary(
            child: GetBuilder<CountdownTimerController>(
              id: kCircularRotationalLines_getbuilder,
              builder: (controller) => CustomPaint(
                size: customPaintSize,
                painter: CircularRotationalLinesPainter(
                  showRotationalLines: controller.isStarted,
                  radius: radius,
                  strokeWidth: strokeWidth,
                  spaceBetweenRotationalLines: controller.spaceBetweenRotationalLines * 10.r,
                  rotationalLinesDeg: controller.circularLinesDeg,
                  colors: colors,
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GetBuilder<CountdownTimerController>(
                        id: kCountdownText_getbuilder,
                        builder: (controller) {
                          return CountdownTimerText(
                            remainingDuration: controller.timerDuration,
                            animateBack: !controller.isStarted,
                          );
                        },
                      ),
                      GetBuilder<CountdownTimerController>(
                        id: kGradientText_getbuilder,
                        builder: (controller) {
                          return controller.gradientText != null
                              ? GradientText(controller.gradientText!)
                              : const SizedBox();
                        },
                      ),
                    ],
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
