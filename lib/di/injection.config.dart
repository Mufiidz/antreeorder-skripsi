// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i10;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i8;

import '../components/antree_loading_dialog.dart' as _i4;
import '../config/antree_db.dart' as _i3;
import '../config/api_client.dart' as _i11;
import '../config/local/category_dao.dart' as _i7;
import '../repository/antree_repository.dart' as _i18;
import '../repository/auth_repository.dart' as _i12;
import '../repository/merchant_repository.dart' as _i14;
import '../repository/product_repository.dart' as _i15;
import '../repository/sharedprefs_repository.dart' as _i9;
import '../screens/login/bloc/login_bloc.dart' as _i13;
import '../screens/merchant_side/category/bloc/category_bloc.dart' as _i6;
import '../screens/merchant_side/home/bloc/home_bloc.dart' as _i20;
import '../screens/merchant_side/product/bloc/product_bloc.dart' as _i24;
import '../screens/merchant_side/settings/bloc/settings_bloc.dart' as _i17;
import '../screens/register/bloc/register_bloc.dart' as _i16;
import '../screens/user_side/cart/bloc/cart_bloc.dart' as _i5;
import '../screens/user_side/confirm_order/bloc/confirm_order_bloc.dart'
    as _i19;
import '../screens/user_side/home/bloc/home_bloc.dart' as _i21;
import '../screens/user_side/merchant/bloc/merchant_bloc.dart' as _i22;
import '../screens/user_side/product/bloc/merchant_product_bloc.dart' as _i23;
import 'app_module.dart' as _i25;
import 'bloc_module.dart' as _i26;

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
    final appModule = _$AppModule();
    final blocModule = _$BlocModule();
    gh.singleton<_i3.AntreeDatabase>(appModule.antreeDatabase());
    gh.singleton<_i4.AntreeLoadingDialog>(appModule.antreeDialog());
    gh.lazySingleton<_i5.CartBloc>(() => blocModule.cartBloc());
    gh.singleton<_i6.CategoryBloc>(
        blocModule.categoryBloc(gh<_i3.AntreeDatabase>()));
    gh.lazySingleton<_i7.CategoryDao>(
        () => appModule.categoryDao(gh<_i3.AntreeDatabase>()));
    await gh.factoryAsync<_i8.SharedPreferences>(
      () => appModule.prefs,
      preResolve: true,
    );
    gh.factory<_i9.SharedPrefsRepository>(
        () => _i9.SharedPrefsRepository(gh<_i8.SharedPreferences>()));
    gh.singleton<_i10.Dio>(appModule.dio(gh<_i9.SharedPrefsRepository>()));
    gh.lazySingleton<_i11.ApiClient>(() => appModule.apiClient(gh<_i10.Dio>()));
    gh.factory<_i12.AuthRepository>(() => _i12.AuthRepositoryImpl(
          gh<_i11.ApiClient>(),
          gh<_i9.SharedPrefsRepository>(),
          gh<_i10.Dio>(),
        ));
    gh.singleton<_i13.LoginBloc>(blocModule.loginBloc(
      gh<_i12.AuthRepository>(),
      gh<_i9.SharedPrefsRepository>(),
    ));
    gh.factory<_i14.MerchantRepository>(
        () => _i14.MerchantRepositoryImpl(gh<_i11.ApiClient>()));
    gh.factory<_i15.ProductRepository>(
        () => _i15.ProductRepositoryImpl(gh<_i11.ApiClient>()));
    gh.singleton<_i16.RegisterBloc>(
        blocModule.registerBloc(gh<_i12.AuthRepository>()));
    gh.singleton<_i17.SettingsBloc>(blocModule.settingsBloc(
      gh<_i14.MerchantRepository>(),
      gh<_i9.SharedPrefsRepository>(),
    ));
    gh.factory<_i18.AntreeRepository>(
        () => _i18.AntreeRepositoryImpl(gh<_i11.ApiClient>()));
    gh.singleton<_i19.ConfirmOrderBloc>(
        blocModule.confirmOrderBloc(gh<_i18.AntreeRepository>()));
    gh.singleton<_i20.HomeBloc>(blocModule.homeBloc(
      gh<_i14.MerchantRepository>(),
      gh<_i18.AntreeRepository>(),
    ));
    gh.singleton<_i21.HomeBloc>(
        blocModule.userHomeBloc(gh<_i18.AntreeRepository>()));
    gh.singleton<_i22.MerchantBloc>(
        blocModule.merchantBloc(gh<_i14.MerchantRepository>()));
    gh.singleton<_i23.MerchantProductBloc>(
        blocModule.merchantProductBloc(gh<_i14.MerchantRepository>()));
    gh.singleton<_i24.ProductBloc>(blocModule.productBloc(
      gh<_i15.ProductRepository>(),
      gh<_i14.MerchantRepository>(),
      gh<_i3.AntreeDatabase>(),
    ));
    return this;
  }
}

class _$AppModule extends _i25.AppModule {}

class _$BlocModule extends _i26.BlocModule {}
