import 'package:flutter/material.dart';
import 'package:portalixmx_guards_app/generated/app_localizations.dart';
import 'package:portalixmx_guards_app/helpers/url_launcher_helper.dart';
import 'package:portalixmx_guards_app/models/emergency_contact_response.dart';
import 'package:portalixmx_guards_app/providers/profile_provider.dart';
import 'package:provider/provider.dart';

import '../../../res/app_colors.dart';
import '../../../res/app_textstyles.dart';
import '../../../widgets/bg_gradient_screen.dart';

class EmergencyCallsPage extends StatelessWidget {
  const EmergencyCallsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProfileProvider>(context);
    return BgGradientScreen(
        paddingFromTop: 50,
        child: Column(
          spacing: 11,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(onPressed: ()=> Navigator.of(context).pop(), icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.white,)),
                Text(AppLocalizations.of(context)!.emergencyCommunication, style: AppTextStyles.regularTextStyle,),
                const SizedBox(width: 40,)
              ],
            ),
            Expanded(
              child: Card(
                color: AppColors.lightGreyBackgroundColor,
                elevation: 0,
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 18, right: 18),
                  child: ListView.builder(
                      itemCount: provider.emergencyContacts.length,
                      itemBuilder: (ctx, index){
                        EmergencyContact contact = provider.emergencyContacts[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Material(
                            color: AppColors.greyColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)
                            ),
                            child: ListTile(
                              onTap: ()=> UrlLauncherHelper.makingPhoneCall(phoneNum: contact.contactNumber),
                              contentPadding: EdgeInsets.only(top: 8, bottom: 8, left: 15, right: 10),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              leading: CircleAvatar(
                                backgroundColor: AppColors.btnColor,
                                child: Center(child: Icon(Icons.person, color: Colors.white,),),
                              ),
                              tileColor: Colors.white,
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(contact.name, style: AppTextStyles.tileTitleTextStyle,),
                                  Text(contact.contactNumber, style: AppTextStyles.tileSubtitleTextStyle,)
                                ],
                              ),
                              trailing: CircleAvatar(
                                radius: 25,
                                backgroundColor: AppColors.primaryColor,
                                child: Center(
                                  child: Icon(Icons.call, color: Colors.white,),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ),
            )
          ],
        ));
  }

}