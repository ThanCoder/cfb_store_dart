part of '../cfb_store_base.dart';

mixin FileRWHandler on ICFBStore {
  set _dbFile(File dbFile);

  @override
  Future<bool> open(String dbPath) async {
    _dbFile = File(dbPath);
    return await _loadAll();
  }

  @override
  Future<bool> writeAll() async {
    try {
      final writer = StorageWriter();
      writer.writeCacheMap(_cacheMap);
      await dbFile.writeAsBytes(writer.toBytes);

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> _loadAll() async {
    try {
      _cacheMap.clear();
      if (!dbFile.existsSync()) return false;
      final bytes = await dbFile.readAsBytes();
      final reader = StorageReader(payload: bytes);
      _cacheMap.addAll(reader.readToCacheMap());

      return true;
    } catch (e) {
      return false;
    }
  }
}
