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
import 'package:webview_flutter/webview_flutter.dart' as _i14;

import '../components/antree_loading_dialog.dart' as _i4;
import '../config/antree_db.dart' as _i3;
import '../config/api_client.dart' as _i15;
import '../data/local/dao/category_dao.dart' as _i8;
import '../data/local/dao/role_dao.dart' as _i10;
import '../data/local/dao/statusantree_dao.dart' as _i13;
import '../repository/antree_repository.dart' as _i26;
import '../repository/auth_repository.dart' as _i16;
import '../repository/merchant_repository.dart' as _i18;
import '../repository/notification_repository.dart' as _i19;
import '../repository/payment_repository.dart' as _i20;
import '../repository/product_repository.dart' as _i21;
import '../repository/seat_repository.dart' as _i23;
import '../repository/sharedprefs_repository.dart' as _i12;
import '../repository/status_antree_repository.dart' as _i35;
import '../screens/login/bloc/login_bloc.dart' as _i17;
import '../screens/merchant_side/category/bloc/category_bloc.dart' as _i7;
import '../screens/merchant_side/detail_antree/bloc/detail_antree_merchant_bloc.dart'
    as _i37;
import '../screens/merchant_side/home/bloc/home_bloc.dart' as _i38;
import '../screens/merchant_side/product/bloc/product_bloc.dart' as _i33;
import '../screens/merchant_side/seat/bloc/seat_bloc.dart' as _i34;
import '../screens/merchant_side/settings/bloc/settings_bloc.dart' as _i25;
import '../screens/notification/bloc/notification_bloc.dart' as _i31;
import '../screens/register/bloc/register_bloc.dart' as _i22;
import '../screens/user_side/antree/bloc/antree_bloc.dart' as _i36;
import '../screens/user_side/cart/bloc/cart_bloc.dart' as _i6;
import '../screens/user_side/confirm_order/bloc/confirm_order_bloc.dart'
    as _i27;
import '../screens/user_side/home/bloc/home_bloc.dart' as _i28;
import '../screens/user_side/merchant/bloc/merchant_bloc.dart' as _i29;
import '../screens/user_side/payment/bloc/payment_bloc.dart' as _i32;
import '../screens/user_side/product/bloc/merchant_product_bloc.dart' as _i30;
import '../screens/user_side/scan/bloc/scan_verify_bloc.dart' as _i39;
import '../screens/user_side/setting/bloc/setting_bloc.dart' as _i24;
import 'app_module.dart' as _i40;
import 'bloc_module.dart' as _i41;

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
    gh.singleton<_i14.WebViewController>(appModule.webviewController());
    gh.singleton<_i5.Dio>(appModule.dio(gh<_i12.SharedPrefsRepository>()));
    gh.lazySingleton<_i15.ApiClient>(() => appModule.apiClient(gh<_i5.Dio>()));
    gh.factory<_i16.AuthRepository>(() => _i16.AuthRepositoryImpl(
          gh<_i15.ApiClient>(),
          gh<_i12.SharedPrefsRepository>(),
          gh<_i5.Dio>(),
          gh<_i10.RoleDao>(),
        ));
    gh.singleton<_i17.LoginBloc>(
        blocModule.loginBloc(gh<_i16.AuthRepository>()));
    gh.factory<_i18.MerchantRepository>(() => _i18.MerchantRepositoryImpl(
          gh<_i15.ApiClient>(),
          gh<_i12.SharedPrefsRepository>(),
        ));
    gh.factory<_i19.NotificationRepository>(
        () => _i19.NotificationRepositoryImpl(
              gh<_i15.ApiClient>(),
              gh<_i12.SharedPrefsRepository>(),
              gh<_i9.FirebaseMessaging>(),
            ));
    gh.factory<_i20.PaymentRepository>(
        () => _i20.PaymentRepositoryImpl(gh<_i15.ApiClient>()));
    gh.factory<_i21.ProductRepository>(() => _i21.ProductRepositoryImpl(
          gh<_i15.ApiClient>(),
          gh<_i12.SharedPrefsRepository>(),
        ));
    gh.singleton<_i22.RegisterBloc>(
        blocModule.registerBloc(gh<_i16.AuthRepository>()));
    gh.factory<_i23.SeatRepository>(() => _i23.SeatRepositoryImpl(
          gh<_i15.ApiClient>(),
          gh<_i12.SharedPrefsRepository>(),
        ));
    gh.singleton<_i24.SettingBloc>(_i24.SettingBloc(
      gh<_i12.SharedPrefsRepository>(),
      gh<_i16.AuthRepository>(),
    ));
    gh.singleton<_i25.SettingsBloc>(_i25.SettingsBloc(
      gh<_i18.MerchantRepository>(),
      gh<_i16.AuthRepository>(),
    ));
    gh.factory<_i26.AntreeRepository>(() => _i26.AntreeRepositoryImpl(
          gh<_i15.ApiClient>(),
          gh<_i12.SharedPrefsRepository>(),
          gh<_i3.AntreeDatabase>(),
          gh<_i19.NotificationRepository>(),
          gh<_i20.PaymentRepository>(),
        ));
    gh.singleton<_i27.ConfirmOrderBloc>(blocModule.confirmOrderBloc(
      gh<_i26.AntreeRepository>(),
      gh<_i23.SeatRepository>(),
    ));
    gh.factory<_i28.HomeBloc>(() => _i28.HomeBloc(
          gh<_i26.AntreeRepository>(),
          gh<_i19.NotificationRepository>(),
        ));
    gh.singleton<_i29.MerchantBloc>(
        blocModule.merchantBloc(gh<_i18.MerchantRepository>()));
    gh.singleton<_i30.MerchantProductBloc>(
        _i30.MerchantProductBloc(gh<_i21.ProductRepository>()));
    gh.factory<_i31.NotificationBloc>(
        () => _i31.NotificationBloc(gh<_i19.NotificationRepository>()));
    gh.factory<_i32.PaymentBloc>(() => _i32.PaymentBloc(
          gh<_i26.AntreeRepository>(),
          gh<_i20.PaymentRepository>(),
        ));
    gh.singleton<_i33.ProductBloc>(blocModule.productBloc(
      gh<_i21.ProductRepository>(),
      gh<_i3.AntreeDatabase>(),
    ));
    gh.factory<_i34.SeatBloc>(() => _i34.SeatBloc(gh<_i23.SeatRepository>()));
    gh.factory<_i35.StatusAntreeRepository>(
        () => _i35.StatusAntreeRepositoryImpl(
              gh<_i15.ApiClient>(),
              gh<_i26.AntreeRepository>(),
              gh<_i12.SharedPrefsRepository>(),
              gh<_i19.NotificationRepository>(),
            ));
    gh.factory<_i36.AntreeBloc>(
        () => _i36.AntreeBloc(gh<_i26.AntreeRepository>()));
    gh.factory<_i37.DetailAntreeMerchantBloc>(
        () => _i37.DetailAntreeMerchantBloc(
              gh<_i35.StatusAntreeRepository>(),
              gh<_i26.AntreeRepository>(),
            ));
    gh.factory<_i38.HomeBloc>(() => _i38.HomeBloc(
          gh<_i26.AntreeRepository>(),
          gh<_i19.NotificationRepository>(),
          gh<_i18.MerchantRepository>(),
          gh<_i35.StatusAntreeRepository>(),
        ));
    gh.factory<_i39.ScanVerifyBloc>(
        () => _i39.ScanVerifyBloc(gh<_i35.StatusAntreeRepository>()));
    return this;
  }
}

class _$AppModule extends _i40.AppModule {}

class _$BlocModule extends _i41.BlocModule {}
