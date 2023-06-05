part of 'home_bloc.dart';

class HomeState extends BaseState<List<Antree>> {
  final Antree? antree;
  final int notificationCounter;
  const HomeState(super.data,
      {super.message, super.status, this.antree, this.notificationCounter = 0});

  @override
  List<Object?> get props =>
      [data, message, status, antree, notificationCounter];

  HomeState copyWith(
      {List<Antree>? data,
      StatusState? status,
      String? message,
      int? notificationCounter,
      Antree? antree}) {
    return HomeState(data ?? this.data,
        status: status ?? this.status,
        message: message ?? this.message,
        antree: antree,
        notificationCounter: notificationCounter ?? this.notificationCounter);
  }
}
