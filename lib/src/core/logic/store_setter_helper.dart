part of '../../cfb_store_base.dart';

mixin StoreSetterHelper {
  Map<String, Uint8List> get _cacheMap;

  /// ### Put Value
  ///
  /// Supported Type: ***`[int,String,bool,double,Map<String,dynamic>,Uint8List]`***
  void put(String key, dynamic value) {
    if (value is Uint8List) {
      _cacheMap[key] = value;
    } else if (value is Map<String, dynamic>) {
      _cacheMap[key] = CFBaseDataModel(value).toBytes();
    } else if (value is int ||
        value is bool ||
        value is String ||
        value is double) {
      final model = CFBaseDataModel({'value': value});
      _cacheMap[key] = model.toBytes();
    } else {
      throw UnsupportedError('Unpupported Type: ${value.runtimeType}');
    }
  }

  /// ### Custom Class Put
  void putCustomData<T extends CFCustomBaseType>(T data) {
    final key = data.keyName;
    final model = data.toData;

    _cacheMap[key] = model.toBytes();
  }
}
