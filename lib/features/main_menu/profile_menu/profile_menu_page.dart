import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../res/app_icons.dart';
import '../../../res/app_textstyles.dart';

class ProfileMenu extends StatelessWidget{
  const ProfileMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        spacing: 34,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 45.0),
            child: Column(
              spacing: 5,
              children: [
                CircleAvatar(
                  radius: 65,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: CachedNetworkImageProvider(AppIcons.icUserImageUrl),
                  ),
                ),
                Text("Muhammad Ali", style: AppTextStyles.bottomSheetHeadingTextStyle.copyWith(color: Colors.white),),
                InkWell(
                    onTap: (){
                      // Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> EditProfilePage()));
                    },
                    child: Text("View Profile", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Colors.white),))
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileItemWidget(title: "Emergency Calls", icon: AppIcons.icEmergencyCalls, onTap: ()=> _onEmergencyTap(context)),
              TextButton(onPressed: (){}, child: Text("Privacy Policy", style: AppTextStyles.tileTitleTextStyle2,)),
              TextButton(onPressed: (){}, child: Text("Log out", style: AppTextStyles.tileTitleTextStyle2,)),

            ],
          )

        ],
      ),
    );
  }


  void _onEmergencyTap(BuildContext context){
    // Navigator.of(context).push(MaterialPageRoute(builder: (_)=> EmergencyCallsPage()));
  }
}

class ProfileItemWidget extends StatelessWidget {
  const ProfileItemWidget({
    super.key,
    required String title, required String icon, required VoidCallback onTap,
  }) : _title = title, _icon = icon, _onTap = onTap;

  final String _title;
  final String _icon;
  final VoidCallback _onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: _onTap,
      contentPadding: EdgeInsets.only(left: 15),
      leading: SvgPicture.asset(_icon, colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn)),
      title: Text(_title, style: AppTextStyles.tileTitleTextStyle2),
      trailing: IconButton(onPressed: _onTap, icon: Icon(Icons.navigate_next_rounded, color: Colors.white,)),
    );
  }
}