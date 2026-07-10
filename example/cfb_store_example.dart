// ignore_for_file: unused_local_variable

import 'package:cfb_store/cfb_store.dart';

void main() async {
  final store = CFBStore();
  await store.open('config.cfb');
  // store.openSync(dbPath)

  store.put('name', 'ThanCoder');
  store.put('age', 29);
  store.put('is_femal', true);
  store.put('list', ['one', 'two', 'three']);
  store.put('map-list', [
    {'name': 'thancoder', 'age': 29},
  ]);
  store.put('map', {'name': 'thancoder', 'age': 28, 'height': 5.6});

  //save disk
  // await store.writeAll();
  print('list: ${store.getMapList('map-list')}');
  print('map: ${store.getMap('map')}');
}
