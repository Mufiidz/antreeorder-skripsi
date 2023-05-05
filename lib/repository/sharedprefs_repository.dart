import 'package:antreeorder/models/account.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class SharedPrefsRepository {
  final SharedPreferences _sharedPreferences;

  SharedPrefsRepository(@factoryMethod this._sharedPreferences);

  final String _isUserKey = 'isUser';
  final String _accountKey = 'account';

  Account? get account {
    final data = _sharedPreferences.getString(_accountKey);
    return data != null ? Account.fromJson(data) : null;
  }

  set account(Account? account) {
    if (account != null) {
      _sharedPreferences.setString(_accountKey, account.toEncode());
    }
  }

  String get id {
    if (account == null) return '';
    final isMerchant = account?.isMerchant ?? true;
    return (isMerchant ? account?.merchant?.id : account?.user?.id) ?? '';
  }

  set id(String id) => id;

  bool get isUser => _sharedPreferences.getBool(_isUserKey) ?? true;

  set isUser(bool isUser) => _sharedPreferences.setBool(_isUserKey, isUser);

  void onLogout() {
    _sharedPreferences.remove(_accountKey);
  }
}
