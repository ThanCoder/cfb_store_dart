import 'dart:convert';
import 'dart:typed_data';

import 'package:cfb_store/src/core/types.dart'; // CFDataType အတွက် လိုအပ်ပါက import ထားပါ

class BlockReader {
  final Uint8List _payload;
  late final ByteData _byteData;
  int _offset = 0;
  final Map<String, dynamic> _map = {};
  Map<String, dynamic> get data => _map;

  BlockReader({required this._payload}) {
    _byteData = ByteData.view(
      _payload.buffer,
      _payload.offsetInBytes,
      _payload.lengthInBytes,
    );
    _decodeAll();
  }
  void _decodeAll() {
    // တစ်ဖိုင်လုံးမှာရှိသမျှ key-value structure အားလုံးကို loop ပတ်ဖတ်ပြီး _map ထဲ စုမယ်
    while (_offset < _payload.length) {
      final key = _readKey(); // Key ကို အရင်ဖတ်မယ်
      final value = _readElement(); // Value (Type + Data) ကို ဆက်ဖတ်မယ်
      _map[key] = value;
    }
  }

  // အပြင်ကနေ တိုက်ရိုက် လှမ်းခေါ်ပြီး value ထုတ်မယ့် Entry Point
  dynamic readValue() {
    _offset = 0; // စဖွင့်ချင်း offset 0 ကစဖတ်မယ်
    return _readElement();
  }

  // Key အတွက် သီးသန့်ဖတ်တဲ့ Helper
  String _readKey() {
    final length = _byteData.getInt32(_offset, Endian.little);
    _offset += 4;
    final keyBytes = _payload.sublist(_offset, _offset + length);
    _offset += length;
    return utf8.decode(keyBytes);
  }

  // Core Read Logic
  dynamic _readElement() {
    final typeValue = _byteData.getUint8(_offset);
    _offset += 1;

    final type = CFDataType.getNumber(typeValue);

    switch (type) {
      case CFDataType.boolean:
        final value = _byteData.getUint8(_offset) == 1;
        _offset += 1;
        return value;
      case CFDataType.int64:
        final value = _byteData.getInt64(_offset, Endian.little);
        _offset += 8;
        return value;
      case CFDataType.float64:
        final value = _byteData.getFloat64(_offset, Endian.little);
        _offset += 8;
        return value;
      case CFDataType.string:
        final length = _byteData.getInt32(_offset, Endian.little);
        _offset += 4;
        final bytes = _payload.sublist(_offset, _offset + length);
        _offset += length;
        return utf8.decode(bytes);
      case CFDataType.map:
        final mapLength = _byteData.getInt32(_offset, Endian.little);
        _offset += 4;
        final Map<String, dynamic> nestedMap = {};
        for (int i = 0; i < mapLength; i++) {
          final k = _readKey(); // Map key ကိုဖတ်မယ်
          final v = _readElement(); // Map value ကိုဖတ်မယ်
          nestedMap[k] = v;
        }
        return nestedMap;
      case CFDataType.list:
        final listLength = _byteData.getInt32(_offset, Endian.little);
        _offset += 4;
        final List<dynamic> nestedList = [];
        for (int i = 0; i < listLength; i++) {
          nestedList.add(_readElement()); // List element တွေကို ဖတ်မယ်
        }
        return nestedList;
    }
  }
}
