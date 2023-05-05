part of 'home_bloc.dart';

class HomeState extends BaseState<List<Antree>> {
  const HomeState(super.data, {super.message, super.status});

  @override
  List<Object> get props => [data, message, status];

  HomeState copyWith(
      {List<Antree>? data, String? message, StatusState? status}) {
    return HomeState(data ?? this.data,
        message: message ?? this.message, status: status ?? this.status);
  }
}
