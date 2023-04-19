// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i6;

import '../config/api_client.dart' as _i7;
import '../repository/antree_repository.dart' as _i9;
import '../repository/merchant_repository.dart' as _i8;
import '../screens/cart/bloc/cart_bloc.dart' as _i3;
import '../screens/confirm_order/bloc/confirm_order_bloc.dart' as _i4;
import '../screens/merchant/bloc/merchant_bloc.dart' as _i10;
import '../screens/product/bloc/merchant_product_bloc.dart' as _i11;
import 'app_module.dart' as _i12;
import 'bloc_module.dart' as _i13;

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final blocModule = _$BlocModule();
    final appModule = _$AppModule();
    gh.lazySingleton<_i3.CartBloc>(() => blocModule.cartBloc());
    gh.singleton<_i4.ConfirmOrderBloc>(blocModule.confirmOrderBloc());
    gh.singleton<_i5.Dio>(appModule.dio());
    await gh.factoryAsync<_i6.SharedPreferences>(
      () => appModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i7.ApiClient>(() => appModule.apiClient(gh<_i5.Dio>()));
    gh.factory<_i8.MerchantRepository>(
        () => _i8.MerchantRepositoryImpl(gh<_i7.ApiClient>()));
    gh.factory<_i9.AntreeRepository>(
        () => _i9.AntreeRepositoryImpl(gh<_i7.ApiClient>()));
    gh.singleton<_i10.MerchantBloc>(
        blocModule.merchantBloc(gh<_i8.MerchantRepository>()));
    gh.singleton<_i11.MerchantProductBloc>(
        blocModule.merchantProductBloc(gh<_i8.MerchantRepository>()));
    return this;
  }
}

class _$AppModule extends _i12.AppModule {}

class _$BlocModule extends _i13.BlocModule {}
