import 'package:antreeorder/models/base_state2.dart';
import 'package:antreeorder/models/merchant.dart';
import 'package:antreeorder/repository/merchant_repository.dart';
import 'package:antreeorder/repository/sharedprefs_repository.dart';
import 'package:antreeorder/screens/merchant_side/category/category_screen.dart';
import 'package:antreeorder/screens/merchant_side/product/product_screen.dart';
import 'package:antreeorder/screens/merchant_side/seat/add_seat_screen.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final MerchantRepository _merchantRepository;
  final SharedPrefsRepository _sharedPrefsRepository;
  SettingsBloc(this._merchantRepository, this._sharedPrefsRepository)
      : super(const SettingsState([])) {
    on<GetSettings>((event, emit) {
      final settings = [
        ConfigMerch(
            'Manage Product', 'Manage your product', const ProductScreen()),
        ConfigMerch('Add Category', 'Add your category for product',
            const CategoryScreen()),
        ConfigMerch("Add Seat", "Add seat for customer", const AddSeatScreen())
      ];
      emit(state.copyWith(data: settings, status: StatusState.idle));
    });
    on<DetailMerchant>((event, emit) async {
      emit(state.copyWith(status: StatusState.loading));
      try {
        final response =
            await _merchantRepository.detailMerchant(event.merchantId);
        final data = response.data;
        emit(data != null
            ? state.copyWith(
                status: StatusState.idle, merchant: data, isLogout: false)
            : state.copyWith(
                status: StatusState.failure, message: response.message));
      } catch (e) {
        emit(state.copyWith(status: StatusState.failure, message: 'ERROR'));
      }
    });
    on<UpdateStatusMerchant>((event, emit) async {
      try {
        final response = await _merchantRepository.updateStatusMerchant(
            event.merchantId, event.isOpen);
        final data = response.data;
        emit(data != null
            ? state.copyWith(
                status: StatusState.success,
                merchant: data,
                message: response.message)
            : state.copyWith(
                status: StatusState.failure, message: response.message));
      } catch (e) {
        emit(state.copyWith(status: StatusState.failure, message: 'ERROR'));
      }
    });
    on<LogOut>((event, emit) {
      emit(state.copyWith(status: StatusState.loading));
      try {
        _sharedPrefsRepository.onLogout();
        emit(state.copyWith(
            status: StatusState.success,
            isLogout: true,
            message: "Berhasil keluar"));
      } catch (e) {
        emit(
            state.copyWith(status: StatusState.failure, message: e.toString()));
      }
    });
  }
}
