import 'dart:convert';
import 'dart:typed_data';

class StorageWriter {
  final _builder = BytesBuilder();

  Uint8List get toBytes => _builder.toBytes();

  // _cacheMap ထဲက ကောင်တွေကို single binary payload ဖြစ်အောင် စုစည်းပေးမယ့် function
  void writeCacheMap(Map<String, Uint8List> cacheMap) {
    cacheMap.forEach((key, valueBytes) {
      // ၁။ Key ကို encode လုပ်မယ်
      final keyBytes = utf8.encode(key);

      // ၂။ Key Length (Int32) နဲ့ Key Bytes ကို ထည့်မယ်
      _writeInt32(keyBytes.length);
      _builder.add(keyBytes);

      // ၃။ Value Bytes ရဲ့ Length (Int32) နဲ့ တကယ့် Value Bytes ကို ထည့်မယ်
      _writeInt32(valueBytes.length);
      _builder.add(valueBytes);
    });
  }

  void _writeInt32(int value) {
    final bytes = Uint8List(4);
    ByteData.view(bytes.buffer).setInt32(0, value, Endian.little);
    _builder.add(bytes);
  }
}

class StorageReader {
  final Uint8List _payload;
  late final ByteData _byteData;
  int _offset = 0;

  StorageReader({required this._payload}) {
    _byteData = ByteData.view(
      _payload.buffer,
      _payload.offsetInBytes,
      _payload.lengthInBytes,
    );
  }

  // ဖိုင်ထဲက bytes တွေကို ဖတ်ပြီး Map<String, Uint8List> အဖြစ် ပြန်ပြောင်းပေးမယ့် function
  Map<String, Uint8List> readToCacheMap() {
    final Map<String, Uint8List> cacheMap = {};
    _offset = 0;

    while (_offset < _payload.length) {
      // ၁။ Key ကို ဖြတ်ဖတ်မယ်
      final keyLength = _byteData.getInt32(_offset, Endian.little);
      _offset += 4;
      final keyBytes = _payload.sublist(_offset, _offset + keyLength);
      _offset += keyLength;
      final key = utf8.decode(keyBytes);

      // ၂။ Value Bytes ကို ဖြတ်ဖတ်မယ်
      final valueLength = _byteData.getInt32(_offset, Endian.little);
      _offset += 4;
      final valueBytes = _payload.sublist(_offset, _offset + valueLength);
      _offset += valueLength;

      // ၃။ Cache map ထဲ ထည့်မယ်
      cacheMap[key] = valueBytes;
    }

    return cacheMap;
  }
}
