import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharek/Colors/Colors.dart';
import 'package:sharek/main.dart';
import 'package:sharek/pages/profile_details_from_chat_page.dart';
import 'package:sharek/pages/profile_page.dart';

import '../widgets/msg_widget.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late final TextEditingController msgCont;
  final messages = <Map<String, dynamic>>[].obs;

  String formatTime(dynamic time) {
    if (time == null) return "";
    final text = time.toString();
    if (text.contains("T") && text.length >= 16) {
      return text.substring(11, 16);
    }
    return text;
  }

  @override
  void initState() {
    super.initState();
    msgCont = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadOldMessages());
  }

  @override
  void dispose() {
    msgCont.dispose();
    super.dispose();
  }

  Future<void> _loadOldMessages() async {
    try {
      final args = Get.arguments as Map<String, dynamic>?;
      if (args == null) return;

      final chatId = args["chat_id"];
      final myId = currentUser["user_id"];

      messages.clear();

      final data = await cloud
          .from("messages")
          .select()
          .eq("chat_id", chatId)
          .order("created_at", ascending: true);

      for (var m in data) {
        messages.add({
          'id': m["message_id"] ?? m["id"],
          'text': m["message"] ?? "",
          'time': m["created_at"] != null ? formatTime(m["created_at"]) : "",
          'isMe': m["sender_id"] == myId,
          'status': MessageStatus.sent,
        });
      }
    } catch (e) {
      print("Error loading messages: $e");
      Get.snackbar("خطأ", "فشل في تحميل الرسائل");
    }
  }

  Future<void> _sendMessage() async {
    final args = Get.arguments as Map<String, dynamic>?;
    if (args == null) return;

    final chatId = args["chat_id"];
    final myId = currentUser["user_id"];
    final text = msgCont.text.trim();

    if (text.isEmpty) return;

    final localId = DateTime.now().millisecondsSinceEpoch;
    messages.add({
      'id': localId,
      'text': text,
      'time': formatTime(DateTime.now().toIso8601String()),
      'isMe': true,
      'status': MessageStatus.sending,
    });

    msgCont.clear();

    try {
      final inserted = await cloud
          .from('messages')
          .insert({"chat_id": chatId, "sender_id": myId, "message": text})
          .select()
          .single();

      final idx = messages.indexWhere((m) => m["id"] == localId);
      if (idx != -1) {
        messages[idx] = {
          'id': inserted["message_id"],
          'text': inserted["message"],
          'time': formatTime(inserted["created_at"]),
          'isMe': true,
          'status': MessageStatus.sent,
        };
      }
    } catch (e) {
      print("Error sending: $e");
      Get.snackbar("خطأ", "فشل في إرسال الرسالة");
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    final String name = args["name"] ?? "";
    final profilePic = args["profilePic"];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundImage: profilePic != null
                    ? NetworkImage(profilePic)
                    : null,
                child: profilePic == null ? Icon(Icons.person) : null,
              ),
              SizedBox(width: 6),
              Text(name),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final msg = messages[index];
                    return MessageBubble(
                      text: msg["text"],
                      time: msg["time"],
                      isMe: msg["isMe"],
                      status: msg["status"],
                    );
                  },
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: SafeArea(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 6,
                            offset: Offset(0, -2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(28),
                              ),
                              child: ConstrainedBox(
                                constraints: const BoxConstraints(
                                  maxHeight: 120, // 4 lines
                                ),
                                child: TextField(
                                  controller: msgCont,
                                  keyboardType: TextInputType.multiline,
                                  minLines: 1,
                                  maxLines: 4,
                                  textDirection: TextDirection.rtl,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "اكتب رسالة...",
                                    hintStyle: TextStyle(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.surface,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: Theme.of(
                              context,
                            ).colorScheme.primary,

                            child: IconButton(
                              icon: const Icon(Icons.send, color: Colors.white),
                              onPressed: _sendMessage,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
