import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:sharek/pages/main_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://ymmisbcfqrotkrlfsbzo.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InltbWlzYmNmcXJvdGtybGZzYnpvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTkxNTE5NjQsImV4cCI6MjA3NDcyNzk2NH0.R5UVGkRK6PA7Burfif90El--ypQrtrok5DHhoN0N07g',
  );
  runApp(const MyApp());
}

final isLogin = true;
final userRole = 'donor';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}
