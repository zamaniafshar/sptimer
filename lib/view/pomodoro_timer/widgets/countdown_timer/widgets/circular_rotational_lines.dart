import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sptimer/data/enums/timer_status.dart';
import 'package:sptimer/data/models/pomodoro_timer_state.dart';
import 'package:sptimer/logic/pomodoro_timer/pomodoro_timer_cubit.dart';
import 'package:sptimer/view/pomodoro_timer/widgets/countdown_timer/custom_painters/circular_rotational_lines_painter.dart';
import 'package:sptimer/common/extensions/extensions.dart';

class CircularRotationalLines extends StatefulWidget {
  const CircularRotationalLines({
    super.key,
    required this.diameter,
  });

  final double diameter;

  @override
  State<CircularRotationalLines> createState() => _CircularRotationalLinesState();
}

class _CircularRotationalLinesState extends State<CircularRotationalLines>
    with TickerProviderStateMixin {
  late final AnimationController rotationalLinesController;
  late final AnimationController spaceBetweenLinesController;
  bool isStarted = false;
  bool reverseAnimation = false;

  @override
  void initState() {
    rotationalLinesController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
      value: 0.0,
    )..addStatusListener(
        (_) => continueAnimation(),
      );

    spaceBetweenLinesController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 750),
    );

    super.initState();
  }

  @override
  void dispose() {
    spaceBetweenLinesController.dispose();
    rotationalLinesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return BlocListener<PomodoroTimerCubit, PomodoroTimerState>(
      listener: timerStateListener,
      child: RepaintBoundary(
        child: AnimatedBuilder(
          animation: Listenable.merge(
            [
              rotationalLinesController,
              spaceBetweenLinesController,
            ],
          ),
          builder: (context, _) => CustomPaint(
            size: Size.square(widget.diameter),
            painter: CircularRotationalLinesPainter(
              repaint: Listenable.merge(
                [
                  rotationalLinesController,
                  spaceBetweenLinesController,
                ],
              ),
              showRotationalLines: isStarted,
              spaceBetweenRotationalLines: spaceBetweenLinesController.value * 10,
              rotationalLinesDeg: rotationalLinesController.value * -360,
              colors: [
                theme.primaryColorLight,
                theme.primaryColor,
                theme.colorScheme.primaryContainer,
              ],
            ),
          ),
        ),
      ),
    );
  }

  void timerStateListener(_, PomodoroTimerState state) {
    if (state.timerStatus.isStarted) {
      startAnimation();
    } else if (state.timerStatus.isPaused) {
      rotationalLinesController.stop();
    } else {
      finishAnimation();
    }
  }

  void startAnimation() {
    isStarted = true;
    rotationalLinesController.forward();
    spaceBetweenLinesController.forward();
  }

  Future<void> finishAnimation() async {
    reverseAnimation = true;
    rotationalLinesController.animateBack(
      0.0,
      duration: const Duration(milliseconds: 400),
    );
    await spaceBetweenLinesController.reverse(from: 1.0);
    isStarted = false;
    reverseAnimation = false;
    setState(() {});
  }

  void continueAnimation() {
    if (!isStarted) return;
    if (reverseAnimation) {
      _reverseRotationalLinesAnimation();
    } else {
      _forwardRotationalLinesAnimation();
    }
  }

  void _reverseRotationalLinesAnimation() {
    if (rotationalLinesController.status == AnimationStatus.dismissed) {
      rotationalLinesController.value = 1.0;
      rotationalLinesController.animateBack(
        0.0,
        duration: const Duration(milliseconds: 400),
      );
    }
  }

  void _forwardRotationalLinesAnimation() {
    if (rotationalLinesController.status == AnimationStatus.completed) {
      rotationalLinesController.forward(from: 0.0);
    }
  }
}
