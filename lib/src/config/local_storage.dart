// Package imports:
import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  factory Storage() {
    return _singleton;
  }

  Storage._internal();

  static final Storage _singleton = Storage._internal();
  static dynamic _sharedPreferences;

  static dynamic initialize() async {
    // ignore: avoid_dynamic_calls
    _sharedPreferences = await SharedPreferences.getInstance().whenComplete(() {
      return true;
    });
  }

  static dynamic setValue(String key, String value) {
    _sharedPreferences!.setString(key, value);
  }

  static dynamic getValue(String key) {
    if (_sharedPreferences == null) {
      return 'english';
    }
    return _sharedPreferences!.getString(key);
  }

  static dynamic cleanData() {
    return _sharedPreferences!.clear();
  }
}
