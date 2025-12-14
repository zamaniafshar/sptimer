// ignore_for_file: sort_constructors_first

import 'dart:async';

import 'package:hive_ce/hive.dart';
import 'package:sptimer/common/database/database_error.dart';
import 'package:sptimer/common/database/database_map_caster.dart';
import 'package:sptimer/common/error/errors.dart';

final class SimpleDatabase extends Database {
  SimpleDatabase(this._box);

  @override
  final Box _box;

  @override
  Object? get(key) {
    try {
      final value = _box.get(key);
      return DatabaseMapCaster.castMapValues(value);
    } catch (e) {
      throw DatabaseError.fromError(e);
    }
  }
}

final class AdvancedDatabase<T> extends Database<T> {
  AdvancedDatabase(this._box);

  @override
  final LazyBox<T> _box;

  @override
  Future<T?> get(key) async {
    try {
      final value = await _box.get(key);
      return DatabaseMapCaster.castMapValues(value);
    } catch (e) {
      throw DatabaseError.fromError(e);
    }
  }

  Iterable<FutureOr<T?>> getAll() {
    return _box.keys.map(
      (key) {
        return get(key);
      },
    );
  }

  Iterable<Future<T?>> getAllReversed() {
    return _box.keys.toList().reversed.map(
      (key) async {
        return get(key);
      },
    );
  }
}

abstract base class Database<T> {
  BoxBase<T> get _box;

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

  dynamic get(key);

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
