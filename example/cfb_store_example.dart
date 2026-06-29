// ignore_for_file: unused_local_variable

import 'package:cfb_store/cfb_store.dart';

void main() async {
  final store = CFBStoreBase();
  await store.open('config.cfb');

  // store.put('name', 'ThanCoder');
  // store.put('age', 29);
  // store.put('is_femal', true);
  // store.put('list', ['one', 'two', 'three']);
  // store.put('map-list', [
  //   {'name': 'thancoder', 'age': 29},
  // ]);

  // await store.writeAll();

  print('name: ${store.get('name-')}');
  print('name-def: ${store.getString('name-', 'i am def')}');
  // print('list: ${store.get('list')}');
  // print('list-def: ${store.getList('list', ['test def'])}');
  // print('map-list: ${store.getList('map-list')}');
  // print('map-list: ${store.getMapList('map-list')}');

  // store
  // store.put("hello", StoreValueType("hello"));
}
