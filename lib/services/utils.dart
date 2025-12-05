import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../main.dart';

class Utils {
  Future<bool> connected() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi);
  }

  Future<String> uploadImage(suf, file) async {
    if (!await connected()) {
      Get.snackbar("خطأ في الاتصال", "تأكد من اتصالك بالانترنت وحاول مرة اخرى");
      return "";
    }
    try {
      final ext = file.value!.path.split('.').last;
      final fileName = "$suf-${DateTime.now().millisecondsSinceEpoch}.$ext";
      await cloud.storage
          .from('Images')
          .upload(
            fileName,
            file.value!,
            fileOptions: FileOptions(upsert: true),
          );
      return cloud.storage.from('Images').getPublicUrl(fileName);
    } catch (e) {
      Get.snackbar(
        "خطأ في جلب البانات",
        "حدث خطأ ما اثناء رفع الصورة، حاول مرة اخرى",
      );
      return "";
    }
  }
}
