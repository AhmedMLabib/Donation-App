import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharek/pages/login_page.dart';
import 'package:sharek/services/auth_serv.dart';
import 'package:sharek/widgets/auth_form_widget.dart';

import '../services/location_serv.dart';

final locationService = LocationService();

class RegesterPage extends StatefulWidget {
  const RegesterPage({super.key});

  @override
  State<RegesterPage> createState() => _RegesterPageState();
}

class _RegesterPageState extends State<RegesterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final rePasswordController = TextEditingController();
  final nameController = TextEditingController();
  final roleController = TextEditingController();

  // Controller for address field
  final addressController = TextEditingController();
  var pass = '';
  @override
  void initState() {
    super.initState();
    loadLocation();
  }

  Future<void> loadLocation() async {
    final address = await locationService.getLocation();
    setState(() {
      addressController.text = address;
    });
  }

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
          'controller': addressController,
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
            pass = value;
            if (value == null || value.isEmpty) return 'أدخل كلمة المرور';
            if (value.length < 6) return 'كلمة المرور قصيرة جدًا';
            return null;
          },
        },
        {
          'label': 'rePassword',
          'obscure': true,
          'validator': (value) {
            if (value == null || value.isEmpty) return 'أدخل كلمة المرور';
            if (value.length < 6) return 'كلمة المرور قصيرة جدًا';
            if (pass != value) return 'كلمة المرور غير مطابقة';
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
