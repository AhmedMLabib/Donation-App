import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharek/Colors/Colors.dart';
import 'package:sharek/main.dart';
import 'package:sharek/pages/profile_details_from_chat_page.dart';
import 'package:sharek/pages/profile_page.dart';

import '../widgets/msg_widget.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, Object>;
    final String name = args["name"] as String;
    final Widget profilePic = args["profilePic"] as Widget;
    final msgCont = TextEditingController();

    // Reactive list for storing messages
    final messages = <Map<String, dynamic>>[].obs;
    var messageCounter = 0.obs;

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
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    Text(
                      "مستخدم موثق",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
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
            // Messages List - Remove reverse: true so newest appears at bottom
            Expanded(
              child: Obx(
                () => ListView.builder(
                  // Removed reverse: true - now messages flow from top to bottom
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    return MessageBubble(
                      key: ValueKey(message['id']),
                      text: message['text'],
                      time: message['time'],
                      isMe: message['isMe'],
                      status: message['status'],
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                textDirection: TextDirection.rtl,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.image,
                      color: Theme.of(context).colorScheme.primary,
                    ),
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
                        hintStyle: TextStyle(
                          color: Theme.of(context).colorScheme.surface,
                        ),
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.primary,
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
                    onPressed: () async {
                      if (msgCont.text.trim().isNotEmpty) {
                        // Add new message to the list
                        messages.add({
                          'id': messageCounter.value++,
                          'text': msgCont.text,
                          'time':
                              '${DateTime.now().hour - 12}:${DateTime.now().minute}',
                          'isMe': true, // Current user's message
                          'status': MessageStatus.sent,
                        });

                        // saved the msg, sender id in a map
                        final Map<String, dynamic> newRow = {
                          'message': msgCont.text,
                          'sender_id': cloud
                              .from("usersData")
                              .select("user_id"),
                          'chat_id': cloud.from("chats").select('chat_id'),
                        };

                        await cloud.from('messages').insert(newRow);

                        // Clear the text field after sending
                        msgCont.clear();
                      }
                    },
                    icon: Icon(
                      Icons.send,
                      color: Theme.of(context).colorScheme.primary,
                    ),
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
