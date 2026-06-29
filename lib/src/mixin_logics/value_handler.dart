part of '../cfb_store_base.dart';

mixin ValueHandler on ICFBStore {
  String getString(String key, [String? def]) {
    final val = get(key);
    if (val == null) return def ?? '';
    if (val is String) {
      return val;
    }
    return def ?? '';
  }

  /// ဘယ် Data Type မဆို (Primitives, List, Map) ပေးလို့ရပြီဖြစ်ပါတယ်။
  @override
  void put(String key, dynamic value) {
    final writer = BinaryWriter();
    // Key မပါဘူး၊ value ရဲ့ payload ပဲထုတ်မယ်
    writer.writeValue(value);

    // Memory ပေါ်မှာ map key နဲ့ bytes ကို သိမ်းလိုက်ပြီ
    cacheMap[key] = writer.toBytes;
  }

  /// Memory ထဲက Bytes ကိုဖတ်ပြီး မူလ Data Type (List/Map/String/etc.) အတိုင်း ပြန်ထုတ်ပေးမယ်
  @override
  dynamic get(String key) {
    final bytes = cacheMap[key];
    if (bytes == null) return null;

    final reader = BinaryReader(payload: bytes);
    return reader.readValue(); // Payload ထဲက value ကို တိုက်ရိုက်ထုတ်ယူခြင်း
  }
}
