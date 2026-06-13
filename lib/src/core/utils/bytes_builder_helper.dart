import 'dart:convert';
import 'dart:typed_data';

extension BytesBuilderHelper on BytesBuilder {
  /// ### int (4 Bytes)
  void addInt32(int value) {
    final bytes = ByteData(4)..setInt32(0, value, Endian.little);
    add(bytes.buffer.asUint8List());
  }

  /// ### String length(4 Bytes) + String(N bytes)
  void addString32(String value) {
    final stringBytes = utf8.encode(value);
    final lengBytes = ByteData(4)
      ..setInt32(0, stringBytes.length, Endian.little);
    add(lengBytes.buffer.asUint8List());
    add(stringBytes);
  }

  /// ### int (4 Bytes)
  void addFloat32(double value) {
    final bytes = ByteData(4)..setFloat32(0, value, Endian.little);
    add(bytes.buffer.asUint8List());
  }

  /// bool (1 bytes)
  void addBool(bool value) {
    addByte(value ? 1 : 0);
  }
}
