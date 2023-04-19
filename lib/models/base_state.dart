import 'package:equatable/equatable.dart';

enum StatusState { loading, success, failure }

abstract class BaseState<Data> extends Equatable {
  final StatusState status;
  final String errorMessage;
  final Data data;

  const BaseState(
    this.data, {
    this.status = StatusState.loading,
    this.errorMessage = "Unknown Error",
  });

  @override
  List<Object> get props => [status, errorMessage, data as Object];

  @override
  String toString() =>
      'BaseState(status: $status, errorMessage: $errorMessage, data: $data)';
}
