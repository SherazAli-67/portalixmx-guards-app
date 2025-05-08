import 'package:flutter/material.dart';

import '../../res/app_textstyles.dart';
import '../../widgets/app_textfield_widget.dart';
import '../../widgets/bg_logo_screen.dart';
import '../../widgets/primary_btn.dart';
class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {

  final TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ScreenWithBgLogo(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10.0),
        child: Column(
          spacing: 16,
          children: [
            Text("2 Step Verification", style: AppTextStyles.headingTextStyle),
            Text("Enter the 2 step verification code sent on your email address",textAlign: TextAlign.center, style: AppTextStyles.subHeadingTextStyle,),
            const SizedBox(height: 16,),
            AppTextField(textController: _otpController, hintText: "Email",),
            const Spacer(),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: PrimaryBtn(onTap: (){}, btnText: "Submit"),
            ),
            TextButton(onPressed: (){}, child: Text("Need Help", style: AppTextStyles.btnTextStyle,))
          ],
        ),
      ),
    );
  }
}
