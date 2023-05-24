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
import 'package:shared_preferences/shared_preferences.dart' as _i11;

import '../components/antree_loading_dialog.dart' as _i5;
import '../config/antree_db.dart' as _i4;
import '../config/api_client.dart' as _i15;
import '../config/local/dao/category_dao.dart' as _i9;
import '../config/local/dao/role_dao.dart' as _i10;
import '../config/local/dao/statusantree_dao.dart' as _i13;
import '../repository/antree_repository.dart' as _i23;
import '../repository/antree_repository2.dart' as _i27;
import '../repository/auth_repository.dart' as _i16;
import '../repository/merchant_repository.dart' as _i18;
import '../repository/merchant_repository2.dart' as _i24;
import '../repository/product_repository.dart' as _i19;
import '../repository/seat_repository.dart' as _i21;
import '../repository/sharedprefs_repository.dart' as _i12;
import '../screens/login/bloc/login_bloc.dart' as _i17;
import '../screens/merchant_side/category/bloc/category_bloc.dart' as _i8;
import '../screens/merchant_side/home/bloc/home_bloc.dart' as _i29;
import '../screens/merchant_side/product/bloc/product_bloc.dart' as _i25;
import '../screens/merchant_side/seat/bloc/seat_bloc.dart' as _i26;
import '../screens/merchant_side/settings/bloc/settings_bloc.dart' as _i22;
import '../screens/register/bloc/register_bloc.dart' as _i20;
import '../screens/user_side/antree/bloc/antree_bloc.dart' as _i3;
import '../screens/user_side/cart/bloc/cart_bloc.dart' as _i7;
import '../screens/user_side/confirm_order/bloc/confirm_order_bloc.dart'
    as _i28;
import '../screens/user_side/home/bloc/home_bloc.dart' as _i30;
import '../screens/user_side/merchant/bloc/merchant_bloc.dart' as _i31;
import '../screens/user_side/product/bloc/merchant_product_bloc.dart' as _i32;
import '../screens/user_side/setting/bloc/setting_bloc.dart' as _i14;
import 'app_module.dart' as _i33;
import 'bloc_module.dart' as _i34;

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
    gh.lazySingleton<_i10.RoleDao>(
        () => appModule.roleDao(gh<_i4.AntreeDatabase>()));
    await gh.singletonAsync<_i11.SharedPreferences>(
      () => appModule.prefs,
      preResolve: true,
    );
    gh.factory<_i12.SharedPrefsRepository>(() => _i12.SharedPrefsRepository(
          gh<_i11.SharedPreferences>(),
          gh<_i9.CategoryDao>(),
        ));
    gh.factory<_i13.StatusAntreeDao>(
        () => _i13.StatusAntreeDao(gh<_i4.AntreeDatabase>()));
    gh.singleton<_i6.Dio>(appModule.dio(gh<_i12.SharedPrefsRepository>()));
    gh.singleton<_i14.SettingBloc>(
        blocModule.userSettingBloc(gh<_i12.SharedPrefsRepository>()));
    gh.lazySingleton<_i15.ApiClient>(() => appModule.apiClient(gh<_i6.Dio>()));
    gh.factory<_i16.AuthRepository>(() => _i16.AuthRepositoryImpl(
          gh<_i15.ApiClient>(),
          gh<_i12.SharedPrefsRepository>(),
          gh<_i6.Dio>(),
          gh<_i10.RoleDao>(),
        ));
    gh.singleton<_i17.LoginBloc>(
        blocModule.loginBloc(gh<_i16.AuthRepository>()));
    gh.factory<_i18.MerchantRepository>(() => _i18.MerchantRepositoryImpl(
          gh<_i15.ApiClient>(),
          gh<_i12.SharedPrefsRepository>(),
        ));
    gh.factory<_i19.ProductRepository>(() => _i19.ProductRepositoryImpl(
          gh<_i15.ApiClient>(),
          gh<_i12.SharedPrefsRepository>(),
        ));
    gh.singleton<_i20.RegisterBloc>(
        blocModule.registerBloc(gh<_i16.AuthRepository>()));
    gh.factory<_i21.SeatRepository>(() => _i21.SeatRepositoryImpl(
          gh<_i15.ApiClient>(),
          gh<_i12.SharedPrefsRepository>(),
        ));
    gh.singleton<_i22.SettingsBloc>(blocModule.merchantSettingsBloc(
      gh<_i12.SharedPrefsRepository>(),
      gh<_i18.MerchantRepository>(),
    ));
    gh.factory<_i23.AntreeRepository>(() => _i23.AntreeRepositoryImpl(
          gh<_i15.ApiClient>(),
          gh<_i12.SharedPrefsRepository>(),
          gh<_i4.AntreeDatabase>(),
        ));
    gh.factory<_i24.MerchantRepository2>(() => _i24.MerchantRepositoryImpl2(
          gh<_i15.ApiClient>(),
          gh<_i19.ProductRepository>(),
        ));
    gh.singleton<_i25.ProductBloc>(blocModule.productBloc(
      gh<_i19.ProductRepository>(),
      gh<_i4.AntreeDatabase>(),
    ));
    gh.factory<_i26.SeatBloc>(() => _i26.SeatBloc(gh<_i21.SeatRepository>()));
    gh.factory<_i27.AntreeRepository2>(() => _i27.AntreeRepositoryImpl2(
          gh<_i15.ApiClient>(),
          gh<_i6.CancelToken>(),
          gh<_i19.ProductRepository>(),
          gh<_i24.MerchantRepository2>(),
        ));
    gh.singleton<_i28.ConfirmOrderBloc>(
        blocModule.confirmOrderBloc(gh<_i27.AntreeRepository2>()));
    gh.singleton<_i29.HomeBloc>(blocModule.homeBloc(
      gh<_i23.AntreeRepository>(),
      gh<_i27.AntreeRepository2>(),
    ));
    gh.singleton<_i30.HomeBloc>(
        blocModule.userHomeBloc(gh<_i27.AntreeRepository2>()));
    gh.singleton<_i31.MerchantBloc>(
        blocModule.merchantBloc(gh<_i24.MerchantRepository2>()));
    gh.singleton<_i32.MerchantProductBloc>(
        blocModule.merchantProductBloc(gh<_i24.MerchantRepository2>()));
    return this;
  }
}

class _$AppModule extends _i33.AppModule {}

class _$BlocModule extends _i34.BlocModule {}
