import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:portalixmx_guards_app/features/main_menu/visitors/add_visitor_page.dart';
import 'package:portalixmx_guards_app/features/main_menu/visitors/logs_page.dart';
import 'package:portalixmx_guards_app/features/main_menu/visitors/scan_qr_code_page.dart';
import 'package:portalixmx_guards_app/res/app_icons.dart';
import 'package:provider/provider.dart';

import '../../../models/visitor_api_response.dart';
import '../../../providers/home_provider.dart';
import '../../../res/app_colors.dart';
import '../../../res/app_textstyles.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((_){
      _initVisitors();
    });
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
                            provider.getAllVisitors();
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
                      itemCount: provider.visitors.length,
                      itemBuilder: (ctx, index){

                        Visitor visitor = provider.visitors[index];
                        return Card(
                          margin: EdgeInsets.only(bottom: 10),
                          child: ListTile(
                            // onTap: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> VisitorDetailPage(visitor: visitor,))),
                            contentPadding: EdgeInsets.only(left: 10),
                            leading: CircleAvatar(
                              backgroundColor: AppColors.btnColor,
                              child: Center(
                                child:  Icon(Icons.person, color: Colors.white,),
                              ),
                            ),
                            title: Text(visitor.name, style: AppTextStyles.tileTitleTextStyle,),
                            subtitle: Text(visitor.type, style: AppTextStyles.tileSubtitleTextStyle,),
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

  Future<void> _initVisitors() async {
    final provider = Provider.of<HomeProvider>(context, listen: false);
    Map<String, dynamic>? visitors = await provider.getAllVisitors();
    if(visitors == null){
      debugPrint("Visitors null found");
      /* userProvider.reset();
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_)=> LoginPage()), (val)=> false);*/
    }
  }
}