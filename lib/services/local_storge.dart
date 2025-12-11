import 'package:hive_flutter/hive_flutter.dart';

class LocalStorageService {
  static late Box _box;

  static Future<void> init() async {
    await Hive.initFlutter();
    _box = await Hive.openBox('settings');
  }

  static void saveMode(String mode) {
    _box.put('mode', mode);
  }

  static String loadMode() {
    return _box.get('mode', defaultValue: 'system');
  }

  static void saveCurrentUser(Map user) {
    _box.put('currentUser', user);
  }

  static Map<String, Object> loadCurrentUser() {
    return Map<String, Object>.from(
      _box.get(
        'currentUser',
        defaultValue: {
          'user_id': 0,
          'user_email': '',
          'user_name': '',
          'user_role': '',
          'user_is_verfied': false,
          "user_address": '',
          'user_image_url': '',
        },
      ),
    );
  }

  static void saveIsLogin(bool value) {
    _box.put('isLogin', value);
  }

  static bool loadIsLogin() {
    return _box.get('isLogin', defaultValue: false);
  }
}
