import 'controller/circular_rotational_lines_controller.dart';
import 'constants.dart';

class CountdownTimerController extends CircularRotationalLinesController {
  CountdownTimerController({
    String? gradientText,
    double circularLineDeg = 0.0,
    Duration timerDuration = Duration.zero,
  })  : _circularLineDeg = circularLineDeg,
        _timerDuration = timerDuration;

  String? _gradientText;
  double _circularLineDeg;
  Duration _timerDuration;

  String? get gradientText => _gradientText;
  double get circularLineDeg => _circularLineDeg;
  Duration get timerDuration => _timerDuration;

  set gradientText(String? text) {
    _gradientText = text;
    update([kGradientText_getbuilder]);
  }

  set circularLineDeg(double value) {
    _circularLineDeg = value;
    update([kCircularLine_getbuilder]);
  }

  set timerDuration(Duration value) {
    _timerDuration = value;
    update([kCountdownText_getbuilder]);
  }
}
