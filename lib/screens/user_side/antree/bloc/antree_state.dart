part of 'antree_bloc.dart';

@freezed
class AntreeState with _$AntreeState {
  const factory AntreeState({
    @Default([]) List<Widget> sections,
  }) = _AntreeState;
}
