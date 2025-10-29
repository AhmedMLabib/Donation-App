import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sharek/main.dart';
import 'package:sharek/services/home_serv.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final notifications = [].obs;
  final readIds = [];
  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    final res = await HomeServ().loadNotifications();
    if (res != notifications) {
      notifications.clear();
      notifications.addAll(res);
    }
  }

  @override
  void dispose() {
    if (readIds.isNotEmpty) {
      markAsRead();
    }
    super.dispose();
  }

  Future<void> markAsRead() async {
    await cloud
        .from("notifications")
        .update({'notification_status': 'read'})
        .inFilter('notification_id', readIds);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerRight,
          child: Image.asset(
            'assets/images/Logo black.png',
            height: 40,
            color: projectColors.mainColor,
          ),
        ),
      ),

      body: RefreshIndicator(
        onRefresh: () async {
          await loadData();
        },
        color: projectColors.mainColor,

        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Obx(
            () => notifications.isNotEmpty
                ? ListView.builder(
                    itemCount: notifications.length,
                    itemBuilder: (context, index) {
                      final Map<String, dynamic> notification =
                          notifications[index];
                      return Directionality(
                        textDirection: TextDirection.rtl,
                        child: Card(
                          margin: EdgeInsets.only(top: 12),
                          shadowColor: Colors.black,
                          elevation: 12,
                          color: notification["notification_status"] == "read"
                              ? Colors.white
                              : Color.fromARGB(255, 220, 240, 221),
                          child: ListTile(
                            title: Text(
                              notification["notification_title"],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: projectColors.mainColor,
                              ),
                            ),
                            subtitle: Text(notification["notification_text"]),
                            trailing:
                                notification["notification_status"] == "read"
                                ? null
                                : Icon(
                                    Icons.circle,
                                    color: Colors.blue,
                                    size: 8,
                                  ),
                            onTap: () {
                              if (notification["notification_status"] ==
                                  "unread") {
                                readIds.add(notification["notification_id"]);
                                notifications[index]["notification_status"] =
                                    "read";
                                notifications.refresh();
                              }
                            },
                          ),
                        ),
                      );
                    },
                  )
                : Center(
                    child: Text(
                      "لا يوجد اشعارات لعرضها",
                      textDirection: TextDirection.rtl,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
