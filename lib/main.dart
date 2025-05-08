import 'package:flutter/material.dart';
import 'package:portalixmx_guards_app/providers/tab_change_provider.dart';
import 'package:portalixmx_guards_app/res/app_colors.dart';
import 'package:portalixmx_guards_app/res/app_constants.dart';
import 'package:provider/provider.dart';

import 'features/authentication/login_page.dart';

void main() {
  runApp(
      MultiProvider(providers: [
        ChangeNotifierProvider(create: (_)=> TabChangeProvider())
      ], child: const MyApp(),)
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: AppConstants.appTitle,
        theme: ThemeData(
            fontFamily: AppConstants.appFontFamily,
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
            scaffoldBackgroundColor: AppColors.primaryColor,
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              backgroundColor: AppColors.primaryColor,

            )
        ),
        home: LoginPage()
    );
  }
}

