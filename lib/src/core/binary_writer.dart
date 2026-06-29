// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:typed_data';

import 'package:cfb_store/src/core/types.dart';

class BinaryWriter {
  final _builder = BytesBuilder();

  BinaryWriter();

  Uint8List get toBytes => _builder.toBytes();

  Uint8List _int32ToBytes(int value) {
    final bytes = Uint8List(4);
    ByteData.view(bytes.buffer).setInt32(0, value, Endian.little);
    return bytes;
  }

  Uint8List _int64ToBytes(int value) {
    final bytes = Uint8List(8);
    ByteData.view(bytes.buffer).setInt64(0, value, Endian.little);
    return bytes;
  }

  Uint8List _doubleToBytes(double value) {
    final bytes = Uint8List(8);
    ByteData.view(bytes.buffer).setFloat64(0, value, Endian.little);
    return bytes;
  }

  // 1. အပြင်ကနေ Value သီးသန့်ပဲ သိမ်းချင်ရင် ခေါ်ဖို့ Entry Point အသစ်
  void writeValue(dynamic value) {
    _writeElement(value);
  }

  // 2. လက်ရှိ Map အတွင်း child တွေအတွက် သုံးတဲ့ Key-Value ရေးတဲ့ function
  void write(String key, dynamic value) {
    final keyBytes = utf8.encode(key);
    _builder.add(_int32ToBytes(keyBytes.length));
    _builder.add(keyBytes);

    _writeElement(value);
  }

  // 3. Core logic (အမျိုးအစား ခွဲခြားပြီး bytes ပြောင်းပေးတာ)
  void _writeElement(dynamic value) {
    if (value is bool) {
      _builder.addByte(CFDataType.boolean.value);
      _builder.addByte(value ? 1 : 0);
    } else if (value is int) {
      _builder.addByte(CFDataType.int64.value);
      _builder.add(_int64ToBytes(value));
    } else if (value is double) {
      _builder.addByte(CFDataType.float64.value);
      _builder.add(_doubleToBytes(value));
    } else if (value is String) {
      _builder.addByte(CFDataType.string.value);
      final bytes = utf8.encode(value);
      _builder.add(_int32ToBytes(bytes.length));
      _builder.add(bytes);
    } else if (value is Map) {
      _builder.addByte(CFDataType.map.value);
      _builder.add(_int32ToBytes(value.length));
      value.forEach((k, v) {
        write(
          k.toString(),
          v,
        ); // Map အတွင်းထဲက internal pair တွေမို့ key ပါတွဲရေးတယ်
      });
    } else if (value is List) {
      _builder.addByte(CFDataType.list.value);
      _builder.add(_int32ToBytes(value.length));
      for (final item in value) {
        _writeElement(item); // List element တွေမို့ key မပါဘဲ value ပဲ ရေးတယ်
      }
    } else {
      throw Exception("Unsupported type: ${value.runtimeType}");
    }
  }
}
