import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharek/pages/login_page.dart';
import 'package:sharek/widgets/auth_form_widget.dart';

class RegesterPage extends StatelessWidget {
  const RegesterPage({super.key});
  @override
  Widget build(BuildContext context) {
    final role = ModalRoute.of(context)!.settings.arguments as String?;

    return AuthFormWidget(
      title: "أهلاً بك في شارك 🌿",
      subtitle: "أنشئ حسابك الجديد الآن",
      fields: [
        {
          'label': 'اسم المستخدم',
          'validator': (value) =>
              value == null || value.isEmpty ? 'أدخل اسم المستخدم' : null,
        },
        {
          'label': 'البريد الإلكتروني',
          'validator': (value) {
            if (value == null || value.isEmpty) return 'أدخل البريد الإلكتروني';
            if (!value.contains('@')) return 'البريد الإلكتروني غير صالح';
            return null;
          },
        },
        {
          'label': 'كلمة المرور',
          'obscure': true,
          'validator': (value) {
            if (value == null || value.isEmpty) return 'أدخل كلمة المرور';
            if (value.length < 6) return 'كلمة المرور قصيرة جدًا';
            return null;
          },
        },
        {
          'label': 'تأكيد كلمة المرور',
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
      onSubmit: () {
        Get.to(LoginPage());
      },
    );
  }
}
