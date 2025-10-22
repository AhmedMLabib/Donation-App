import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharek/Colors/Colors.dart';
import 'chat_page.dart';
import 'notifications_page.dart';

class HomeChatPage extends StatelessWidget {
  HomeChatPage({super.key});
  final persons = ["Ahmed", "Ali", "Mahmoud", "Omar", "Hassan"];
  final messages = ["إزيك؟", "تمام وانت؟", "خلصت المشروع؟", "نشوفك بكرة"];
  final times = ["٠٩:١٥ ص", "١٠:٣٠ ص", "١٢:٠٠ م", "٠٥:٠٠ م"];
  final random = Random();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerRight,
          child: Image.asset(
            'assets/images/Logo black.png',
            height: 40,
            color: const Color.fromARGB(255, 99, 151, 110),
          ),
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView.builder(
          itemCount: persons.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                final person = persons[index];
                final profilePic = Icon(
                  Icons.person,
                  color: mainColor,
                  size: 40,
                );
                Get.to(
                  () => ChatPage(),
                  transition: Transition.rightToLeft,
                  arguments: {"name": person, "profilePic": profilePic},
                );
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(color: Colors.white60),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      textDirection: TextDirection.rtl,
                      children: [
                        Icon(Icons.person, color: mainColor, size: 40),
                        const SizedBox(width: 8),
                        Text(
                          persons[index],
                          style: TextStyle(color: mainColor, fontSize: 22),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            messages[random.nextInt(messages.length)],
                            style: TextStyle(color: secondaryColor),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          times[random.nextInt(times.length)],
                          style: TextStyle(color: secondaryColor),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
