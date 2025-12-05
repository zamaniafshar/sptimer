import 'package:flutter_test/flutter_test.dart';
import 'package:sptimer/common/extensions/extensions.dart';

void main() {
  group('DurationX.formatRemainingTime', () {
    test('formats zero seconds correctly', () {
      const duration = Duration(seconds: 0);

      expect(duration.formatRemainingTime, '00:00');
    });

    test('formats duration less than one minute', () {
      const duration = Duration(seconds: 45);

      expect(duration.formatRemainingTime, '00:45');
    });

    test('formats duration of multiple minutes', () {
      const duration = Duration(seconds: 90);

      expect(duration.formatRemainingTime, '01:30');
    });

    test('formats duration with non-zero minutes and seconds', () {
      const duration = Duration(minutes: 5, seconds: 7);

      expect(duration.formatRemainingTime, '05:07');
    });
  });
}
