# CFB Store

## Config Binary Store

CFB Store is a lightweight local key-value storage engine for Dart applications.

It provides a simple and efficient way to store and retrieve data using a key-value API. 
CFB Store supports primitive values, lists, and maps with persistent binary file storage.

Features include:

- Asynchronous disk persistence
- Simple key-value storage API
- Support for String, Number, Boolean, List, and Map data types
- Event-based operation tracking
- Error notifications for storage operations
- Lightweight binary storage format

## Features

- [x] Store and retrieve primitive values
- [x] Store List and Map objects
- [x] Persistent binary file storage
- [x] Async read/write operations
- [x] Store operation events
- [x] Error handling events
---
- [x] ➕ Added - [`Example`](#example)
- [x] ➕ Added - [`Special Methods`](#special-methods)
- [x] ➕ Added - [`Store Events`](#store-events)

---

### Example
```dart
final store = CFBStore();
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

### Special Methods

```dart
store.putAndWriteAll(key, value);
store.putAndWriteAllSync(key, value);
```

### Store Events
```dart
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
// if you not needed stop listen event
store.close();
```