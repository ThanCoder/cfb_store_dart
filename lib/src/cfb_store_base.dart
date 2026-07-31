import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:cfb_store/src/core/block_writer.dart';
import 'package:cfb_store/src/core/block_reader.dart';
import 'package:cfb_store/src/core/storage_rw.dart';
import 'package:cfb_store/src/events/store_events.dart';
import 'package:cfb_store/src/mixin_logics/special_methods_logic.dart';

part 'mixin_logics/file_rw_handler.dart';
part 'mixin_logics/value_handler.dart';
part 'interfaces/icfb_store.dart';
part 'events/event_stream_logic.dart';

class CFBStore extends ICFBStore
    with ValueHandler, FileRWHandler, SpecialMethodsLogic, EventStreamLogic {
  static CFBStore? _instance;

  /// ### Singleton
  static CFBStore get getInstance {
    _instance ??= CFBStore();
    return _instance!;
  }

  @override
  final Map<String, Uint8List> _cacheMap = {};
  Map<String, Uint8List> get cacheMap => _cacheMap;
  late File _dbFile;

  @override
  File get dbFile => _dbFile;

  @override
  void close() {
    _closeEvent();
  }
}
