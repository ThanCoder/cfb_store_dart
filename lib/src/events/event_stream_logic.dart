part of '../cfb_store_base.dart';

mixin EventStreamLogic on ICFBStore {
  final _controller = StreamController<StoreEvent>.broadcast();
  Stream<StoreEvent> get events => _controller.stream;

  @override
  void _addEvent(StoreEvent event) {
    _controller.add(event);
  }

  void _closeEvent() {
    _controller.close();
  }
}
