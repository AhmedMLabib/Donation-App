import 'package:get/get.dart';
import 'package:sharek/services/home_serv.dart';

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

  deleteDonation(item) async {
    if (!await Utils().connected()) {
      Get.snackbar("خطأ في الاتصال", "تأكد من اتصالك بالانترنت وحاول مرة اخرى");
      return false;
    }
    try {
      final att = item['item_image_url'];

      if (att != null && att is String && att.isNotEmpty) {
        await Utils().removImage(att);
      }
      await cloud.from("items").delete().eq("item_id", item['item_id']);
      return true;
    } catch (e) {
      print("Error deleting donation: $e");
      Get.snackbar(
        "خطأ في حذف التبرع",
        "حدث خطأ ما اثناء حذف التبرع، حاول مرة اخرى",
      );
      return false;
    }
  }

  getDonationRequests(itemId) async {
    try {
      return await cloud
              .from("requests")
              .select(
                "*, recipient_id(user_id,user_name, user_address, user_is_verfied , user_image_url)",
              )
              .eq("item_id", itemId)
          as List;
    } catch (err) {
      Get.snackbar(
        "خطأ في جلب الطلبات",
        "حدث خطأ ما اثناء جلب الطلبات، حاول مرة اخرى",
      );
      return [];
    }
  }

  changeItemStatus(status, item, resp_id) async {
    try {
      final res = await cloud
          .from("requests")
          .update({"status": status})
          .eq("item_id", item["item_id"])
          .select("*");

      await HomeServ().addNotification({
        "notification_title": "تحدث جديد لطلبك",
        "notification_text":
            "وافق ${currentUser["user_name"]} علي طلبك ${item["item_name"]}",
        "notification_status": "unread",
        "user_id": resp_id,
      });
      return res;
    } catch (err) {
      Get.snackbar(
        "خطأ في جلب البيانات",
        "حدث خطأ ما اثناء تغيير حالة الطلب حاول مرة اخرى",
      );
      return false;
    }
  }
}
