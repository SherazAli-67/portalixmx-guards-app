import 'package:flutter/material.dart';
import 'package:portalixmx_guards_app/features/main_menu/main_menu_page.dart';
import 'package:portalixmx_guards_app/providers/auth_provider.dart';
import 'package:portalixmx_guards_app/providers/home_provider.dart';
import 'package:portalixmx_guards_app/providers/tab_change_provider.dart';
import 'package:portalixmx_guards_app/res/app_colors.dart';
import 'package:portalixmx_guards_app/res/app_constants.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'features/authentication/login_page.dart';

void main() {
  runApp(
      MultiProvider(providers: [
        ChangeNotifierProvider(create: (_)=> TabChangeProvider()),

        ChangeNotifierProvider(create: (_)=> AuthProvider()),
        ChangeNotifierProvider(create: (_)=> HomeProvider()),

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
        home: FutureBuilder(future: _isLoggedIn(), builder: (ctx, snapshot){
          if(snapshot.hasData && snapshot.requireData){
            return MainMenuPage();
          }

          return LoginPage();
        })
    );
  }


  Future<bool> _isLoggedIn()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool isLoggedIn = sharedPreferences.getBool('isLoggedIn') ?? false;

    return isLoggedIn;
  }
}

