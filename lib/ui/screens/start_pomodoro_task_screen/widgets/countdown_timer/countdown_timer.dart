import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pomotimer/ui/screens/start_pomodoro_task_screen/widgets/countdown_timer/controller/circular_rotational_lines_controller.dart';
import 'package:pomotimer/ui/screens/start_pomodoro_task_screen/widgets/countdown_timer/controller/timer_animations_controller.dart';
import 'controller/countdown_timer_controller.dart';
import 'constants.dart';
import 'custom_painters/circular_line_painter.dart';
import 'custom_painters/clock_lines_painter.dart';
import 'custom_painters/circular_background_line_painter.dart';
import 'custom_painters/circular_rotational_lines_painter.dart';
import 'widgets/countdown_timer_text.dart';

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
                      GetBuilder<TimerAnimationsController>(
                        id: kCountdownText_getbuilder,
                        builder: (controller) {
                          return CountdownTimerText(
                            remainingDuration: controller.remainingDuration,
                            animateBack: controller.animateBack,
                          );
                        },
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

class AnimatedTextStyle extends StatefulWidget {
  const AnimatedTextStyle({
    Key? key,
    required this.text,
    required this.textStyle,
    required this.secondTextStyle,
  }) : super(key: key);

  final String? text;
  final TextStyle textStyle;
  final TextStyle secondTextStyle;

  @override
  State<AnimatedTextStyle> createState() => _AnimatedTextStyleState();
}

class _AnimatedTextStyleState extends State<AnimatedTextStyle> with SingleTickerProviderStateMixin {
  String? text;
  late final AnimationController controller;

  @override
  void initState() {
    text = widget.text;
    controller = AnimationController(
      vsync: this,
      value: text != null ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 500),
    );

    super.initState();
  }

  @override
  void didUpdateWidget(covariant AnimatedTextStyle oldWidget) {
    if (widget.text != oldWidget.text) {
      if (widget.text != null) {
        text = widget.text;
        controller.forward();
      } else {
        controller.reverse().then((value) => text = null);
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) {
        return Text(
          text ?? '',
          style: TextStyle.lerp(
            widget.textStyle,
            widget.secondTextStyle,
            controller.value,
          ),
        );
      },
    );
  }
}
