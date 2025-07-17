import 'package:flutter/material.dart';
import 'package:portalixmx_guards_app/generated/app_localizations.dart';
import 'package:portalixmx_guards_app/res/app_textstyles.dart';

import '../../res/app_colors.dart';

class SecurityAlertPage extends StatelessWidget{
  const SecurityAlertPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
        child: Column(
          spacing: 24,
          children: [
            Text(AppLocalizations.of(context)!.securityAlerts, style: AppTextStyles.regularTextStyle,),
            Expanded(child: ListView.builder(
                itemCount: 10,
                itemBuilder: (ctx, index){
                  return Card(
                    margin: EdgeInsets.only(bottom: 13),
                    child: ListTile(
                      // onTap: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> VisitorDetailPage())),
                      contentPadding: EdgeInsets.only(left: 10),
                      leading: CircleAvatar(
                        backgroundColor: index%2 == 0 ? AppColors.lightBtnColor : AppColors.lightPrimaryColor,
                        child: Center(
                          child:  Icon(Icons.person, color: index%2 == 0 ? AppColors.btnColor : AppColors.primaryColor,),
                        ),
                      ),
                      title: Text("Apartment Name", style: AppTextStyles.tileTitleTextStyle,),
                      subtitle: Text("Sep 20, 10:00 AM", style: AppTextStyles.tileSubtitleTextStyle,),

                    ),
                  );
                }))
          ],
        ),
      ),
    );
  }

}