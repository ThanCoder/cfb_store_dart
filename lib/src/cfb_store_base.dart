import 'dart:io';
import 'dart:typed_data';

import 'package:cfb_store/src/core/base.dart';
import 'package:cfb_store/src/core/utils/byte_reader.dart';
import 'package:cfb_store/src/core/utils/bytes_builder_helper.dart';
import 'package:cfb_store/src/core/utils/cf_data_model_base.dart';

part 'core/logic/store_getter_helper.dart';
part 'core/logic/store_data_rw_helper.dart';
part 'core/logic/store_setter_helper.dart';

class CFBStoreBase
    with StoreGetterHelper, StoreDataRwHelper, StoreSetterHelper {
  // Cache Memory
  @override
  final Map<String, Uint8List> _cacheMap = {};
  @override
  final Map<Type, CFCutomBaseAdapter<CFCustomBaseType>> _adapterCache = {};
  late File _dbFile;
  // store writter
  @override
  File get dbFile => _dbFile;

  /// ### Register Custom Type
  void register<T extends CFCustomBaseType>(CFCutomBaseAdapter<T> adapter) {
    _adapterCache[T] = adapter;
  }

  /// ### Init Store
  Future<void> openStore(String dbPath) async {
    _dbFile = File(dbPath);
    await _readDisk();
  }
}
