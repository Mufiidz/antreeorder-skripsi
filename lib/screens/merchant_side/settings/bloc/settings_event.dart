part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object?> get props => [];
}

class DetailMerchant extends SettingsEvent {
  final String merchantId;

  const DetailMerchant(this.merchantId);

  @override
  List<Object?> get props => [merchantId];
}

class GetSettings extends SettingsEvent {}

class LogOut extends SettingsEvent {}
