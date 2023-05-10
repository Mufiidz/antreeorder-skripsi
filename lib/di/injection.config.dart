// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i6;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i10;

import '../components/antree_loading_dialog.dart' as _i5;
import '../config/antree_db.dart' as _i4;
import '../config/api_client.dart' as _i13;
import '../config/local/category_dao.dart' as _i9;
import '../repository/antree_repository.dart' as _i21;
import '../repository/auth_repository.dart' as _i14;
import '../repository/merchant_repository.dart' as _i18;
import '../repository/product_repository.dart' as _i16;
import '../repository/sharedprefs_repository.dart' as _i11;
import '../screens/login/bloc/login_bloc.dart' as _i15;
import '../screens/merchant_side/category/bloc/category_bloc.dart' as _i8;
import '../screens/merchant_side/home/bloc/home_bloc.dart' as _i24;
import '../screens/merchant_side/product/bloc/product_bloc.dart' as _i19;
import '../screens/merchant_side/settings/bloc/settings_bloc.dart' as _i20;
import '../screens/register/bloc/register_bloc.dart' as _i17;
import '../screens/user_side/antree/bloc/antree_bloc.dart' as _i3;
import '../screens/user_side/cart/bloc/cart_bloc.dart' as _i7;
import '../screens/user_side/confirm_order/bloc/confirm_order_bloc.dart'
    as _i22;
import '../screens/user_side/home/bloc/home_bloc.dart' as _i23;
import '../screens/user_side/merchant/bloc/merchant_bloc.dart' as _i25;
import '../screens/user_side/product/bloc/merchant_product_bloc.dart' as _i26;
import '../screens/user_side/setting/bloc/setting_bloc.dart' as _i12;
import 'app_module.dart' as _i27;
import 'bloc_module.dart' as _i28;

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
    gh.singleton<_i3.AntreeBloc>(blocModule.antreeUserBloc());
    gh.singleton<_i4.AntreeDatabase>(appModule.antreeDatabase());
    gh.singleton<_i5.AntreeLoadingDialog>(appModule.antreeDialog());
    gh.singleton<_i6.CancelToken>(appModule.cancelToken());
    gh.lazySingleton<_i7.CartBloc>(() => blocModule.cartBloc());
    gh.singleton<_i8.CategoryBloc>(
        blocModule.categoryBloc(gh<_i4.AntreeDatabase>()));
    gh.lazySingleton<_i9.CategoryDao>(
        () => appModule.categoryDao(gh<_i4.AntreeDatabase>()));
    await gh.factoryAsync<_i10.SharedPreferences>(
      () => appModule.prefs,
      preResolve: true,
    );
    gh.factory<_i11.SharedPrefsRepository>(
        () => _i11.SharedPrefsRepository(gh<_i10.SharedPreferences>()));
    gh.singleton<_i6.Dio>(appModule.dio(gh<_i11.SharedPrefsRepository>()));
    gh.singleton<_i12.SettingBloc>(
        blocModule.userSettingBloc(gh<_i11.SharedPrefsRepository>()));
    gh.lazySingleton<_i13.ApiClient>(() => appModule.apiClient(gh<_i6.Dio>()));
    gh.factory<_i14.AuthRepository>(() => _i14.AuthRepositoryImpl(
          gh<_i13.ApiClient>(),
          gh<_i11.SharedPrefsRepository>(),
          gh<_i6.Dio>(),
        ));
    gh.singleton<_i15.LoginBloc>(blocModule.loginBloc(
      gh<_i14.AuthRepository>(),
      gh<_i11.SharedPrefsRepository>(),
    ));
    gh.factory<_i16.ProductRepository>(
        () => _i16.ProductRepositoryImpl(gh<_i13.ApiClient>()));
    gh.singleton<_i17.RegisterBloc>(
        blocModule.registerBloc(gh<_i14.AuthRepository>()));
    gh.factory<_i18.MerchantRepository>(() => _i18.MerchantRepositoryImpl(
          gh<_i13.ApiClient>(),
          gh<_i16.ProductRepository>(),
        ));
    gh.singleton<_i19.ProductBloc>(blocModule.productBloc(
      gh<_i16.ProductRepository>(),
      gh<_i18.MerchantRepository>(),
      gh<_i4.AntreeDatabase>(),
    ));
    gh.singleton<_i20.SettingsBloc>(blocModule.merchantSettingsBloc(
      gh<_i18.MerchantRepository>(),
      gh<_i11.SharedPrefsRepository>(),
    ));
    gh.factory<_i21.AntreeRepository>(() => _i21.AntreeRepositoryImpl(
          gh<_i13.ApiClient>(),
          gh<_i6.CancelToken>(),
          gh<_i16.ProductRepository>(),
          gh<_i18.MerchantRepository>(),
        ));
    gh.singleton<_i22.ConfirmOrderBloc>(
        blocModule.confirmOrderBloc(gh<_i21.AntreeRepository>()));
    gh.singleton<_i23.HomeBloc>(
        blocModule.userHomeBloc(gh<_i21.AntreeRepository>()));
    gh.singleton<_i24.HomeBloc>(blocModule.homeBloc(
      gh<_i18.MerchantRepository>(),
      gh<_i21.AntreeRepository>(),
    ));
    gh.singleton<_i25.MerchantBloc>(
        blocModule.merchantBloc(gh<_i18.MerchantRepository>()));
    gh.singleton<_i26.MerchantProductBloc>(
        blocModule.merchantProductBloc(gh<_i18.MerchantRepository>()));
    return this;
  }
}

class _$AppModule extends _i27.AppModule {}

class _$BlocModule extends _i28.BlocModule {}
