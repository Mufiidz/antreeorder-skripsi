// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i5;
import 'package:firebase_messaging/firebase_messaging.dart' as _i9;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i11;

import '../components/antree_loading_dialog.dart' as _i4;
import '../config/antree_db.dart' as _i3;
import '../config/api_client.dart' as _i14;
import '../config/local/dao/category_dao.dart' as _i8;
import '../config/local/dao/role_dao.dart' as _i10;
import '../config/local/dao/statusantree_dao.dart' as _i13;
import '../repository/antree_repository.dart' as _i24;
import '../repository/auth_repository.dart' as _i15;
import '../repository/merchant_repository.dart' as _i17;
import '../repository/notification_repository.dart' as _i18;
import '../repository/product_repository.dart' as _i19;
import '../repository/seat_repository.dart' as _i21;
import '../repository/sharedprefs_repository.dart' as _i12;
import '../repository/status_antree_repository.dart' as _i32;
import '../screens/login/bloc/login_bloc.dart' as _i16;
import '../screens/merchant_side/category/bloc/category_bloc.dart' as _i7;
import '../screens/merchant_side/detail_antree/bloc/detail_antree_merchant_bloc.dart'
    as _i34;
import '../screens/merchant_side/home/bloc/home_bloc.dart' as _i35;
import '../screens/merchant_side/product/bloc/product_bloc.dart' as _i30;
import '../screens/merchant_side/seat/bloc/seat_bloc.dart' as _i31;
import '../screens/merchant_side/settings/bloc/settings_bloc.dart' as _i23;
import '../screens/notification/bloc/notification_bloc.dart' as _i29;
import '../screens/register/bloc/register_bloc.dart' as _i20;
import '../screens/user_side/antree/bloc/antree_bloc.dart' as _i33;
import '../screens/user_side/cart/bloc/cart_bloc.dart' as _i6;
import '../screens/user_side/confirm_order/bloc/confirm_order_bloc.dart'
    as _i25;
import '../screens/user_side/home/bloc/home_bloc.dart' as _i26;
import '../screens/user_side/merchant/bloc/merchant_bloc.dart' as _i27;
import '../screens/user_side/product/bloc/merchant_product_bloc.dart' as _i28;
import '../screens/user_side/scan/bloc/scan_verify_bloc.dart' as _i36;
import '../screens/user_side/setting/bloc/setting_bloc.dart' as _i22;
import 'app_module.dart' as _i37;
import 'bloc_module.dart' as _i38;

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
    gh.singleton<_i5.CancelToken>(appModule.cancelToken());
    gh.lazySingleton<_i6.CartBloc>(() => blocModule.cartBloc());
    gh.singleton<_i7.CategoryBloc>(
        blocModule.categoryBloc(gh<_i3.AntreeDatabase>()));
    gh.lazySingleton<_i8.CategoryDao>(
        () => appModule.categoryDao(gh<_i3.AntreeDatabase>()));
    gh.lazySingleton<_i9.FirebaseMessaging>(() => appModule.firebaseMessaging);
    gh.lazySingleton<_i10.RoleDao>(
        () => appModule.roleDao(gh<_i3.AntreeDatabase>()));
    await gh.singletonAsync<_i11.SharedPreferences>(
      () => appModule.prefs,
      preResolve: true,
    );
    gh.factory<_i12.SharedPrefsRepository>(() => _i12.SharedPrefsRepository(
          gh<_i11.SharedPreferences>(),
          gh<_i8.CategoryDao>(),
        ));
    gh.factory<_i13.StatusAntreeDao>(
        () => _i13.StatusAntreeDao(gh<_i3.AntreeDatabase>()));
    gh.singleton<_i5.Dio>(appModule.dio(gh<_i12.SharedPrefsRepository>()));
    gh.lazySingleton<_i14.ApiClient>(() => appModule.apiClient(gh<_i5.Dio>()));
    gh.factory<_i15.AuthRepository>(() => _i15.AuthRepositoryImpl(
          gh<_i14.ApiClient>(),
          gh<_i12.SharedPrefsRepository>(),
          gh<_i5.Dio>(),
          gh<_i10.RoleDao>(),
        ));
    gh.singleton<_i16.LoginBloc>(
        blocModule.loginBloc(gh<_i15.AuthRepository>()));
    gh.factory<_i17.MerchantRepository>(() => _i17.MerchantRepositoryImpl(
          gh<_i14.ApiClient>(),
          gh<_i12.SharedPrefsRepository>(),
        ));
    gh.factory<_i18.NotificationRepository>(
        () => _i18.NotificationRepositoryImpl(
              gh<_i14.ApiClient>(),
              gh<_i12.SharedPrefsRepository>(),
              gh<_i9.FirebaseMessaging>(),
            ));
    gh.factory<_i19.ProductRepository>(() => _i19.ProductRepositoryImpl(
          gh<_i14.ApiClient>(),
          gh<_i12.SharedPrefsRepository>(),
        ));
    gh.singleton<_i20.RegisterBloc>(
        blocModule.registerBloc(gh<_i15.AuthRepository>()));
    gh.factory<_i21.SeatRepository>(() => _i21.SeatRepositoryImpl(
          gh<_i14.ApiClient>(),
          gh<_i12.SharedPrefsRepository>(),
        ));
    gh.singleton<_i22.SettingBloc>(_i22.SettingBloc(
      gh<_i12.SharedPrefsRepository>(),
      gh<_i15.AuthRepository>(),
    ));
    gh.singleton<_i23.SettingsBloc>(_i23.SettingsBloc(
      gh<_i17.MerchantRepository>(),
      gh<_i15.AuthRepository>(),
    ));
    gh.factory<_i24.AntreeRepository>(() => _i24.AntreeRepositoryImpl(
          gh<_i14.ApiClient>(),
          gh<_i12.SharedPrefsRepository>(),
          gh<_i3.AntreeDatabase>(),
          gh<_i18.NotificationRepository>(),
        ));
    gh.singleton<_i25.ConfirmOrderBloc>(blocModule.confirmOrderBloc(
      gh<_i24.AntreeRepository>(),
      gh<_i21.SeatRepository>(),
    ));
    gh.factory<_i26.HomeBloc>(() => _i26.HomeBloc(
          gh<_i24.AntreeRepository>(),
          gh<_i18.NotificationRepository>(),
        ));
    gh.singleton<_i27.MerchantBloc>(
        blocModule.merchantBloc(gh<_i17.MerchantRepository>()));
    gh.singleton<_i28.MerchantProductBloc>(
        _i28.MerchantProductBloc(gh<_i19.ProductRepository>()));
    gh.factory<_i29.NotificationBloc>(
        () => _i29.NotificationBloc(gh<_i18.NotificationRepository>()));
    gh.singleton<_i30.ProductBloc>(blocModule.productBloc(
      gh<_i19.ProductRepository>(),
      gh<_i3.AntreeDatabase>(),
    ));
    gh.factory<_i31.SeatBloc>(() => _i31.SeatBloc(gh<_i21.SeatRepository>()));
    gh.factory<_i32.StatusAntreeRepository>(
        () => _i32.StatusAntreeRepositoryImpl(
              gh<_i14.ApiClient>(),
              gh<_i24.AntreeRepository>(),
              gh<_i12.SharedPrefsRepository>(),
              gh<_i18.NotificationRepository>(),
            ));
    gh.factory<_i33.AntreeBloc>(
        () => _i33.AntreeBloc(gh<_i24.AntreeRepository>()));
    gh.factory<_i34.DetailAntreeMerchantBloc>(
        () => _i34.DetailAntreeMerchantBloc(
              gh<_i32.StatusAntreeRepository>(),
              gh<_i24.AntreeRepository>(),
            ));
    gh.singleton<_i35.HomeBloc>(blocModule.homeBloc(
      gh<_i24.AntreeRepository>(),
      gh<_i32.StatusAntreeRepository>(),
      gh<_i18.NotificationRepository>(),
    ));
    gh.factory<_i36.ScanVerifyBloc>(
        () => _i36.ScanVerifyBloc(gh<_i32.StatusAntreeRepository>()));
    return this;
  }
}

class _$AppModule extends _i37.AppModule {}

class _$BlocModule extends _i38.BlocModule {}
