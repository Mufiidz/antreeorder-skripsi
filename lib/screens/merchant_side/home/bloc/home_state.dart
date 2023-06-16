part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState(
      {@Default('') String message,
      @Default(0) int notificationCounter,
      @Default([]) List<Antree> antrees,
      Antree? antree,
      @Default(StatusState.idle) StatusState status,
      @Default(true) bool isLastPage,
      Merchant? merchant}) = _HomeState;
}
