import 'dart:io';
import 'dart:typed_data';

import 'package:cfb_store/src/core/block_writer.dart';
import 'package:cfb_store/src/core/block_reader.dart';
import 'package:cfb_store/src/core/storage_rw.dart';

part 'mixin_logics/file_rw_handler.dart';
part 'mixin_logics/value_handler.dart';
part 'interfaces/icfb_store.dart';

class CFBStoreBase extends ICFBStore with ValueHandler, FileRWHandler {
  static CFBStoreBase? _instance;

  /// ### Singleton
  static CFBStoreBase get getInstance {
    _instance ??= CFBStoreBase();
    return _instance!;
  }

  @override
  final Map<String, Uint8List> _cacheMap = {};

  late File _dbFile;

  @override
  File get dbFile => _dbFile;
}
