import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharek/services/auth_serv.dart';
import 'package:sharek/widgets/auth_form_widget.dart';

import 'main_screen.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AuthFormWidget(
      title: "🌿 مرحبًا بك مرة أخرى",
      subtitle: "سجل دخولك للمتابعة",
      fields: [
        {
          'label': 'email',
          "controller": emailController,
          'validator': (value) {
            if (value == null || value.isEmpty) return 'أدخل البريد الإلكتروني';
            return null; // يقبل أي نص بعد ما يملاه للتجربه
          },
        },
        {
          'label': 'password',
          "controller": passwordController,
          'obscure': true,
          'validator': (value) {
            if (value == null || value.isEmpty) return 'أدخل كلمة المرور';
            return null; //  يقبل أي نص بعد ما يملاه للتجربه
          },
        },
      ],
      buttonText: "تسجيل الدخول",
      onSubmit: (formData) async {
        await AuthServ().login({
          "email": formData["email"],
          "password": formData['password'],
        });
        Get.offAll(MainScreen());
      },
    );
  }
}
