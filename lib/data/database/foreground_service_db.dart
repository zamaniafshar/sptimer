import 'package:hive/hive.dart';

const _isForegroundServiceStartedKey = 'isForegroundServiceStarted';

class ForegroundServiceDB {
  Future<void> init() async {
    _box = await Hive.openBox('foregroundServiceDB');
  }

  late Box _box;

  bool get isForegroundServiceStarted =>
      _box.get(_isForegroundServiceStartedKey, defaultValue: false);

  Future<void> saveState(bool isStarted) async {
    await _box.put(_isForegroundServiceStartedKey, isStarted);
  }
}
