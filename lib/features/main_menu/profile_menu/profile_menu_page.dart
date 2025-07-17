import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:portalixmx_guards_app/helpers/url_launcher_helper.dart';
import 'package:portalixmx_guards_app/providers/profile_provider.dart';
import 'package:portalixmx_guards_app/res/app_constants.dart';
import 'package:provider/provider.dart';

import '../../../generated/app_localizations.dart';
import '../../../res/app_icons.dart';
import '../../../res/app_textstyles.dart';
import '../../../widgets/loading_widget.dart';
import 'edit_profile_page.dart';
import 'emergency_calls_page.dart';

class ProfileMenu extends StatelessWidget{
  const ProfileMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProfileProvider>(context);
    return Center(
      child: Column(
        spacing: 34,
        children: [
          provider.loadingProfile
              ? LoadingWidget()
              : provider.user != null
              ? Padding(
            padding: const EdgeInsets.only(top: 45.0),
            child: Column(
              spacing: 5,
              children: [
                CircleAvatar(
                  radius: 65,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: CachedNetworkImageProvider(provider.user!.image.replaceAll('public', AppConstants.imageBaseUrl)),
                  ),
                ),
                Text(provider.user!.name, style: AppTextStyles.bottomSheetHeadingTextStyle.copyWith(color: Colors.white),),
                InkWell(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> EditProfilePage()));
                    },
                    child: Text(AppLocalizations.of(context)!.viewProfile, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Colors.white),))
              ],
            ),
          )
              : const SizedBox(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileItemWidget(title: AppLocalizations.of(context)!.emergencyCalls, icon: AppIcons.icEmergencyCalls, onTap: ()=> _onEmergencyTap(context)),
              TextButton(onPressed: ()=> UrlLauncherHelper.launchAppUrl(url: AppConstants.privacyPolicy), child: Text(AppLocalizations.of(context)!.privacyPolicy, style: AppTextStyles.tileTitleTextStyle2,)),
              TextButton(onPressed: ()=> provider.onLogoutTap(context), child: Text(AppLocalizations.of(context)!.logout, style: AppTextStyles.tileTitleTextStyle2,)),

            ],
          )

        ],
      ),
    );
  }


  void _onEmergencyTap(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(builder: (_)=> EmergencyCallsPage()));
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