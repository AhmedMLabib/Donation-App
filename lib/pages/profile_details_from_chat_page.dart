import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharek/Colors/Colors.dart';

class ProfileDetailsFromChat extends StatelessWidget {
  ProfileDetailsFromChat({super.key});
  final RxBool notificationVal = true.obs;
  final RxBool pinChatVal = false.obs;

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments;
    final String name = args[0];
    final Widget profilePic = args[1];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Column(
              children: [
                profilePic,
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Obx(
              () => settingsTile(
                icon: Icons.notifications,
                text: "كتم الإشعارات",
                trailing: Switch(
                  value: notificationVal.value,
                  onChanged: (v) => notificationVal.value = v,
                ),
              ),
            ),
            Obx(
              () => settingsTile(
                icon: Icons.vertical_align_top,
                text: "تثبيت المحادثة",
                trailing: Switch(
                  value: pinChatVal.value,
                  onChanged: (v) => pinChatVal.value = v,
                ),
              ),
            ),
            settingsTile(
              icon: Icons.report,
              text: "حظر $name",
              textColor: Colors.red,
              onTap: () {
                Get.snackbar(
                  "",
                  "$name تم حظره",
                  snackPosition: SnackPosition.TOP,
                  messageText: Text(
                    "$name تم حظره",
                    textDirection: TextDirection.rtl,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget settingsTile({
    required IconData icon,
    required String text,
    Color? textColor,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 80,
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: mainColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          textDirection: TextDirection.rtl,
          children: [
            Icon(icon, color: textColor ?? Colors.white, size: 32),
            const SizedBox(width: 8),
            Text(
              text,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: textColor ?? Colors.white,
              ),
            ),
            const Spacer(),
            if (trailing != null) trailing,
          ],
        ),
      ),
    );
  }
}
