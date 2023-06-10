import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import 'package:antreeorder/models/base_state2.dart';
import 'package:antreeorder/models/merchant.dart';
import 'package:antreeorder/repository/auth_repository.dart';
import 'package:antreeorder/repository/merchant_repository.dart';
import 'package:antreeorder/screens/merchant_side/category/category_screen.dart';
import 'package:antreeorder/screens/merchant_side/product/product_screen.dart';
import 'package:antreeorder/screens/merchant_side/seat/add_seat_screen.dart';

part 'settings_event.dart';
part 'settings_state.dart';

@singleton
@injectable
class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final MerchantRepository _merchantRepository;
  final AuthRepository _authRepository;

  SettingsBloc(this._merchantRepository, this._authRepository)
      : super(const SettingsState(Merchant())) {
    on<Initial>(
      (event, emit) async {
        emit(state.copyWith(status: StatusState.loading));
        final response = await _merchantRepository.detailMerchant();
        var newState = response.when(
          data: (data, meta) =>
              state.copyWith(data: data, status: StatusState.idle),
          error: (message) =>
              state.copyWith(status: StatusState.failure, message: message),
        );
        newState = newState.copyWith(configs: getSettings);
        emit(newState);
      },
    );
    on<UpdateStatusMerchant>((event, emit) async {
      emit(state.copyWith(status: StatusState.loading));
      final response =
          await _merchantRepository.updateStatusMerchant(event.isOpen);
      final newState = response.when(
        data: (data, meta) {
          final message = 'Merchant now is ${data.isOpen ? 'Open' : 'Close'}';
          return state.copyWith(
              status: StatusState.idle, data: data, message: message);
        },
        error: (message) =>
            state.copyWith(status: StatusState.failure, message: message),
      );
      emit(newState);
    });
    on<LogOut>((event, emit) async {
      emit(state.copyWith(status: StatusState.loading));
      try {
        final response = await _authRepository.onLogOut();
        final newState = response.when(
          data: (data, meta) => state.copyWith(
              status: StatusState.success, isLogout: true, message: data),
          error: (message) => state.copyWith(
              status: StatusState.failure, message: message, isLogout: false),
        );
        emit(newState);
      } catch (e) {
        emit(
            state.copyWith(status: StatusState.failure, message: e.toString()));
      }
    });
  }

  List<ConfigMerch> get getSettings => [
        ConfigMerch(
            'Manage Product', 'Manage your product', const ProductScreen()),
        ConfigMerch('Add Category', 'Add your category for product',
            const CategoryScreen()),
        ConfigMerch("Add Seat", "Add seat for customer", const AddSeatScreen())
      ];
}
