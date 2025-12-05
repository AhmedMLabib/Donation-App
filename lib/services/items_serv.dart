import 'package:get/get.dart';

import '../main.dart';
import 'utils.dart';

class ItemsServ {
  loadData() async {
    if (!await Utils().connected()) {
      Get.snackbar("خطأ في الاتصال", "تأكد من اتصالك بالانترنت وحاول مرة اخرى");
      return [];
    }
    try {
      final itemsRes = await cloud
          .from("items")
          .select("*")
          .eq("donor_id", currentUser["user_id"]!);
      return itemsRes;
    } catch (e) {
      Get.snackbar(
        "خطأ في جلب البانات",
        "حدث خطأ ما اثناء جلب البيانات، حاول مرة اخرى",
      );
      return [];
    }
  }
  deleteDonation(int itemId) async {
    if (!await Utils().connected()) {
      Get.snackbar("خطأ في الاتصال", "تأكد من اتصالك بالانترنت وحاول مرة اخرى");
      return false;
    }
    try {
      final response = await cloud
          .from("items")
          .delete()
          .eq("item_id", itemId);
      return true;
    } catch (e) {
      Get.snackbar(
        "خطأ في حذف التبرع",
        "حدث خطأ ما اثناء حذف التبرع، حاول مرة اخرى",
      );
      return false;
    }
  }


}
