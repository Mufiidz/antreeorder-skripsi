import 'package:antreeorder/config/local/dao/category_dao.dart';
import 'package:antreeorder/models/account.dart';
import 'package:antreeorder/models/user.dart';
import 'package:antreeorder/utils/export_utils.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class SharedPrefsRepository {
  final SharedPreferences _sharedPreferences;
  final CategoryDao _categoryDao;

  SharedPrefsRepository(this._sharedPreferences, this._categoryDao);

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
    try {
      _categoryDao.deleteAll();
      _sharedPreferences.remove(_accountKey);
    } catch (e) {
      logger.e(e);
    }
    if (account != null) {
      account = null;
    }
  }
}
