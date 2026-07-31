import 'package:cfb_store/src/cfb_store_base.dart';

mixin SpecialMethodsLogic on ICFBStore {
  /// ### Special Methods - >`putAndWriteAll`
  Future<void> putAndWriteAll(String key, dynamic value) async {
    put(key, value);
    await writeAll();
  }

  /// ### Special Methods - >`putAndWriteAllSync`
  void putAndWriteAllSync(String key, dynamic value) {
    put(key, value);
    writeAllSync();
  }
}
