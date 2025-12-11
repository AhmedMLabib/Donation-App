import 'package:get/get.dart';
import 'package:sharek/services/home_serv.dart';
import 'package:sharek/services/utils.dart';

import '../main.dart';

class RequestServ {
  sendRequest(item, reqReason, imgFile) async {
    final attachmentUrl = await Utils().uploadImage("req", imgFile);
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

      //*
      final existingChats = await cloud
          .from("chats")
          .select()
          .or(
            "and(user_one_id.eq.$donorId,user_two_id.eq.$recipientId),"
            "and(user_one_id.eq.$recipientId,user_two_id.eq.$donorId)",
          );

      if (existingChats.isEmpty) {
        await cloud.from("chats").insert({
          "user_one_id": donorId,
          "user_two_id": recipientId,
        });
      }

      await HomeServ().addNotification({
        "notification_title": "وصلك طلب جديد من ${currentUser["user_name"]}",
        "notification_text":
            "${currentUser["user_name"]} يطلب ${item["item_name"]}",
        "notification_status": "unread",
        "user_id": donorId,
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
