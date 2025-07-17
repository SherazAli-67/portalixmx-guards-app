import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:portalixmx_guards_app/features/main_menu/main_menu_page.dart';
import 'package:portalixmx_guards_app/generated/app_localizations.dart';
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
            Text(AppLocalizations.of(context)!.twoStepVerification, style: AppTextStyles.headingTextStyle),
            Text(AppLocalizations.of(context)!.twoStepVerificationDescription,textAlign: TextAlign.center, style: AppTextStyles.subHeadingTextStyle,),
            const SizedBox(height: 16,),
            AppTextField(textController: _otpController, hintText: AppLocalizations.of(context)!.email, textInputType: TextInputType.number,),

            const Spacer(),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: PrimaryBtn(onTap: _onVerifyOTPTap, btnText: AppLocalizations.of(context)!.submit, isLoading: provider.isVerifyingOTP,),
            ),
            TextButton(onPressed: (){}, child: Text(AppLocalizations.of(context)!.needHelp, style: AppTextStyles.btnTextStyle,))
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
    bool result = await provider.onVerifyOTPTap(otp: otp,);
    if(result){
      Navigator.of(context).push(MaterialPageRoute(builder: (_)=> MainMenuPage()));
    }else{
      Fluttertoast.showToast(msg: AppLocalizations.of(context)!.invalidOTPMessage);
    }
  }
}
