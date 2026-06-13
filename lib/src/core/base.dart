import 'package:cfb_store/src/core/utils/cf_data_model_base.dart';

enum CFDataType {
  int32(1),
  float32(2),
  boolean(3),
  string(4),
  map(5),
  custom(6);

  final int value;
  const CFDataType(this.value);

  static CFDataType getNumber(int type){
    if(type == 1) return int32;
    if(type == 2) return float32;
    if(type == 3) return boolean;
    if(type == 4) return string;
    if(type == 5) return map;
    if(type == 6) return custom;

    throw Exception('TypeNumber: `$type` Not Found Type!');
  }
}

abstract class CFCustomBaseType {
  String get keyName;
  Map<String, dynamic> toDataMap();
  CFBaseDataModel get toData {
    return CFBaseDataModel(toDataMap());
  }
}

abstract class CFCutomBaseAdapter<T extends CFCustomBaseType> {
  T fromData(CFBaseDataModel data);
}
