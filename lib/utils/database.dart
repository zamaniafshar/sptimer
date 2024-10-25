import 'package:hive/hive.dart';

final class Database {
  static Future<Database> open(String name) async {
    final box = await Hive.openLazyBox(name);
    return Database._(box);
  }

  Database._(this._box);

  final LazyBox _box;

  int get length => _box.length;
  Iterable get keys => _box.keys;

  Future<void> save(dynamic key, dynamic value) async {
    await _box.put(key, value);
  }

  Future<void> saveAll(
    List<MapEntry> entries,
  ) async {
    await _box.putAll(
      Map.fromEntries(entries),
    );
  }

  Future<void> update(dynamic key, dynamic value) async {
    await _box.put(key, value);
  }

  Future<dynamic> get(dynamic key) async {
    final value = await _box.get(key);
    if (value == null) return null;
    return DatabaseMapCaster.castMapValues(value);
  }

  Future<List<dynamic>> getAll() {
    final values = _box.keys.map(
      (key) => get(key).then((value) => value!),
    );
    return Future.wait(values);
  }

  Future<void> delete(dynamic key) async {
    await _box.delete(key);
  }

  Future<void> deleteAt(int index) async {
    await _box.deleteAt(index);
  }

  Future<void> deleteAll() async {
    await _box.clear();
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
    Map<String, dynamic> castedMap = {};

    for (MapEntry entry in map.entries) {
      castedMap[entry.key as String] = castMapValues(entry.value);
    }

    return castedMap;
  }
}
