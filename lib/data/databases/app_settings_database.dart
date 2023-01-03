import 'package:dartz/dartz.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sptimer/data/models/app_settings.dart';

const _settingsKey = '_settingsKey';

class AppSettingsDatabase {
  late Box _settingsBox;

  Future<void> init() async {
    _settingsBox = await Hive.openBox('settingsBox');
  }

  Future<Either<Exception, AppSettings?>> getSettings() async {
    try {
      final map = _settingsBox.get(_settingsKey);
      final settings = map != null ? AppSettings.fromMap(map) : null;
      return Right(settings);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  Future<Either<Exception, bool>> saveSettings(AppSettings settings) async {
    try {
      await _settingsBox.put(_settingsKey, settings.toMap());
      return const Right(true);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }
}
