import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sptimer/data/enums/timer_status.dart';
import 'package:sptimer/logic/pomodoro_timer/pomodoro_timer_cubit.dart';
import 'package:sptimer/screens/pomodoro_timer/widgets/countdown_timer/custom_painters/circular_rotational_lines_painter.dart';
import 'package:sptimer/utils/extensions/extensions.dart';

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
      duration: const Duration(milliseconds: 500),
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

    return RepaintBoundary(
      child: BlocListener<PomodoroTimerCubit, PomodoroTimerState>(
        listener: timerStateListener,
        child: BlocSelector<PomodoroTimerCubit, PomodoroTimerState, TimerStatus>(
          selector: (state) => state.timerStatus,
          builder: (context, timerStatus) {
            return CustomPaint(
              size: Size.square(widget.diameter),
              painter: CircularRotationalLinesPainter(
                repaint: Listenable.merge(
                  [
                    rotationalLinesController,
                    spaceBetweenLinesController,
                  ],
                ),
                showRotationalLines: !timerStatus.isFinished,
                spaceBetweenRotationalLines: spaceBetweenLinesController.value * 10,
                rotationalLinesDeg: rotationalLinesController.value * -360,
                colors: [
                  theme.primaryColorLight,
                  theme.primaryColor,
                  theme.colorScheme.primaryContainer,
                ],
              ),
            );
          },
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
    rotationalLinesController.forward();
    spaceBetweenLinesController.forward();
  }

  Future<void> finishAnimation() async {
    rotationalLinesController.animateBack(
      0.0,
      duration: const Duration(milliseconds: 500),
    );
    await spaceBetweenLinesController.reverse(from: 1.0);
  }

  void continueAnimation() {
    _forwardRotationalLinesAnimation();
  }

  void _reverseRotationalLinesAnimation() {
    if (rotationalLinesController.status == AnimationStatus.dismissed) {
      rotationalLinesController.forward(from: 1.0);
    }
  }

  void _forwardRotationalLinesAnimation() {
    if (rotationalLinesController.status == AnimationStatus.completed) {
      rotationalLinesController.forward(from: 0.0);
    }
  }
}
