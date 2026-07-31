// ignore_for_file: unused_local_variable

import 'package:cfb_store/cfb_store.dart';

void main() async {
  final store = CFBStore();

  // store.events
  store.close();

  await store.open('config.cfb');
  // store.openSync(dbPath)

  final ml = <Map<String, dynamic>>[
    {'name': 'than'},
    {'name': 'coder'},
    {
      'map-list': {'sub': 'subname'},
    },
  ].toList();

  await store.putAndWriteAll('map-list', ml);

  //save disk
  await store.writeAll();
  print('list: ${store.getMapList('map-list')}');
  print('map: ${store.getMap('map')}');
}
