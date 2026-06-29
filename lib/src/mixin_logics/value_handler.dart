part of '../cfb_store_base.dart';

mixin ValueHandler on ICFBStore {
  /// ### `List<Map<String, dynamic>>` Type
  List<Map<String, dynamic>> getMapList(
    String key, [
    List<Map<String, dynamic>>? def,
  ]) {
    final List<dynamic> val = getList(key);
    return val.map((e) {
      if (e is Map) {
        return Map<String, dynamic>.from(e);
      }
      return <String, dynamic>{};
    }).toList();
  }

  /// ### `List<dynamic>` Type
  List<dynamic> getList(String key, [List<dynamic>? def]) {
    final val = get(key);
    if (val == null) return def ?? [];
    if (val is List) {
      return List.from(val);
    }
    return def ?? [];
  }

  /// ### Bool Type
  bool getBool(String key, [bool? def]) {
    final val = get(key);
    if (val == null) return def ?? false;
    if (val is bool) {
      return val;
    }
    return def ?? false;
  }

  /// ### String Type
  String getString(String key, [String? def]) {
    final val = get(key);
    if (val == null) return def ?? '';
    if (val is String) {
      return val;
    }
    return def ?? '';
  }

  /// ### int Type
  int getInt(String key, [int? def]) {
    final val = get(key);
    if (val == null) return def ?? 0;
    if (val is int) {
      return val;
    }
    return def ?? 0;
  }

  /// ### double Type
  double getDouble(String key, [double? def]) {
    final val = get(key);
    if (val == null) return def ?? 0.0;
    if (val is double) {
      return val;
    }
    return def ?? 0.0;
  }

  @override
  void put(String key, dynamic value) {
    final writer = BlockWriter();
    // Key မပါဘူး၊ value ရဲ့ payload ပဲထုတ်မယ်
    writer.writeValue(value);

    // Memory ပေါ်မှာ map key နဲ့ bytes ကို သိမ်းလိုက်ပြီ
    _cacheMap[key] = writer.toBytes;
  }

  @override
  dynamic get(String key) {
    final bytes = _cacheMap[key];
    if (bytes == null) return null;

    final reader = BlockReader(payload: bytes);
    return reader.readValue(); // Payload ထဲက value ကို တိုက်ရိုက်ထုတ်ယူခြင်း
  }
}
