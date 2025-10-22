import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharek/Colors/Colors.dart';
import 'package:sharek/pages/profile_details_from_chat_page.dart';
import 'package:sharek/pages/profile_page.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, Object>;
    final String name = args["name"] as String;
    final Widget profilePic = args["profilePic"] as Widget;
    final msgCont = TextEditingController();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              profilePic,
              const SizedBox(width: 6),
              InkWell(
                onTap: () => Get.to(ProfilePage()),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: mainColorDark,
                      ),
                    ),
                    Text(
                      "مستخدم موثق",
                      style: TextStyle(
                        color: secondaryColorLight,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {
                Get.to(
                  () => ProfileDetailsFromChat(),
                  transition: Transition.rightToLeft,
                  arguments: [name, profilePic],
                );
              },
              icon: const Icon(Icons.more_vert, size: 28),
            ),
          ],
          backgroundColor: secondaryColor,
        ),
        body: Column(
          children: [
            Expanded(child: ListView(children: const [])),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                textDirection: TextDirection.rtl,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.image, color: mainColor),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: msgCont,
                      minLines: 1,
                      maxLines: 4,
                      keyboardType: TextInputType.multiline,
                      textDirection: TextDirection.rtl,
                      decoration: InputDecoration(
                        hintText: "اكتب رسالة...",
                        hintStyle: TextStyle(color: Colors.grey.shade500),
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 14,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.send, color: mainColor),
                  ),
                ],
              ),
            ),
          ],
        ),

      ),
    );
  }
}
