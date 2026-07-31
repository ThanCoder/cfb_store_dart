// ignore_for_file: public_member_api_docs, sort_constructors_first
sealed class StoreEvent {}

class PutValue extends StoreEvent {
  final String key;
  PutValue(this.key);
}

class ValueLoaded extends StoreEvent {}

class ValueLoadError extends StoreEvent {
  String message;
  ValueLoadError(this.message);
}

class ValueSaved extends StoreEvent {}

class ValueSaveError extends StoreEvent {
  String message;
  ValueSaveError(this.message);
}
