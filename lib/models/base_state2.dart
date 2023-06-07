import 'package:equatable/equatable.dart';

enum StatusState { loading, success, failure, idle, idleList }

abstract class BaseState<Data> extends Equatable {
  final StatusState status;
  final String message;
  final Data data;

  const BaseState(
    this.data, {
    this.status = StatusState.idle,
    this.message = "Unknown Error",
  });

  @override
  List<Object?> get props => [status, message, data as Object];

  @override
  String toString() =>
      'BaseState(status: $status, errorMessage: $message, data: $data)';
}

abstract class BaseState2<Data> {
  StatusState get status;
  String get message;
  Data get data;
}
