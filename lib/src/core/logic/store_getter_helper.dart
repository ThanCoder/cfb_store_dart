part of '../../cfb_store_base.dart';

mixin StoreGetterHelper {
  Map<String, Uint8List> get _cacheMap;
  Map<Type, CFCutomBaseAdapter<CFCustomBaseType>> get _adapterCache;

  /// ### String Value
  String getString(String key, [String defaultValue = '']) {
    final val = _cacheMap[key];
    if (val != null) {
      final map = ByteReader(val).readMap();
      if (map['value'] is String) {
        return map['value'] as String;
      }
    }
    return defaultValue;
  }

  /// ### Int Value
  int getInt(String key, [int defaultValue = 0]) {
    final val = _cacheMap[key];
    if (val != null) {
      final map = ByteReader(val).readMap();
      if (map['value'] is int) {
        return map['value'] as int;
      }
    }
    return defaultValue;
  }

  /// ### Double Or Float Value
  double getDouble(String key, [double defaultValue = 0.0]) {
    final val = _cacheMap[key];
    if (val != null) {
      final map = ByteReader(val).readMap();
      if (map['value'] is double) {
        return map['value'] as double;
      }
    }
    return defaultValue;
  }

  /// ### Bool Value
  bool getBool(String key, [bool defaultValue = false]) {
    final val = _cacheMap[key];
    if (val != null) {
      final map = ByteReader(val).readMap();
      if (map['value'] is bool) {
        return map['value'] as bool;
      }
    }
    return defaultValue;
  }

  /// ### Get Custom Class Type
  T? getCustom<T extends CFCustomBaseType>(String keyName) {
    final data = _cacheMap[keyName];
    if (data == null) return null;

    final adapter = _adapterCache[T];
    if (adapter != null) {
      return adapter.fromData(CFBaseDataModel({})) as T;
    }
    print("Warning: No adapter found for type $T");
    return null;
  }

  Map<String, Uint8List> get cacheMap => _cacheMap;
}
