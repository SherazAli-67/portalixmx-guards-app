import 'package:flutter/material.dart';

import '../res/app_icons.dart';

class ScreenWithBgLogo extends StatelessWidget{
  const ScreenWithBgLogo({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Image.asset(
            AppIcons.icScreenBg,
            fit: BoxFit.cover,
            height: size.height*0.5,
          ),
          SafeArea(
            child: child
          ),
        ],
      ),
    );
  }

}