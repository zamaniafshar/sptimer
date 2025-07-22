// ignore_for_file: sort_constructors_first

import 'dart:async';
import 'package:hive_ce/hive.dart';
import 'package:sptimer/common/database/database.dart';

abstract final class DatabaseFactory {
  static Future<SimpleDatabase> createSimpleDB() async {
    const name = 'simple_db';
    final box = await Hive.openBox(name);
    return SimpleDatabase(box);
  }

  static Future<AdvancedDatabase> createAdvanced(String name) async {
    final box = await Hive.openLazyBox(name);
    return AdvancedDatabase(box);
  }
}
