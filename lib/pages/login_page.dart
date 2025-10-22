import 'package:flutter/material.dart';
import 'package:sharek/widgets/auth_form_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    return AuthFormWidget(
      title: "مرحبًا بك مرة أخرى 🌿",
      subtitle: "سجل دخولك للمتابعة",
      fields: [
        {
          'label': 'البريد الإلكتروني',
          'validator': (value) {
            if (value == null || value.isEmpty) return 'أدخل البريد الإلكتروني';
            return null; // يقبل أي نص بعد ما يملاه للتجربه
          },
        },
        {
          'label': 'كلمة المرور',
          'obscure': true,
          'validator': (value) {
            if (value == null || value.isEmpty) return 'أدخل كلمة المرور';
            return null; //  يقبل أي نص بعد ما يملاه للتجربه
          },
        },
      ],
      buttonText: "تسجيل الدخول",
      onSubmit: () {
        // مؤقت: يشتغل للتجربة
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تم تسجيل الدخول بنجاح (تجريبي)')),
        );
      },
    );
  }
}
