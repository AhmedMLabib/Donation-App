import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharek/pages/login_page.dart';
import 'package:sharek/services/auth_serv.dart';
import 'package:sharek/widgets/auth_form_widget.dart';

class RegesterPage extends StatelessWidget {
  RegesterPage({super.key});
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final rePasswordController = TextEditingController();
  final nameController = TextEditingController();
  final roleController = TextEditingController();
  final addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AuthFormWidget(
      title: "🌿 أهلاً بك في شارك",
      subtitle: "أنشئ حسابك الجديد الآن",
      showRole: true,
      fields: [
        {
          'label': 'name',
          'validator': (value) =>
              value == null || value.isEmpty ? 'أدخل اسم المستخدم' : null,
        },
        {
          'label': 'address',
          'validator': (value) =>
              value == null || value.isEmpty ? 'أدخل العنوان ' : null,
        },
        {
          'label': 'email',
          'validator': (value) {
            if (value == null || value.isEmpty) return 'أدخل البريد الإلكتروني';
            if (!value.contains('@')) return 'البريد الإلكتروني غير صالح';
            return null;
          },
        },
        {
          'label': 'password',
          'obscure': true,
          'validator': (value) {
            if (value == null || value.isEmpty) return 'أدخل كلمة المرور';
            if (value.length < 6) return 'كلمة المرور قصيرة جدًا';
            return null;
          },
        },
        {
          'label': 'rePassword',
          'obscure': true,
          'validator': (value) {
            if (value != null && value.isEmpty) {
              return 'كلمة المرور غير متطابقة';
            }
            return null;
          },
        },
      ],
      buttonText: "إنشاء الحساب",
      onSubmit: (formData) async {
        await AuthServ().signUp(formData);
        Get.to(LoginPage());
      },
    );
  }
}
