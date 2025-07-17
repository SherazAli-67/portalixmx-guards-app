import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:portalixmx_guards_app/generated/app_localizations.dart';
import 'package:portalixmx_guards_app/models/guest_api_response.dart';
import 'package:portalixmx_guards_app/models/visitor_api_response.dart';
import 'package:portalixmx_guards_app/providers/home_provider.dart';
import 'package:portalixmx_guards_app/res/app_colors.dart';
import 'package:portalixmx_guards_app/res/app_icons.dart';
import 'package:provider/provider.dart';

import '../../../widgets/loading_widget.dart';

class GuestVerifiedPage extends StatefulWidget{
  const GuestVerifiedPage({super.key, required this.barcode});
  final Barcode barcode;

  @override
  State<GuestVerifiedPage> createState() => _GuestVerifiedPageState();
}

class _GuestVerifiedPageState extends State<GuestVerifiedPage> {
  bool isGuest = false;
  Guest? guest;
  Visitor? visitor;
  bool _isVerified = false;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final provider = Provider.of<HomeProvider>(context, listen: false);

      final map = jsonDecode(widget.barcode.rawValue!);
      String userID = map['userID'];
      if(map['isGuest']){
       guest = await provider.getGuestByID(guestID: userID);
       if(guest != null){
         _isVerified = true;
         provider.addGuestToVerifiedList(guest!);
         setState(() {});
       }
      }else{
        visitor = await provider.getVisitorByID(visitorID: userID);
        if(visitor != null){
          provider.addUserToVerifiedList(visitor!);
          _isVerified = true;
          setState(() {});
        }
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body:  SafeArea(
        child: provider.loadingGuestInfo  || provider.loadingVisitorInfo ? Center(child: LoadingWidget()) : _isVerified ? Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              IconButton(onPressed: ()=> Navigator.of(context).pop(), icon: Icon(Icons.arrow_back, color: Colors.white,)),
              const SizedBox(height: 50,),
              SvgPicture.asset(AppIcons.icGuestVerified),
              Text(AppLocalizations.of(context)!.guestVerified, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: Colors.white),)
            ],
          ),
        ) : const SizedBox(),
      )
    );
  }




}