import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:portalixmx_guards_app/features/main_menu/visitors/add_visitor_page.dart';
import 'package:portalixmx_guards_app/features/main_menu/visitors/logs_page.dart';
import 'package:portalixmx_guards_app/features/main_menu/visitors/scan_qr_code_page.dart';
import 'package:portalixmx_guards_app/l10n/app_localizations.dart';
import 'package:portalixmx_guards_app/models/verified_user.dart';
import 'package:portalixmx_guards_app/res/app_icons.dart';
import 'package:provider/provider.dart';

import '../../../models/guest_api_response.dart';
import '../../../models/visitor_api_response.dart';
import '../../../providers/home_provider.dart';
import '../../../res/app_colors.dart';
import '../../../res/app_textstyles.dart';
import 'visitor_detail_page.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedTab = 0;

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context,);
  return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  spacing: 10,
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColors.btnColor,
                      child: Center(
                        child:  Icon(Icons.person, color: Colors.white,),
                      ),
                    ),
                    Text("Welcome ${provider.userName}!", style: AppTextStyles.regularTextStyle,)
                  ],
                ),
                const SizedBox(height: 20,),
                Row(
                  spacing: 20,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: _selectedTab == 0 ?  AppColors.btnColor : Colors.white
                        ),
                        onPressed: (){
                          if(_selectedTab != 0){
                            _selectedTab = 0;

                            setState(() {});
                          }
                        }, child: Text("Visitors", style: AppTextStyles.tabsTextStyle.copyWith(color: _selectedTab == 0 ?  Colors.white : AppColors.primaryColor),)),
            
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: _selectedTab == 1 ?  AppColors.btnColor : Colors.white
                        ),
                        onPressed: (){
                          if(_selectedTab != 1){
                            _selectedTab = 1;
                            // provider.getAllGuests();
                            setState(() {});
                          }
                        }, child: Text("Logs", style: AppTextStyles.tabsTextStyle.copyWith(color: _selectedTab == 1 ?  Colors.white : AppColors.primaryColor),)),
            
                  ],
                ),
                const SizedBox(height: 20,),
                Expanded(
                  child: _selectedTab == 0 ?
                  ListView.builder(
                      itemCount: provider.verifiedUsers.length,
                      itemBuilder: (ctx, index){

                       VerifiedUser user = provider.verifiedUsers[index];
                       String name = user.user.name;
                       String type = user.user is Visitor ? AppLocalizations.of(context)!.regularVisitor : AppLocalizations.of(context)!.guest;

                        return Card(
                          margin: EdgeInsets.only(bottom: 10),
                          child: ListTile(
                            onTap: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (_)=> VisitorDetailPage(visitor: user.user is Visitor ? user.user : null, guest: user.user is Guest ? user.user : null,)))
                            ,
                            contentPadding: EdgeInsets.only(left: 10),
                            leading: CircleAvatar(
                              backgroundColor: AppColors.btnColor,
                              child: Center(
                                child:  Icon(Icons.person, color: Colors.white,),
                              ),
                            ),
                            title: Text(name, style: AppTextStyles.tileTitleTextStyle,),
                            subtitle: Text(type, style: AppTextStyles.tileSubtitleTextStyle,),
                            trailing: PopupMenuButton(
                                elevation: 0,
                                color: Colors.white,
                                position: PopupMenuPosition.under,
                                padding: EdgeInsets.zero,
                                icon: Icon(Icons.more_vert_rounded),
                                onSelected: (val){
                                  // onDeleteTap(visitor);
                                },
                                itemBuilder: (ctx){
                                  return [
                                    PopupMenuItem(
                                        value: 1,
                                        child: Text("Delete Visitor"))
                                  ];
                                }),
                          ),
                        );
                      /*  return Card(
                          margin: EdgeInsets.only(bottom: 10),
                          child: ListTile(
                            // onTap: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> VisitorDetailPage())),
                            contentPadding: EdgeInsets.only(left: 10),
                            leading: CircleAvatar(
                              backgroundColor: AppColors.btnColor,
                              child: Center(
                                child:  Icon(Icons.person, color: Colors.white,),
                              ),
                            ),
                            title: Text("Name", style: AppTextStyles.tileTitleTextStyle,),
                            subtitle: Text("Sep 20, 10:00 AM", style: AppTextStyles.tileSubtitleTextStyle,),
            
                          ),
                        );*/
                      })
                  : LogsPage(),
                )
              ],
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                spacing: 10,
                children: [
                  _buildFAB(icon: AppIcons.icScanner, onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> ScanQRCodePage()));
                  }),
                  _buildFAB(icon: AppIcons.icAdd, onTap: (){
                    showModalBottomSheet(
                        backgroundColor: Colors.white,
                        context: context,
                        isScrollControlled: true,
                        builder: (context) {
                          return FractionallySizedBox(
                            heightFactor: 0.85,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                              child: AddVisitorPage(),
                            ),
                          );
                        });
                  }),
                ],

              )
            )
          ],
        ),
      ),
    );
  }

  FloatingActionButton _buildFAB({required String icon, required VoidCallback onTap}) {
    return FloatingActionButton(
      heroTag: icon,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(99),
        ),
        backgroundColor: AppColors.primaryColor,
        onPressed: onTap,
        child: SvgPicture.asset(icon));
  }


}