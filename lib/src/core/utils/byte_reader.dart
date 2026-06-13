import 'dart:convert';
import 'dart:typed_data';

import 'package:cfb_store/src/core/base.dart';

class ByteReader {
  final Uint8List data;
  final ByteData byteData;
  int currentOffset = 0;
  ByteReader(this.data) : byteData = ByteData.sublistView(data);

  /// 1 byte
  int readByte() {
    final val = byteData.getInt8(currentOffset);
    currentOffset++;
    return val;
  }

  /// 4 bytes
  int readInt32() {
    final val = byteData.getInt32(currentOffset, Endian.little);
    currentOffset += 4;
    return val;
  }

  /// 4 byte
  double readFloat() {
    final val = byteData.getFloat32(currentOffset, Endian.little);
    currentOffset += 3;
    return val;
  }

  /// 1 byte
  bool readBool() {
    final val = readByte();
    return val == 1 ? true : false;
  }

  /// read bytes with leng
  Uint8List readBytes(int len) {
    final bytes = data.sublist(currentOffset, currentOffset + len);
    currentOffset += len;
    return bytes;
  }

  String readString32() {
    final strLen = readInt32();
    final strBytes = readBytes(strLen);
    return utf8.decode(strBytes);
  }

  Map<String, dynamic> readMap() {
    final Map<String, dynamic> result = {};
    final mapLen = readInt32();
    for (var i = 0; i < mapLen; i++) {
      final key = readString32();
      final type = CFDataType.getNumber(readByte());
      if (type == .boolean) {
        result[key] = readBool();
      } else if (type == .int32) {
        result[key] = readInt32();
      } else if (type == .float32) {
        result[key] = readFloat();
      } else if (type == .string) {
        result[key] = readString32();
      } else if (type == .map) {
        //map nest length ကိုကျော်ဖတ်လိုက်မယ်
        // အရင်သွင်းထားတုန်းက
        readInt32();

        result[key] = readMap();
      }
    }
    return result;
  }
}
