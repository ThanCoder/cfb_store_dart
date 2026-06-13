// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: unused_local_variable

import 'package:cfb_store/cfb_store.dart';
import 'package:cfb_store/src/core/base.dart';
import 'package:cfb_store/src/core/utils/cf_data_model_base.dart';

void main() async {
  final store = CFBStoreBase();
  store.register<Config>(ConfigAdapter());
  await store.openStore('test.config');

  // store.put("name", "thancoder");
  // store.put("age", 29);
  // store.put("height", 5.5);
  // store.put("isGreeted", true);

  // store.putCustomData(Config(name: 'cf name', packageName: 'com.cf.pkg'));

  // await store.writeDisk();


  print('---------------bytes-------------------');
  print(store.cacheMap);
  print('---------------output-------------------');
  print(store.getString('name'));
  print(store.getInt('age'));
  print(store.getDouble('height'));
  print(store.getBool('isGreeted'));
  print('---------------config-------------------');
  print('config: ${store.getCustom<Config>('config')?.toDataMap()}');
  // store
  // store.put("hello", StoreValueType("hello"));
}

class Config extends CFCustomBaseType {
  final String name;
  final String packageName;
  Config({required this.name, required this.packageName});
  @override
  String get keyName => 'config';

  @override
  Map<String, dynamic> toDataMap() {
    return {'name': name, 'packageName': packageName};
  }
}

class ConfigAdapter extends CFCutomBaseAdapter<Config> {
  @override
  Config fromData(CFBaseDataModel data) {
    return Config(
      name: data.getString('name'),
      packageName: data.getString('packageName'),
    );
  }
}
