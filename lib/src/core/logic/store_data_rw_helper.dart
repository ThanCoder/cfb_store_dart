part of '../../cfb_store_base.dart';

mixin StoreDataRwHelper {
  Map<String, Uint8List> get _cacheMap;
  File get dbFile;

  /// ### Write Data To Disk
  Future<void> writeDisk() async {
    try {
      final builder = BytesBuilder();
      // map length အရင်ထည့်မယ်
      // loop ပတ်လို့ရအောင်
      builder.addInt32(_cacheMap.length);

      _cacheMap.forEach((key, bytes) {
        // data key
        builder.addString32(key);
        // data length
        builder.addInt32(bytes.length);
        builder.add(bytes);
      });

      await dbFile.writeAsBytes(builder.takeBytes());
    } catch (e) {
      print('[StoreDataWriter:writeDisk]: $e');
    }
  }

  Future<void> _readDisk() async {
    try {
      if (!dbFile.existsSync()) return;
      final bytes = await dbFile.readAsBytes();
      if (bytes.isEmpty) return;

      final reader = ByteReader(bytes);
      // map length ရယူမယ်
      final mapLen = reader.readInt32();
      // map loop ပတ်
      for (var i = 0; i < mapLen; i++) {
        final datakey = reader.readString32();
        // data len
        final dataLen = reader.readInt32();
        final dataBytes = reader.readBytes(dataLen);
        // set map
        _cacheMap[datakey] = dataBytes;
      }
    } catch (e) {
      print('[StoreDataWriter:readDisk]: $e');
    }
  }
}
