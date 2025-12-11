import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:sharek/Theme/theme.dart';
import 'package:sharek/pages/main_screen.dart';
import 'package:sharek/services/local_storge.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'Colors/project_colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorageService.init();

  mode.value = LocalStorageService.loadMode();
  currentUser = LocalStorageService.loadCurrentUser();
  isLogin = LocalStorageService.loadIsLogin();
  await Supabase.initialize(
    url: 'https://ymmisbcfqrotkrlfsbzo.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InltbWlzYmNmcXJvdGtybGZzYnpvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTkxNTE5NjQsImV4cCI6MjA3NDcyNzk2NH0.R5UVGkRK6PA7Burfif90El--ypQrtrok5DHhoN0N07g',
  );
  runApp(const MyApp());
}

final cloud = Supabase.instance.client;
var mode = 'system'.obs; // 'light' , 'dark' , 'system'
var isLogin = false;
final projectColors = ProjectColors();
var currentUser = {
  'user_id': 0,
  'user_email': '',
  'user_name': '',
  'user_role': '',
  'user_is_verfied': false,
  "user_address": '',
  'user_image_url': '',
};

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: MainScreen(),
        theme: lightMode,
        darkTheme: darkMode,
        // themeMode: ThemeMode.system,
        themeMode: mode.value == 'system'
            ? ThemeMode.system
            : mode.value == "light"
            ? ThemeMode.light
            : ThemeMode.dark,
      ),
    );
  }
}
