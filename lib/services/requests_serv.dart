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

  deleteRequest(req) async {
    if (!await Utils().connected()) {
      Get.snackbar("خطأ في الاتصال", "تأكد من اتصالك بالانترنت وحاول مرة اخرى");
      return false;
    }
    try {
      final att = req['attachment'];

    if (att != null && att is String && att.isNotEmpty) {
      await Utils().removImage(att);
    }
      final response = await cloud
          .from("requests")
          .delete()
          .eq("request_id", req['request_id']);
      return true;
    } catch (e) {
      print("Error deleting request: $e");
      Get.snackbar(
        "خطأ في حذف التبرع",
        "حدث خطأ ما اثناء حذف التبرع، حاول مرة اخرى",
      );
      return false;
    }
  }
}
