// ignore_for_file: unused_local_variable

import 'package:cfb_store/cfb_store.dart';
import 'package:cfb_store/src/events/store_events.dart';

void main() async {
  final store = CFBStore();

  // event
  store.events.listen((event) {
    if (event is ValueLoaded) {
      print('ValueLoaded');
    }
    if (event is ValueLoadError) {
      print('ValueLoadError: ${event.message}');
    }
    if (event is ValueSaved) {
      print('ValueSaved');
    }
    if (event is ValueSaveError) {
      print('ValueSaveError: ${event.message}');
    }
    if (event is PutValue) {
      print('PutValue Key: ${event.key}');
    }
  });
  // if you not need stop listen event
  store.close();

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
  await store.writeAll();
  print('list: ${store.getMapList('map-list')}');
  print('map: ${store.getMap('map')}');
}
