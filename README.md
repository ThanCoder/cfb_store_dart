# CFB Store

## Config Binary Store

### Example
```dart
final store = CFBStoreBase();
await store.open('config.cfb');

store.put('name', 'ThanCoder');
store.put('age', 29);
store.put('is_femal', true);
store.put('list', ['one', 'two', 'three']);
store.put('map-list', [
    {'name': 'thancoder', 'age': 29},
]);
print('all: ${store.cacheMap}');

//save disk
await store.writeAll();

print('name: ${store.get('name-')}');
print('name-def: ${store.getString('name-', 'i am def')}');
print('map-list: ${store.getMapList('map-list')}');
print('list: ${store.get('list')}');
```