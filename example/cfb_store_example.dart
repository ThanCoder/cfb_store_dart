// ignore_for_file: unused_local_variable

import 'package:cfb_store/cfb_store.dart';

void main() async {
  final store = CFBStoreBase();
  await store.open('test.cbf');

  store.put('name', 'ThanCoder');
  store.put('list', ['one', 'two', 'three']);

  print('name: ${store.get('name-')}');
  print('name-def: ${store.getString('name-','i am def')}');
  print('list: ${store.get('list')}');

  // store
  // store.put("hello", StoreValueType("hello"));
}
