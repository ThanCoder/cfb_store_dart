part of '../cfb_store_base.dart';

mixin EventStreamLogic on ICFBStore {
  final _controller = StreamController<StoreEvent>.broadcast();

  /// ### Listen Events
  ///
  /// Events - > `PutValue`,`ValueLoaded`,`ValueSaved`
  /// `ValueLoadError`,`ValueSaveError`
  ///
  /// Event Close -> `store.close();`
  ///
  /// ### Example
  ///
  ///```dart
  ///   store.events.listen((event) {
  /// if (event is ValueLoaded) {
  ///     print('ValueLoaded');
  /// }
  /// if (event is ValueLoadError) {
  ///     print('ValueLoadError: ${event.message}');
  /// }
  /// if (event is ValueSaved) {
  ///     print('ValueSaved');
  /// }
  /// if (event is ValueSaveError) {
  ///     print('ValueSaveError: ${event.message}');
  /// }
  /// if (event is PutValue) {
  ///     print('PutValue Key: ${event.key}');
  /// }
  /// });
  ///
  /// // if you not needed stop listen event
  /// store.close();
  /// ```
  Stream<StoreEvent> get events => _controller.stream;

  @override
  void _addEvent(StoreEvent event) {
    _controller.add(event);
  }

  void _closeEvent() {
    _controller.close();
  }
}
