import 'package:dagu/features/authentication/views/onboarding/onboarding.dart';
import 'package:dagu/features/authentication/views/signup/signup.dart';
import 'package:dagu/features/personalization/views/preferences_choice.dart';
import 'package:dagu/features/personalization/views/news_homepage.dart';
import 'package:dagu/features/profile_management/user_profile_details.dart';
import 'package:dagu/features/profile_management/user_profile_edit.dart';
import 'package:dagu/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'features/authentication/views/login/login.dart';
import 'features/authentication/views/success_messages/successfully_changed_password.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: DaguAppTheme.lightTheme,
      darkTheme: DaguAppTheme.darkTheme,
      home: const LoginView(),
    );
  }
}
