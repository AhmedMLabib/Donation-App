import 'package:get/get.dart';
import 'package:sharek/services/utils.dart';

import '../main.dart';

class RequestServ {
  sendRequest(item, reqReason, imgFile) async {
    final attachmentUrl = await Utils().uploadImage(imgFile);
    final recipientId = currentUser["user_id"];
    final status = "pending";
    final donorId = item["usersData"]["user_id"];
    final itemId = item["item_id"];
    if (!await Utils().connected()) {
      Get.snackbar("خطأ في الاتصال", "تأكد من اتصالك بالانترنت وحاول مرة اخرى");
      return;
    }
    try {
      await cloud.from("requests").insert({
        "req_reason": reqReason,
        "attachment": attachmentUrl,
        "recipient_id": recipientId,
        "status": status,
        "donor_id": donorId,
        "item_id": itemId,
      });
      Get.back();
    } catch (e) {
      Get.snackbar(
        "خطأ في جلب البانات",
        "حدث خطأ ما اثناء ارسال الطلب، حاول مرة اخرى",
      );
    }
  }
}
