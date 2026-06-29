import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:cfb_store/src/core/binary_writer.dart';
import 'package:cfb_store/src/core/binary_reader.dart';
import 'package:cfb_store/src/interfaces/icfb_store.dart'; // BinaryReader ကိုလည်း သုံးရပါမယ်

part 'mixin_logics/file_rw_handler.dart';
part 'mixin_logics/value_handler.dart';

class CFBStoreBase extends ICFBStore with ValueHandler, FileRWHandler {
  // RAM ပေါ်မှာ သီးသန့်စီ Bytes Block တွေအနေနဲ့ သိမ်းဆည်းခြင်း
  final Map<String, Uint8List> _map = {};
  late String _path;
  @override
  String get path => _path;

  @override
  Map<String, Uint8List> get cacheMap => _map;
}
