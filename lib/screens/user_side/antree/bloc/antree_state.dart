part of 'antree_bloc.dart';

@freezed
class AntreeState with _$AntreeState {
  const factory AntreeState(
      {@Default([]) List<Widget> sections,
      @Default(StatusState.idle) StatusState status,
      @Default('') String message,
      @Default(Antree()) Antree antree}) = _AntreeState;
}
