import 'package:flutter/material.dart';
import '../../res/app_colors.dart';
import '../res/app_textstyles.dart';

class PrimaryBtn extends StatelessWidget{
  final VoidCallback onTap;
  final String btnText;
  final Color color;
  const PrimaryBtn({super.key, required this.onTap, required this.btnText, this.color = AppColors.btnColorDark});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: color
        ),
        onPressed: onTap, child: Text(btnText
      ,style: AppTextStyles.btnTextStyle,));
  }

}