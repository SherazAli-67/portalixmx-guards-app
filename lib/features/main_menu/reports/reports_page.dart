import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:portalixmx_guards_app/features/main_menu/reports/add_report_page.dart';
import 'package:portalixmx_guards_app/res/app_icons.dart';

import '../../../res/app_colors.dart';
import '../../../res/app_textstyles.dart';

class ReportsPage extends StatelessWidget{
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
        child: Column(
          spacing: 24,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 40,),
                Text("Security Alerts", style: AppTextStyles.regularTextStyle,),
                IconButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(99)
                      ),
                      backgroundColor: AppColors.btnColor
                    ),
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> AddReportPage()));
                    }, icon: SvgPicture.asset(AppIcons.icAdd))
              ],
            ),
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
                          child: SvgPicture.asset(AppIcons.icReports,
                            colorFilter: ColorFilter.mode(index % 2 == 0
                                ? AppColors.btnColor
                                : AppColors.primaryColor, BlendMode.srcIn),),
                        ),
                      ),
                      title: Text("Report Name", style: AppTextStyles.tileTitleTextStyle,),
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