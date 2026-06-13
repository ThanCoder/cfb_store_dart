import 'dart:typed_data';

import 'package:cfb_store/src/core/base.dart';
import 'package:cfb_store/src/core/utils/byte_reader.dart';
import 'package:cfb_store/src/core/utils/bytes_builder_helper.dart';

class CFBaseDataModel {
  final Map<String, dynamic> _map;
  const CFBaseDataModel(this._map);

  /// get int
  int getInt(String key, [int defaultValue = 0]) =>
      _map[key] == null ? defaultValue : _map[key] as int;

  /// get string
  String getString(String key, [String defaultValue = ""]) =>
      _map[key] == null ? defaultValue : _map[key] as String;

  T? getCustom<T extends CFCustomBaseType>(
    String key,
    CFCutomBaseAdapter<T> adapter,
  ) {
    final innerMap = _map[key];
    if (innerMap is Map<String, dynamic>) {
      return adapter.fromData(CFBaseDataModel(innerMap));
    }
    return null;
  }

  factory CFBaseDataModel.fromBytes(Uint8List bytes) {
    final reader = ByteReader(bytes);
    return CFBaseDataModel(reader.readMap());
  }

  Uint8List toBytes() {
    final builder = BytesBuilder();
    // map length ကို အရင်သိမ်းမယ်
    // ဒါမှ ပြန်ဖတ်ရင် map length နဲ့ loop ပတ်ရမှာ
    builder.addInt32(_map.length);

    _map.forEach((key, value) {
      // key အရင်သိမ်းမယ်
      builder.addString32(key);

      // value သိမ်းမယ်
      // value flag တွေက လည်းအရေးကြီးတယ်
      // ပြန်ထုတ်ရင် အဲဒီ flag နဲ့ ထုတ်ရမှာ
      if (value is bool) {
        builder.addByte(CFDataType.boolean.value);
        builder.addBool(value);
      } else if (value is int) {
        builder.addByte(CFDataType.int32.value);
        builder.addInt32(value);
      } else if (value is double) {
        builder.addByte(CFDataType.float32.value);
        builder.addFloat32(value);
      } else if (value is String) {
        builder.addByte(CFDataType.string.value);
        builder.addString32(value);
      } else if (value is Map<String, dynamic>) {
        builder.addByte(CFDataType.map.value);
        final nestBytes = CFBaseDataModel(value).toBytes();
        builder.addInt32(nestBytes.length);
        builder.add(nestBytes);
      }
    });
    return builder.takeBytes();
  }
}
