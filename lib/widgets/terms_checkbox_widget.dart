import 'package:flutter/material.dart';

class TermsCheckboxWidget extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;

  const TermsCheckboxWidget({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(value: value, onChanged: onChanged),
        Expanded(
          child: GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("الشروط والأحكام"),
                  content: const SingleChildScrollView(
                    child: Text('''
مرحبًا بك في تطبيق شارك 👋

1. يجب أن تكون التبرعات حقيقية وصالحة للاستخدام.
2. يُمنع استخدام التطبيق لأي أغراض تجارية.
3. بياناتك تُستخدم فقط لتسهيل التواصل داخل المنصة.
4. مخالفة القواعد تعرض الحساب للإيقاف.
                    ''', textAlign: TextAlign.right),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("موافق"),
                    ),
                  ],
                ),
              );
            },
            child: const Text(
              'أوافق على الشروط والأحكام',
              style: TextStyle(
                fontSize: 14,
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
