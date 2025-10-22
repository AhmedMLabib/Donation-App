import 'package:flutter/material.dart';

import 'package:get/get.dart';

class NotificationsPage extends StatelessWidget {
  NotificationsPage({super.key});
  final notifications = [
    {
      "title": "تبرع جديد",
      "body": "تمت إضافة تبرع بملابس جديدة في القاهرة.",
      "isRead": false,
    },
    {
      "title": "طلب مساعدة",
      "body": "أحمد طلب مساعدة غذائية عاجلة في الجيزة.",
      "isRead": false,
    },
    {
      "title": "تم قبول طلبك",
      "body": "طلبك للتبرع بالكتب تم قبوله من قبل جمعية الخير.",
      "isRead": true,
    },
    {
      "title": "إشعار متابعة",
      "body": "محمد علّق على تبرعك بالدواء: شكراً جزيلاً",
      "isRead": true,
    },
    {
      "title": "إشعار إداري",
      "body": "برجاء تحديث بيانات حسابك لضمان استمرار الخدمة.",
      "isRead": false,
    },
  ].obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerRight,
          child: Image.asset(
            'assets/images/Logo black.png',
            height: 40,
            color: Color.fromARGB(255, 99, 151, 110),
          ),
        ),
      ),

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Obx(
            () => ListView.builder(
              itemCount: notifications.value.length,
              itemBuilder: (context, index) {
                final Map<String, dynamic> notification =
                    notifications.value[index];
                return Directionality(
                  textDirection: TextDirection.rtl,
                  child: Card(
                    margin: EdgeInsets.only(top: 12),
                    shadowColor: Colors.black,
                    elevation: 12,
                    color: notification["isRead"]
                        ? Colors.white
                        : Color.fromARGB(255, 220, 240, 221),
                    child: ListTile(
                      title: Text(
                        notification["title"],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 99, 151, 110),
                        ),
                      ),
                      subtitle: Text(notification["body"]),
                      trailing: notification["isRead"]
                          ? null
                          : Icon(Icons.circle, color: Colors.blue, size: 8),
                      onTap: () {
                        if (!notification["isRead"]!) {
                          notifications.value[index]["isRead"] = true;
                          notifications.refresh();
                        }
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
