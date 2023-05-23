import 'package:antreeorder/models/account.dart';
import 'package:antreeorder/models/user.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class SharedPrefsRepository {
  final SharedPreferences _sharedPreferences;

  SharedPrefsRepository(@factoryMethod this._sharedPreferences);

  final String _accountKey = 'account';

  Account? get account {
    final data = _sharedPreferences.getString(_accountKey);
    return data != null ? accountFromJson(data) : null;
  }

  set account(Account? account) {
    if (account != null) {
      _sharedPreferences.setString(_accountKey, accountToJson(account));
    }
  }

  int get id => user.id;
  User get user => account?.user ?? User();

  void onLogout() {
    _sharedPreferences.remove(_accountKey);
    if (account != null) {
      account = null;
    }
  }
}
