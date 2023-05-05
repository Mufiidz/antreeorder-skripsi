part of 'home_bloc.dart';

class HomeState extends BaseState<List<Antree>> {
  final Antree? antree;
  const HomeState(super.data, {super.message, super.status, this.antree});

  @override
  List<Object?> get props => [data, message, status, antree];

  HomeState copyWith(
      {List<Antree>? data,
      StatusState? status,
      String? message,
      Antree? antree}) {
    return HomeState(data ?? this.data,
        status: status ?? this.status,
        message: message ?? this.message,
        antree: antree);
  }
}
