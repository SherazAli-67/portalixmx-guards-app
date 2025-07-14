import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:portalixmx_guards_app/features/main_menu/main_menu_page.dart';
import 'package:portalixmx_guards_app/providers/auth_provider.dart';
import 'package:provider/provider.dart';

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
  late AuthProvider provider;
  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AuthProvider>(context);
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
              child: PrimaryBtn(onTap: _onVerifyOTPTap, btnText: "Submit", isLoading: provider.isVerifyingOTP,),
            ),
            TextButton(onPressed: (){}, child: Text("Need Help", style: AppTextStyles.btnTextStyle,))
          ],
        ),
      ),
    );
  }

  void _onVerifyOTPTap() async{
    String otp = _otpController.text.trim();
    if(otp.isEmpty){
      return;
    }
    debugPrint("Otp: $otp");
    bool result = await provider.onVerifyOTPTap(otp: otp,);
    if(result){
      Navigator.of(context).push(MaterialPageRoute(builder: (_)=> MainMenuPage()));
    }else{
      Fluttertoast.showToast(msg: "Invalid otp, Try again");
    }
  }
}
