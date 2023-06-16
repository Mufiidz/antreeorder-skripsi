import 'package:injectable/injectable.dart';

import 'package:antreeorder/config/antree_db.dart';
import 'package:antreeorder/repository/antree_repository.dart';
import 'package:antreeorder/repository/auth_repository.dart';
import 'package:antreeorder/repository/merchant_repository.dart';
import 'package:antreeorder/repository/product_repository.dart';
import 'package:antreeorder/repository/seat_repository.dart';
import 'package:antreeorder/screens/login/bloc/login_bloc.dart';
import 'package:antreeorder/screens/merchant_side/category/bloc/category_bloc.dart';
import 'package:antreeorder/screens/merchant_side/product/bloc/product_bloc.dart';
import 'package:antreeorder/screens/register/bloc/register_bloc.dart';
import 'package:antreeorder/screens/user_side/cart/bloc/cart_bloc.dart';
import 'package:antreeorder/screens/user_side/confirm_order/bloc/confirm_order_bloc.dart';
import 'package:antreeorder/screens/user_side/merchant/bloc/merchant_bloc.dart';

@module
@injectable
abstract class BlocModule {
  @singleton
  @factoryMethod
  MerchantBloc merchantBloc(MerchantRepository merchantRepository) =>
      MerchantBloc(merchantRepository);

  @singleton
  @factoryMethod
  ConfirmOrderBloc confirmOrderBloc(
          AntreeRepository antreeRepository, SeatRepository seatRepository) =>
      ConfirmOrderBloc(antreeRepository, seatRepository);

  @lazySingleton
  CartBloc cartBloc() => CartBloc();

  @singleton
  @factoryMethod
  ProductBloc productBloc(
          ProductRepository productRepository, AntreeDatabase antreeDatabase) =>
      ProductBloc(productRepository, antreeDatabase);

  @singleton
  @factoryMethod
  LoginBloc loginBloc(AuthRepository authRepository) =>
      LoginBloc(authRepository);

  @singleton
  @factoryMethod
  RegisterBloc registerBloc(AuthRepository authRepository) =>
      RegisterBloc(authRepository);

  @singleton
  @factoryMethod
  CategoryBloc categoryBloc(AntreeDatabase antreeDatabase) =>
      CategoryBloc(antreeDatabase);
}
