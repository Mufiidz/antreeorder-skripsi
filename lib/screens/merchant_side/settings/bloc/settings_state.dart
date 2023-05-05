part of 'settings_bloc.dart';

class SettingsState extends BaseState<List<ConfigMerch>> {
  final Merchant? merchant;
  final bool isLogout;
  const SettingsState(super.data,
      {super.message, super.status, this.merchant, this.isLogout = false});

  @override
  List<Object?> get props => [data, message, status, merchant];

  SettingsState copyWith(
      {List<ConfigMerch>? data,
      String? message,
      StatusState? status,
      Merchant? merchant,
      bool? isLogout}) {
    return SettingsState(data ?? this.data,
        message: message ?? this.message,
        status: status ?? this.status,
        merchant: merchant ?? this.merchant,
        isLogout: isLogout ?? this.isLogout);
  }

  @override
  String toString() =>
      'SettingsState(merchant: $merchant, data: $data, message: $message, status: $status, isLogout: $isLogout)';
}

class ConfigMerch {
  final String title;
  final String desc;
  final Widget destination;

  ConfigMerch(this.title, this.desc, this.destination);
}
