import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharek/main.dart';
import 'package:sharek/pages/welcome_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          'ملف المستخدم',
          style: TextStyle(color: Theme.of(context).colorScheme.surface),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(top: 20, bottom: 30),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: Theme.of(context).colorScheme.surface,
                        child: CircleAvatar(
                          radius: 58,
                          backgroundImage: NetworkImage(
                            currentUser['user_image_url'].toString(),
                          ),
                        ),
                      ),
                      if (currentUser['user_is_verfied'] == true)
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surface,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.check_circle,
                              color: Colors.blueAccent,
                              size: 24,
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Text(
                    currentUser['user_name'].toString(),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.surface,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Card(
                elevation: 4,
                color: Theme.of(context).colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    textDirection: TextDirection.rtl,
                    children: [
                      Text(
                        textDirection: TextDirection.rtl,
                        'معلومات الاتصال والأساسية',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.surface,
                        ),
                      ),
                      Divider(color: Theme.of(context).colorScheme.surface),
                      SizedBox(height: 10),
                      buildInfoRow(
                        icon: Icons.email,
                        label: 'البريد الإلكتروني',
                        value: currentUser['user_email'].toString(),
                        textColor: Theme.of(context).colorScheme.surface,
                      ),
                      SizedBox(height: 10),
                      buildInfoRow(
                        icon: Icons.person,
                        label: 'اسم المستخدم',
                        value: currentUser['user_name'].toString(),
                        textColor: Theme.of(context).colorScheme.surface,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Card(
                elevation: 4,
                color: Theme.of(context).colorScheme.primary,

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    textDirection: TextDirection.rtl,
                    children: [
                      Text(
                        'معلومات اضافية',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.surface,
                        ),
                      ),
                      Divider(color: Theme.of(context).colorScheme.surface),
                      SizedBox(height: 10),
                      buildInfoRow(
                        icon: Icons.work,
                        label: 'الدور',
                        value: currentUser['user_role'].toString() == "donor"
                            ? "متبرع"
                            : "مستفيد",
                        textColor: Theme.of(context).colorScheme.surface,
                      ),
                      SizedBox(height: 10),
                      buildInfoRow(
                        icon: Icons.location_on,
                        label: 'العنوان',
                        value: currentUser['user_address'].toString(),
                        textColor: Theme.of(context).colorScheme.surface,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 30),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton.icon(
                onPressed: () {
                  currentUser = {};
                  isLogin = false;
                  cloud.auth.signOut();
                  Get.offAll(WelcomePage());
                },
                icon: Icon(Icons.logout, color: Colors.white),
                label: Text(
                  'تسجيل الخروج',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    required Color textColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        textDirection: TextDirection.rtl,
        children: [
          Icon(icon, color: Colors.grey[600], size: 24),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(fontSize: 16, color: textColor),
                  textDirection: TextDirection.rtl,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
