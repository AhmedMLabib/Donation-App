import 'package:flutter/material.dart';
import 'terms_checkbox_widget.dart';

class AuthFormWidget extends StatefulWidget {
  final String title;
  final String subtitle;
  final List<Map<String, dynamic>>
  fields; // كل حقل: label + obscure + validator
  final String buttonText;
  final VoidCallback onSubmit;
  final Color backgroundColor;

  const AuthFormWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.fields,
    required this.buttonText,
    required this.onSubmit,
    this.backgroundColor = const Color(0xFF98BD89),
  });

  @override
  State<AuthFormWidget> createState() => _AuthFormWidgetState();
}

class _AuthFormWidgetState extends State<AuthFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> _controllers = {};
  bool _agreeToTerms = false;

  @override
  void initState() {
    super.initState();
    for (var field in widget.fields) {
      _controllers[field['label']] = TextEditingController();
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
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
                ),
              ),
              const SizedBox(height: 16),
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                widget.subtitle,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/facebook_logo.png',
                    height: 30,
                    width: 30,
                  ),
                  const SizedBox(width: 20),
                  const Text(
                    'أو',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Image.asset('assets/images/google_logo.png', height: 30, width: 30),
                ],
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: Colors.white,
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
                        TermsCheckboxWidget(
                          value: _agreeToTerms,
                          onChanged: (val) =>
                              setState(() => _agreeToTerms = val ?? false),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
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
                              // هنا نقبل أي يوزر مباشرة بدون تسجيل للتجربه
                              widget.onSubmit();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            minimumSize: const Size(double.infinity, 40),
                          ),
                          child: Text(
                            widget.buttonText,
                            style: const TextStyle(color: Colors.white),
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
