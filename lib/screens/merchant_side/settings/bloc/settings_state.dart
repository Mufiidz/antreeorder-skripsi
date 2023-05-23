part of 'settings_bloc.dart';

class SettingsState extends BaseState<Merchant> {
  final List<ConfigMerch> configs;
  final bool isLogout;
  const SettingsState(super.data,
      {super.message,
      super.status,
      this.configs = const [],
      this.isLogout = false});

  @override
  List<Object?> get props => [data, message, status, configs];

  SettingsState copyWith(
      {Merchant? data,
      String? message,
      StatusState? status,
      List<ConfigMerch>? configs,
      bool? isLogout}) {
    return SettingsState(data ?? this.data,
        message: message ?? this.message,
        status: status ?? this.status,
        configs: configs ?? this.configs,
        isLogout: isLogout ?? this.isLogout);
  }

  @override
  String toString() =>
      'SettingsState(configs: $configs, data: $data, message: $message, status: $status, isLogout: $isLogout)';
}

class ConfigMerch {
  final String title;
  final String desc;
  final Widget destination;

  ConfigMerch(this.title, this.desc, this.destination);
}
