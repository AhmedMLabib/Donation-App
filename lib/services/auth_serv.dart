import 'package:get/get.dart';
import 'package:sharek/services/utils.dart';

import '../main.dart';

class AuthServ {
  final utilsServ = Utils();
  Future<void> login(data) async {
    final email = data["email"];
    final password = data["password"];
    final res = await cloud.auth.signInWithPassword(
      email: email,
      password: password,
    );
    final user = res.user;
    if (user != null) {
      isLogin = true;
      final profile = await cloud
          .from('usersData')
          .select()
          .eq('uid', user.id)
          .single();
      currentUser = {
        'user_id': profile['user_id'],
        'user_email': profile['user_email'],
        'user_name': profile['user_name'],
        'user_role': profile['user_role'],
        'user_is_verfied': profile['user_is_verfied'],
        "user_address": profile['user_address'],
        'user_image_url': profile['user_image_url'],
      };
    } else {
      Get.snackbar("err", "login Error");
    }
  }

  Future<void> signUp(data) async {
    final file = data["file"];
    final res = await cloud.auth.signUp(
      email: data["email"],
      password: data["password"],
    );

    final user = res.user;
    if (user != null) {
      final url = await utilsServ.uploadImage(
        data["name"].toString().split(" ").first,
        file,
      );
      await cloud.from('usersData').insert({
        'uid': user.id,
        'user_email': data["email"],
        'user_name': data["name"],
        "user_role": data["role"],
        "user_is_verfied": true,
        "user_address": data["address"],
        "user_image_url": url,
      });
    }
  }
}
