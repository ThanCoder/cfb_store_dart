part of '../cfb_store_base.dart';

abstract class ICFBStore {
  Map<String, Uint8List> get _cacheMap;
  File get dbFile;

  /// ဘယ် Data Type မဆို (Primitives, List, Map) ပေးလို့ရပြီဖြစ်ပါတယ်။
  ///
  /// ### Need To Call `writeAll` Method
  ///
  /// Make Sure Write Disk
  void put(String key, dynamic value);

  /// Memory ထဲက Bytes ကိုဖတ်ပြီး မူလ Data Type (List/Map/String/etc.) အတိုင်း ပြန်ထုတ်ပေးမယ်
  dynamic get(String key);

  /// ### Need To Call
  Future<bool> open(String dbPath);

  /// ### Write Disk
  Future<bool> writeAll();
}
