// ignore_for_file: sort_constructors_first

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
