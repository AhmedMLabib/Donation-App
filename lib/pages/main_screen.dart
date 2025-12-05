import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharek/main.dart';
import 'package:sharek/pages/add_page.dart';
import 'package:sharek/pages/home_chat_page.dart';
import 'package:sharek/pages/home_page.dart';
import 'package:sharek/pages/my_donations_page.dart';
import 'package:sharek/pages/my_requests_page.dart';
import 'package:sharek/pages/profile_page.dart';
import 'package:sharek/pages/welcome_page.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final RxInt _currentIndex = 0.obs;

  final pages = [
    HomePage(),
    isLogin ? HomeChatPage() : WelcomePage(),
    if (currentUser["user_role"] == "donor") AddPage(),
    isLogin ? ProfilePage() : WelcomePage(),
    if (isLogin)
      currentUser["user_role"] == 'donor' ? MyDonationsPage() : MyRequestsPage()
    else
      WelcomePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => pages[_currentIndex.value]),
      bottomNavigationBar: Obx(
        () => Directionality(
          textDirection: TextDirection.rtl,
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex.value,
            selectedItemColor: projectColors.secondaryColor,
            unselectedItemColor: Colors.grey,
            onTap: (index) {
              _currentIndex.value = index;
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "الرئيسية",
              ),
              BottomNavigationBarItem(icon: Icon(Icons.chat), label: "دردشة"),
              if (currentUser["user_role"] == "donor")
                BottomNavigationBarItem(
                  icon: Icon(Icons.add_circle_outline),
                  label: "اضافة",
                ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "الحساب",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.mail),
                label: currentUser["user_role"] == "donor"
                    ? "تبرعاتي"
                    : "طلباتي",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
