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

  loadChats() async {
    try {
      final chat = await cloud.from("chats").select("*");
      return chat;
    } catch (e) {
      print("errorrrr $e");
      Get.snackbar(
        "خطأ في جلب المحادثات",
        "حدث خطأ ما اثناء جلب المحادثات، حاول مرة اخرى",
      );
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getUserChats(int myId) async {
    try {
      final chats = await cloud
          .from("chats")
          .select()
          .or("user_one_id.eq.$myId,user_two_id.eq.$myId");

      List<Map<String, dynamic>> result = [];

      for (final chat in chats) {
        final chatId = chat["chat_id"];
        final userOne = chat["user_one_id"];
        final userTwo = chat["user_two_id"];
        final otherUserId = userOne == myId ? userTwo : userOne;

        final user = await cloud
            .from("usersData")
            .select()
            .eq("user_id", otherUserId)
            .single();

        final msgs = await cloud
            .from("messages")
            .select()
            .eq("chat_id", chatId)
            .order("created_at", ascending: false)
            .limit(1);

        String lastMsg = "";
        String lastTime = "";

        if (msgs.isNotEmpty) {
          lastMsg = msgs[0]["message"];
          lastTime = msgs[0]["created_at"];
        }

        result.add({
          "chat_id": chatId,
          "user_name": user["user_name"],
          "user_image": user["user_image_url"],
          "last_msg": lastMsg,
          "last_time": lastTime,
          "other_id": otherUserId,
        });
      }

      return result;
    } catch (e) {
      print("Error in getUserChats: $e");
      return [];
    }
  }
}
