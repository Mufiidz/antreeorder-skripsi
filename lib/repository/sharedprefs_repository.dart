import 'package:antreeorder/models/account.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class SharedPrefsRepository {
  final SharedPreferences _sharedPreferences;

  SharedPrefsRepository(@factoryMethod this._sharedPreferences);

  final String _accountKey = 'account';
  final String _isOpen = 'isOpen';

  Account? get account {
    final data = _sharedPreferences.getString(_accountKey);
    return data != null ? accountFromJson(data) : null;
  }

  set account(Account? account) {
    if (account != null) {
      _sharedPreferences.setString(_accountKey, accountToJson(account));
    }
  }

  int? get id {
    if (account == null) return null;
    return account?.user.id;
  }

  set id(int? id) => id;

  bool get isOpen => _sharedPreferences.getBool(_isOpen) ?? false;

  set isOpen(bool isOpen) => _sharedPreferences.setBool(_isOpen, isOpen);

  void onLogout() {
    _sharedPreferences.remove(_accountKey);
    if (account != null) {
      account = null;
    }
  }
}
