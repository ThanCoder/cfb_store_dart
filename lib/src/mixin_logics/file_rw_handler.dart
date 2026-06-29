part of '../cfb_store_base.dart';

mixin FileRWHandler on ICFBStore {
  set _path(String path);

  Future<void> open(String path) async {
    cacheMap.clear();
    _path = path;
  }

  @override
  Future<void> writeAll() async {}
}
