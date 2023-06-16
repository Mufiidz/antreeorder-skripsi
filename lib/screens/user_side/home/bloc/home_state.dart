part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState(
      {@Default([]) List<Antree> data,
      @Default('') String message,
      @Default(StatusState.idle) StatusState status,
      @Default(0) int notificationCounter,
      @Default(true) bool isLastPage}) = _HomeState;
}
