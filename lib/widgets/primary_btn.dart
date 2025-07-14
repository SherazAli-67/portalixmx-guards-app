import 'package:flutter/material.dart';
import '../../res/app_colors.dart';
import '../res/app_textstyles.dart';
import 'loading_widget.dart';

class PrimaryBtn extends StatelessWidget{
  final VoidCallback onTap;
  final String btnText;
  final Color color;
  final bool isLoading;
  const PrimaryBtn({super.key, required this.onTap, required this.btnText, this.color = AppColors.btnColorDark, this.isLoading = false});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: color
        ),
        onPressed: onTap, child:
    isLoading
        ? LoadingWidget()
        : Text(btnText,style: AppTextStyles.btnTextStyle,));
  }

}