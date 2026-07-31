part of '../cfb_store_base.dart';

mixin FileRWHandler on ICFBStore {
  set _dbFile(File dbFile);

  @override
  Future<bool> open(String dbPath) async {
    _dbFile = File(dbPath);
    return await _loadAll();
  }

  @override
  bool openSync(String dbPath) {
    _dbFile = File(dbPath);
    return _loadAllSync();
  }

  @override
  Future<bool> writeAll() async {
    try {
      final writer = StorageWriter();
      writer.writeCacheMap(_cacheMap);
      await dbFile.writeAsBytes(writer.toBytes);
      _addEvent(ValueSaved());
      return true;
    } catch (e) {
      _addEvent(ValueSaveError(e.toString()));
      return false;
    }
  }

  @override
  bool writeAllSync() {
    try {
      final writer = StorageWriter();
      writer.writeCacheMap(_cacheMap);
      dbFile.writeAsBytesSync(writer.toBytes);
      _addEvent(ValueSaved());
      return true;
    } catch (e) {
      _addEvent(ValueSaveError(e.toString()));
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
      _addEvent(ValueLoaded());
      return true;
    } catch (e) {
      _addEvent(ValueLoadError(e.toString()));
      return false;
    }
  }

  bool _loadAllSync() {
    try {
      _cacheMap.clear();
      if (!dbFile.existsSync()) return false;
      final bytes = dbFile.readAsBytesSync();
      final reader = StorageReader(payload: bytes);
      _cacheMap.addAll(reader.readToCacheMap());
      _addEvent(ValueLoaded());
      return true;
    } catch (e) {
      _addEvent(ValueLoadError(e.toString()));
      return false;
    }
  }
}
