class Const {
  Const._();

  static const String baseUrl = 'https://api.mufidz.my.id/antree-order';
}

class ConstEndpoints {
  ConstEndpoints._();

  static const String merchants = '/merchants';
  static const String products = '/products';
  static const String antree = '/antree';
  static const String antrees = '/antrees';
  static const String detail = '/detail';
  static const String pickup = '/pickup';
  static const String register = '/register';
  static const String login = '/login';
  static const String id = '/{id}';
  static const String seats = '/seats';
  static const String user = '/user';

  static const String _authUserEndpoints = '/auth$user';
  static const String _authMerchantEndpoints = '/auth/merchant';
  // static const String category = '/category';
  static const String updateAntree = '$antree$id';
  static const String antreePickup = '$antree$pickup$id';
  static const String detailAntree = '$antree$detail$id';
  static const String listAntreeUser = '$user$antree$id';
  static const String userRegister = '$_authUserEndpoints$register';
  static const String userLogin = '$_authUserEndpoints$login';
  static const String merchantRegister = '$_authMerchantEndpoints$register';
  static const String merchantLogin = '$_authMerchantEndpoints$login';
  static const String antrianMerchants = '$merchants$antree$id';
  static const String productId = '$products$id';
  static const String detailMerchant = '$merchants$detail$id';
  static const String merchantProducts = '$merchants$products$id';
  // static const String merchantCategory = '$category$id';
  static const String merchantSeats = '$seats$id';
  
}
