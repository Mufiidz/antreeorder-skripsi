part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object?> get props => [];
}

class Initial extends SettingsEvent {}

class UpdateStatusMerchant extends SettingsEvent {
  final bool isOpen;

  const UpdateStatusMerchant(this.isOpen);

  @override
  List<Object?> get props => [isOpen];
}

class LogOut extends SettingsEvent {}
