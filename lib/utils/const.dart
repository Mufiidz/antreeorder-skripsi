class Const {
  Const._();

  static const String baseUrl = 'https://api.mufidz.my.id/antree-order';
}

class ConstEndpoints {
  ConstEndpoints._();

  static const String _baseAuthEndpoints = '/auth/user';

  static const String merchants = '/merchants';
  static const String products = '/products';
  static const String antree = '/antree';
  static const String detail = '/detail';
  static const String pickup = '/pickup';
  static const String id = '/{id}';
  static const String antreePickup = '$antree$pickup$id';
  static const String detailAntree = '$antree$detail$id';
  static const String register = '$_baseAuthEndpoints/register';
  static const String login = '$_baseAuthEndpoints/login';
}
