import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:portalixmx_guards_app/features/main_menu/visitors/add_visitor_page.dart';
import 'package:portalixmx_guards_app/features/main_menu/visitors/logs_page.dart';
import 'package:portalixmx_guards_app/features/main_menu/visitors/scan_qr_code_page.dart';
import 'package:portalixmx_guards_app/res/app_icons.dart';

import '../../../res/app_colors.dart';
import '../../../res/app_textstyles.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selecteedTab = 0;
  @override
  Widget build(BuildContext context) {
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
                    Text("Welcome Alex!", style: AppTextStyles.regularTextStyle,)
                  ],
                ),
                const SizedBox(height: 20,),
                Row(
                  spacing: 20,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: _selecteedTab == 0 ?  AppColors.btnColor : Colors.white
                        ),
                        onPressed: (){
                          if(_selecteedTab != 0){
                            _selecteedTab = 0;
                            setState(() {});
                          }
                        }, child: Text("Visitors", style: AppTextStyles.tabsTextStyle.copyWith(color: _selecteedTab == 0 ?  Colors.white : AppColors.primaryColor),)),
            
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: _selecteedTab == 1 ?  AppColors.btnColor : Colors.white
                        ),
                        onPressed: (){
                          if(_selecteedTab != 1){
                            _selecteedTab = 1;
                            setState(() {});
                          }
                        }, child: Text("Logs", style: AppTextStyles.tabsTextStyle.copyWith(color: _selecteedTab == 1 ?  Colors.white : AppColors.primaryColor),)),
            
                  ],
                ),
                const SizedBox(height: 20,),
                Expanded(
                  child: _selecteedTab == 0 ?
                  ListView.builder(
                      itemCount: 3,
                      itemBuilder: (ctx, index){
                        return Card(
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
                        );
                      })
                  : LogsPage()
                  ,
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
                    Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> AddVisitorPage()));
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