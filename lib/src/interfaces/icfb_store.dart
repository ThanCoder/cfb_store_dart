import 'dart:typed_data';

abstract class ICFBStore {
  Map<String, Uint8List> get cacheMap;
  String get path;
  void put(String key, dynamic value);
  dynamic get(String key);
  Future<void> writeAll();
}
