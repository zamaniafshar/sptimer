import 'package:uuid/uuid.dart';

abstract final class IdGenerator {
  static const _uudi = Uuid();

  static String generate() {
    return _uudi.v4();
  }
}
