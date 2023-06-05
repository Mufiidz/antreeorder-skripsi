part of 'home_bloc.dart';

class HomeState extends BaseState<List<Antree>> {
  final int notificationCounter;
  const HomeState(super.data,
      {super.message, super.status, this.notificationCounter = 0});

  @override
  List<Object> get props => [data, message, status, notificationCounter];

  HomeState copyWith(
      {List<Antree>? data,
      String? message,
      StatusState? status,
      int? notificationCounter}) {
    return HomeState(data ?? this.data,
        notificationCounter: notificationCounter ?? this.notificationCounter,
        message: message ?? this.message,
        status: status ?? this.status);
  }
}
