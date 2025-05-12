import 'package:flutter/material.dart';
import 'package:portalixmx_guards_app/res/app_colors.dart';

class GuestVerifiedPage extends StatelessWidget{
  const GuestVerifiedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(child: Text("Guest verified"),),
    );
  }

}