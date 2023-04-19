import 'package:antreeorder/repository/merchant_repository.dart';
import 'package:antreeorder/screens/merchant/bloc/merchant_bloc.dart';
import 'package:antreeorder/screens/product/bloc/merchant_product_bloc.dart';
import 'package:injectable/injectable.dart';

import '../screens/cart/bloc/cart_bloc.dart';
import '../screens/confirm_order/bloc/confirm_order_bloc.dart';

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
  ConfirmOrderBloc confirmOrderBloc() => ConfirmOrderBloc();

  @lazySingleton
  CartBloc cartBloc() => CartBloc();
}
