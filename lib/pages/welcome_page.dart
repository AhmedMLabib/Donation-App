import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharek/pages/login_page.dart';
import 'package:sharek/pages/regester_page.dart';
import '../widgets/welcome_widget.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // هنا بنجيب الدور اللي اتبعت من الصفحة اللي قبلها
    final role = ModalRoute.of(context)!.settings.arguments as String?;

    return WelcomeWidget(
      title: 'مرحبًا بك!',
      subtitle: role == 'donor'
          ? 'ادخل لتبدأ في التبرع.'
          : 'ادخل لتبدأ في طلب المساعدة.',
      buttons: [
        {
          'text': 'تسجيل الدخول',
          'onPressed': () {
            Get.to(LoginPage());
          },
        },
        {
          'text': 'إنشاء حساب جديد',
          'onPressed': () {
            Get.to(RegesterPage());
          },
        },
      ],
    );
  }
}
