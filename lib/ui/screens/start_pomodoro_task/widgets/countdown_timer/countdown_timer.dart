import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sptimer/controller/app_settings_controller.dart';
import 'package:sptimer/ui/screens/start_pomodoro_task/widgets/countdown_timer/controller/circular_rotational_lines_controller.dart';
import 'package:sptimer/ui/screens/start_pomodoro_task/widgets/countdown_timer/controller/timer_animations_controller.dart';
import 'controller/countdown_timer_controller.dart';
import 'constants.dart';
import 'custom_painters/circular_line_painter.dart';
import 'custom_painters/clock_lines_painter.dart';
import 'custom_painters/circular_background_line_painter.dart';
import 'custom_painters/circular_rotational_lines_painter.dart';
import '../animated_text_style.dart';
import 'widgets/countdown_timer_text.dart';

class CountdownTimer extends StatelessWidget {
  CountdownTimer({
    Key? key,
  }) : super(key: key);

  final appSettings = Get.find<AppSettingsController>();

  @override
  Widget build(BuildContext context) {
    final double radius = 90.r;
    final double strokeWidth = 25.r;
    final double areaSize = radius * 2 + strokeWidth;
    final Size customPaintSize = Size.square(areaSize);
    final theme = Theme.of(context);
    final colors = [
      theme.primaryColorLight,
      theme.primaryColor,
      theme.colorScheme.primaryContainer,
    ];

    return SizedBox(
      width: areaSize,
      height: areaSize,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          RepaintBoundary(
            child: CustomPaint(
              painter: CircularBackgroundLinePainter(
                radius: radius,
                strokeWidth: strokeWidth,
                backgroundColor: theme.primaryColorLight.withOpacity(0.1),
                shadowColor: theme.primaryColorDark.withOpacity(0.5),
              ),
            ),
          ),
          RepaintBoundary(
            child: GetBuilder<CircularRotationalLinesController>(
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
            child: GetBuilder<TimerAnimationsController>(
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
            child: GetBuilder<CircularRotationalLinesController>(
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
              alignment: AlignmentDirectional.center,
              width: areaSize,
              height: areaSize,
              child: Neumorphic(
                style: NeumorphicStyle(
                  lightSource: LightSource.topLeft,
                  boxShape: const NeumorphicBoxShape.circle(),
                  depth: 15,
                  intensity: 0.75,
                  color: Colors.transparent,
                  shadowDarkColor: theme.shadowColor.withOpacity(0.5),
                  shadowLightColor: theme.colorScheme.shadow.withOpacity(0.8),
                ),
                child: CircleAvatar(
                  radius: radius,
                  backgroundColor:
                      appSettings.isDarkTheme ? Colors.transparent : theme.colorScheme.surface,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: GetBuilder<TimerAnimationsController>(
                          id: kCountdownText_getbuilder,
                          builder: (controller) {
                            return CountdownTimerText(
                              remainingDuration: controller.remainingDuration,
                              animateBack: controller.animateBack,
                            );
                          },
                        ),
                      ),
                      GetBuilder<CountdownTimerController>(
                        id: kSubtitleText_getbuilder,
                        builder: (controller) {
                          return AnimatedTextStyle(
                            text: controller.subtitleText,
                            textStyle: const TextStyle(fontSize: 0, inherit: false),
                            secondTextStyle: theme.primaryTextTheme.bodyMedium!,
                          );
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
