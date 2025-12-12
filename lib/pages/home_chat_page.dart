import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharek/services/home_serv.dart';
import '../main.dart';
import 'chat_page.dart';

class HomeChatPage extends StatelessWidget {
  HomeChatPage({super.key});

  final homeService = HomeServ();
  String formatTime(dynamic time) {
    if (time == null) return "";

    final text = time.toString();

    if (text.contains("T") && text.length >= 16) {
      return text.substring(11, 16); // HH:MM
    }

    if (text.length >= 5) {
      return text.substring(0, 5);
    }

    return text;
  }

  @override
  Widget build(BuildContext context) {
    final myId = currentUser["user_id"] as int;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Align(
          alignment: Alignment.centerRight,
          child: Image.asset(
            'assets/images/Logo black.png',
            height: 40,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: FutureBuilder(
          future: homeService.getUserChats(myId),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final chats = snapshot.data!;

            if (chats.isEmpty) {
              return const Center(child: Text("لا توجد محادثات حالياً"));
            }

            return Directionality(
              textDirection: TextDirection.rtl,
              child: ListView.builder(
                itemCount: chats.length,
                itemBuilder: (context, index) {
                  final chat = chats[index];

                  return InkWell(
                    onTap: () {
                      print("_______________________________");
                      print(chat["other_id"]);
                      Get.to(
                        () => ChatPage(),
                        transition: Transition.rightToLeft,
                        arguments: {
                          "chat_id": chat["chat_id"],
                          "name": chat["user_name"],
                          "profilePic": chat["user_image"],
                          "other_id": chat["other_id"],
                        },
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 25,
                                backgroundImage: chat["user_image"] != null
                                    ? NetworkImage(chat["user_image"])
                                    : null,
                                child: chat["user_image"] == null
                                    ? Icon(
                                        Icons.person,
                                        size: 32,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.primary,
                                      )
                                    : null,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                chat["user_name"],
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onPrimary,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 5),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  chat["last_msg"] ?? "",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onPrimary,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                formatTime(chat["last_time"]),
                                style: TextStyle(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onPrimary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
