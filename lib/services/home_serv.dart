import 'package:get/get.dart';

import '../main.dart';
import 'utils.dart';

class HomeServ {
  loadData() async {
    if (!await Utils().connected()) {
      Get.snackbar("خطأ في الاتصال", "تأكد من اتصالك بالانترنت وحاول مرة اخرى");
      return [[], []];
    }
    try {
      final itemsRes = await cloud
          .from("items")
          .select(
            "*,usersData(user_id,user_name,user_address,user_is_verfied,user_image_url)",
          );

      final catRes = await cloud.from("categories").select("*");
      return [itemsRes, catRes];
    } catch (e) {
      Get.snackbar(
        "خطأ في جلب البانات",
        "حدث خطأ ما اثناء جلب البيانات، حاول مرة اخرى",
      );
      return [[], []];
    }
  }

  loadDistinctCat() async {
    if (!await Utils().connected()) {
      Get.snackbar("خطأ في الاتصال", "تأكد من اتصالك بالانترنت وحاول مرة اخرى");
      return [];
    }
    try {
      final catRes = await cloud
          .from("categories")
          .select("category_id , category");
      print(catRes);
      return catRes;
    } catch (e) {
      Get.snackbar(
        "خطأ في جلب البانات",
        "حدث خطأ ما اثناء جلب البيانات، حاول مرة اخرى",
      );
      return [];
    }
  }

  loadNotifications() async {
    final userID = currentUser['user_id'];
    if (userID != null) {
      if (!await Utils().connected()) {
        Get.snackbar(
          "خطأ في الاتصال",
          "تأكد من اتصالك بالانترنت وحاول مرة اخرى",
        );
        return [];
      }
      try {
        final res = await cloud
            .from("notifications")
            .select("*")
            .eq("user_id", userID);
        return res;
      } catch (e) {
        Get.snackbar(
          "خطأ في جلب البانات",
          "حدث خطأ ما اثناء جلب البيانات، حاول مرة اخرى",
        );
        return [];
      }
    }
  }
}
