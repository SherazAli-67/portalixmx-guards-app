import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:portalixmx_guards_app/features/main_menu/reports/add_report_page.dart';
import 'package:portalixmx_guards_app/features/main_menu/reports/report_summary_page.dart';
import 'package:portalixmx_guards_app/generated/app_localizations.dart';
import 'package:portalixmx_guards_app/models/report_model.dart';
import 'package:portalixmx_guards_app/providers/reports_provider.dart';
import 'package:portalixmx_guards_app/res/app_icons.dart';
import 'package:portalixmx_guards_app/widgets/loading_widget.dart';
import 'package:provider/provider.dart';

import '../../../helpers/datetime_format_helpers.dart';
import '../../../res/app_colors.dart';
import '../../../res/app_textstyles.dart';

class ReportsPage extends StatelessWidget{
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ReportProvider>(context);
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
                Text(AppLocalizations.of(context)!.reports, style: AppTextStyles.regularTextStyle,),
                IconButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(99)
                      ),
                      backgroundColor: AppColors.btnColor
                    ),
                    onPressed: ()=> _onAddComplaintTap(context),
                    icon: SvgPicture.asset(AppIcons.icAdd))
              ],
            ),
            Expanded(
                child: provider.loadingReport ? Center(child: LoadingWidget()) : ListView.builder(
                    itemCount: provider.allReports.length,
                    itemBuilder: (ctx, index){
                      Report report = provider.allReports[index];
                      return Card(
                        margin: EdgeInsets.only(bottom: 10),
                        child: ListTile(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (_)=> ReportSummaryPage(report: report,)));
                          },
                          contentPadding: EdgeInsets.only(left: 15),
                          title: Text(report.reportText, style: AppTextStyles.tileTitleTextStyle),
                          subtitle: Text(DateTimeFormatHelpers.formatDateTime(report.createdAt), style: AppTextStyles.tileSubtitleTextStyle,),
                          trailing: PopupMenuButton(
                              elevation: 0,
                              color: Colors.white,
                              position: PopupMenuPosition.under,
                              padding: EdgeInsets.zero,
                              icon: Icon(Icons.more_vert_rounded),
                              onSelected: (val){
                                provider.deleteReportByID(report);
                              },
                              itemBuilder: (ctx){
                                return [
                                  PopupMenuItem(
                                      value: 1,
                                      child: Text(AppLocalizations.of(context)!.deleteReport))
                                ];
                              }),
                        ),
                      );
                    }))
          /*  Expanded(child: ListView.builder(
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
                }))*/
          ],
        ),
      ),
    );
  }

  void _onAddComplaintTap(BuildContext context){
    showModalBottomSheet(
        backgroundColor: Colors.white,
        isScrollControlled: true,
        context: context, builder: (ctx){
      return FractionallySizedBox(
        heightFactor: 0.7,
        child: AddReportPage(),
      );
    });
  }
}