import 'package:get/get.dart';

import '../main.dart';
import 'utils.dart';

class RequestsServ {
  loadData() async {
    if (!await Utils().connected()) {
      Get.snackbar("خطأ في الاتصال", "تأكد من اتصالك بالانترنت وحاول مرة اخرى");
      return [];
    }
    try {
      final currentID = currentUser["user_id"] as int;
      final itemsRes = await cloud
          .from("requests")
          .select("*")
          .eq("recipient_id", currentID);
      print(itemsRes);
      print(currentID);
      return itemsRes;
    } catch (e) {
      Get.snackbar(
        "خطأ في جلب البانات",
        "حدث خطأ ما اثناء جلب البيانات، حاول مرة اخرى",
      );
      return [];
    }
  }

  deleteRequest(int reqId) async {
    if (!await Utils().connected()) {
      Get.snackbar("خطأ في الاتصال", "تأكد من اتصالك بالانترنت وحاول مرة اخرى");
      return false;
    }
    try {
      final response = await cloud
          .from("requests")
          .delete()
          .eq("request_id", reqId);
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
