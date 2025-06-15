import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sptimer/logic/pomodoro_timer/pomodoro_timer_cubit.dart';
import 'package:sptimer/view/pomodoro_timer/widgets/countdown_timer/custom_painters/circular_line_painter.dart';
import 'package:sptimer/common/extensions/extensions.dart';

class CircularLine extends StatelessWidget {
  const CircularLine({
    super.key,
    required this.diameter,
    required this.strokeWidth,
  });

  final double diameter;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return RepaintBoundary(
      child: BlocBuilder<PomodoroTimerCubit, PomodoroTimerState>(
        builder: (context, state) {
          final percent =
              state.remainingDuration.inMilliseconds / state.currentMaxDuration.inMilliseconds;
          final deg = percent * 360;

          return CustomPaint(
            size: Size.square(diameter),
            painter: CircularLinePainter(
              strokeWidth: strokeWidth,
              currentDeg: deg,
              colors: [
                theme.primaryColorLight,
                theme.primaryColor,
                theme.colorScheme.primaryContainer,
              ],
            ),
          );
        },
      ),
    );
  }
}
