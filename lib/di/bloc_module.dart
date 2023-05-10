import 'package:antreeorder/config/antree_db.dart';
import 'package:antreeorder/repository/antree_repository.dart';
import 'package:antreeorder/repository/auth_repository.dart';
import 'package:antreeorder/repository/merchant_repository.dart';
import 'package:antreeorder/repository/product_repository.dart';
import 'package:antreeorder/repository/sharedprefs_repository.dart';
import 'package:antreeorder/screens/login/bloc/login_bloc.dart';
import 'package:antreeorder/screens/merchant_side/category/bloc/category_bloc.dart';
import 'package:antreeorder/screens/merchant_side/home/bloc/home_bloc.dart'
    as merchant_home;
import 'package:antreeorder/screens/merchant_side/product/bloc/product_bloc.dart';
import 'package:antreeorder/screens/merchant_side/settings/bloc/settings_bloc.dart'
    as merchant_setting;
import 'package:antreeorder/screens/register/bloc/register_bloc.dart';
import 'package:antreeorder/screens/user_side/antree/bloc/antree_bloc.dart';
import 'package:antreeorder/screens/user_side/cart/bloc/cart_bloc.dart';
import 'package:antreeorder/screens/user_side/confirm_order/bloc/confirm_order_bloc.dart';
import 'package:antreeorder/screens/user_side/home/bloc/home_bloc.dart';
import 'package:antreeorder/screens/user_side/merchant/bloc/merchant_bloc.dart';
import 'package:antreeorder/screens/user_side/product/bloc/merchant_product_bloc.dart';
import 'package:antreeorder/screens/user_side/setting/bloc/setting_bloc.dart';
import 'package:injectable/injectable.dart';

@module
@injectable
abstract class BlocModule {
  @singleton
  @factoryMethod
  MerchantProductBloc merchantProductBloc(
          MerchantRepository merchantRepository) =>
      MerchantProductBloc(merchantRepository);

  @singleton
  @factoryMethod
  MerchantBloc merchantBloc(MerchantRepository merchantRepository) =>
      MerchantBloc(merchantRepository);

  @singleton
  @factoryMethod
  ConfirmOrderBloc confirmOrderBloc(AntreeRepository antreeRepository) =>
      ConfirmOrderBloc(antreeRepository);

  @lazySingleton
  CartBloc cartBloc() => CartBloc();

  @singleton
  @factoryMethod
  merchant_home.HomeBloc homeBloc(MerchantRepository merchantRepository,
          AntreeRepository antreeRepository) =>
      merchant_home.HomeBloc(merchantRepository, antreeRepository);

  @singleton
  @factoryMethod
  ProductBloc productBloc(
          ProductRepository productRepository,
          MerchantRepository merchantRepository,
          AntreeDatabase antreeDatabase) =>
      ProductBloc(productRepository, merchantRepository, antreeDatabase);

  @singleton
  @factoryMethod
  LoginBloc loginBloc(AuthRepository authRepository,
          SharedPrefsRepository sharedPrefsRepository) =>
      LoginBloc(authRepository, sharedPrefsRepository);

  @singleton
  @factoryMethod
  RegisterBloc registerBloc(AuthRepository authRepository) =>
      RegisterBloc(authRepository);

  @singleton
  @factoryMethod
  HomeBloc userHomeBloc(AntreeRepository antreeRepository) =>
      HomeBloc(antreeRepository);

  @singleton
  @factoryMethod
  CategoryBloc categoryBloc(AntreeDatabase antreeDatabase) =>
      CategoryBloc(antreeDatabase);

  @singleton
  @factoryMethod
  merchant_setting.SettingsBloc merchantSettingsBloc(
          MerchantRepository merchantRepository,
          SharedPrefsRepository sharedPrefsRepository) =>
      merchant_setting.SettingsBloc(merchantRepository, sharedPrefsRepository);

  @singleton
  @factoryMethod
  SettingBloc userSettingBloc(SharedPrefsRepository sharedPrefsRepository) =>
      SettingBloc(sharedPrefsRepository);

  @singleton
  @factoryMethod
  AntreeBloc antreeUserBloc() => AntreeBloc();
}
