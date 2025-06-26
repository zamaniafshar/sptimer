// ignore_for_file: sort_constructors_first

import 'package:hive/hive.dart';
import 'package:sptimer/common/error/errors.dart';

class Database<T> {
  static Future<Database<T>> create<T>(String name) async {
    final box = await Hive.openLazyBox<T>(name);

    return Database._(box);
  }

  Database._(this._box);

  final LazyBox<T> _box;

  int get length {
    return _box.length;
  }

  Future<void> save(key, value) async {
    try {
      await _box.put(key, value);
    } catch (e) {
      throw DatabaseError.fromError(e);
    }
  }

  void saveWithAutoKey(value) async {
    try {
      await _box.add(value);
    } catch (e) {
      throw DatabaseError.fromError(e);
    }
  }

  void saveAll(Map<dynamic, T> entries) async {
    try {
      await _box.putAll(entries);
    } catch (e) {
      throw DatabaseError.fromError(e);
    }
  }

  void update(key, value) async {
    try {
      await _box.put(key, value);
    } catch (e) {
      throw DatabaseError.fromError(e);
    }
  }

  Future<T?> get(key) async {
    try {
      return _box.get(key);
    } catch (e) {
      throw DatabaseError.fromError(e);
    }
  }

  Iterable<Future<T?>> getAll() {
    try {
      return _box.keys.map(
        (key) {
          return _box.get(key);
        },
      );
    } catch (e) {
      throw DatabaseError.fromError(e);
    }
  }

  Iterable<Future<T?>> getAllReversed() {
    try {
      return _box.keys.toList().reversed.map(
        (key) async {
          return _box.get(key);
        },
      );
    } catch (e) {
      throw DatabaseError.fromError(e);
    }
  }

  Future<void> delete(key) async {
    try {
      await _box.delete(key);
    } catch (e) {
      throw DatabaseError.fromError(e);
    }
  }

  Future<void> deleteAt(int index) async {
    try {
      await _box.deleteAt(index);
    } catch (e) {
      throw DatabaseError.fromError(e);
    }
  }

  Future<void> deleteAll() async {
    try {
      await _box.clear();
    } catch (e) {
      throw DatabaseError.fromError(e);
    }
  }

  bool containKey(key) {
    try {
      return _box.containsKey(key);
    } catch (e) {
      throw DatabaseError.fromError(e);
    }
  }
}

abstract final class DatabaseMapCaster {
  static dynamic castMapValues(dynamic value) {
    if (value is Map) {
      return _castMap(value);
    } else if (value is List) {
      return _castList(value);
    } else {
      return value;
    }
  }

  static List _castList(List list) {
    return list.map(castMapValues).toList();
  }

  static Map<String, dynamic> _castMap(Map map) {
    final Map<String, dynamic> castedMap = {};

    for (MapEntry entry in map.entries) {
      castedMap[entry.key as String] = castMapValues(entry.value);
    }

    return castedMap;
  }
}

final class DatabaseError extends AppError {
  DatabaseError(super.message);

  factory DatabaseError.fromError(Object? e) {
    return e is DatabaseError ? e : DatabaseError(e.toString());
  }
}
