import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'terms_checkbox_widget.dart';

class AuthFormWidget extends StatefulWidget {
  final String title;
  final String subtitle;
  final List<Map<String, dynamic>>
  fields; // كل حقل: label + obscure + validator
  final String buttonText;
  final onSubmit;
  final Color backgroundColor;
  final bool showRole;

  const AuthFormWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.fields,
    required this.buttonText,
    required this.onSubmit,
    this.backgroundColor = const Color(0xFF98BD89),
    this.showRole = false,
  });

  @override
  State<AuthFormWidget> createState() => _AuthFormWidgetState();
}

class _AuthFormWidgetState extends State<AuthFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> _controllers = {};
  final isLoading = false.obs;
  bool _agreeToTerms = false;
  @override
  void initState() {
    super.initState();
    for (var field in widget.fields) {
      if (field['controller'] == null) {
        _controllers[field['label']] = TextEditingController();
      } else {
        _controllers[field['label']] =
            field['controller'] as TextEditingController;
      }
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Map<String, dynamic> _getFormData() {
    final Map<String, dynamic> data = {};
    for (var field in widget.fields) {
      final label = field['label'] as String;
      final controller = _controllers[label];
      data[label] = controller?.text ?? '';
    }
    return data;
  }

  var _selectedRole = "user";
  final file = Rxn<File>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 15),
              Align(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  'assets/images/logo.png',
                  height: MediaQuery.of(context).size.height * 0.3,
                  fit: BoxFit.contain,
                  color: Theme.of(context).colorScheme.surface,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                widget.subtitle,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        ...widget.fields.map(
                          (field) => Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: TextFormField(
                              textDirection: TextDirection.rtl,
                              controller: _controllers[field['label']],
                              obscureText: field['obscure'] ?? false,
                              decoration: InputDecoration(
                                labelText: field['label'],
                                border: const OutlineInputBorder(),
                              ),
                              validator: field['validator'],
                            ),
                          ),
                        ),
                        if (widget.showRole)
                          DropdownButtonFormField<String>(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "اختر نوع الحساب",
                            ),
                            value: _selectedRole,
                            items: const [
                              DropdownMenuItem(
                                value: "user",
                                child: Text("مستفيد"),
                              ),
                              DropdownMenuItem(
                                value: "donor",
                                child: Text("متبرع"),
                              ),
                            ],
                            onChanged: (val) {
                              setState(() {
                                _selectedRole = val!;
                              });
                            },
                            validator: (value) =>
                                value == null ? "اختر نوع الحساب" : null,
                          ),
                        if (widget.showRole)
                          TextButton(
                            onPressed: () async {
                              final picker = ImagePicker();
                              final result = await picker.pickImage(
                                source: ImageSource.gallery,
                              );

                              if (result != null) {
                                file.value = File(result.path);
                              }
                            },
                            child: Text('Profile Image'),
                          ),
                        Obx(
                          () => file.value != null
                              ? Image.file(file.value!, width: 150, height: 150)
                              : SizedBox.shrink(),
                        ),
                        TermsCheckboxWidget(
                          value: _agreeToTerms,
                          onChanged: (val) =>
                              setState(() => _agreeToTerms = val ?? false),
                        ),
                        const SizedBox(height: 20),
                        Obx(
                          () => ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                if (!_agreeToTerms) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'يجب الموافقة على الشروط والأحكام أولاً',
                                      ),
                                    ),
                                  );
                                  return;
                                }
                                isLoading.value = true;
                                // هنا نقبل أي يوزر مباشرة بدون تسجيل للتجربه
                                final formData = _getFormData();
                                if (widget.showRole) {
                                  formData['role'] = _selectedRole;
                                  formData['file'] = file;
                                }
                                widget.onSubmit(formData);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(
                                context,
                              ).colorScheme.primary,
                              minimumSize: const Size(double.infinity, 40),
                            ),
                            child: isLoading.value
                                ? CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.surface,
                                  )
                                : Text(
                                    widget.buttonText,
                                    style: TextStyle(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.surface,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
