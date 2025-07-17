import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:portalixmx_guards_app/providers/home_provider.dart';
import 'package:portalixmx_guards_app/widgets/bg_gradient_screen.dart';
import 'package:provider/provider.dart';

import '../../../generated/app_localizations.dart';
import '../../../providers/profile_provider.dart';
import '../../../res/app_constants.dart';
import '../../../res/app_icons.dart';
import '../../../res/app_textstyles.dart';
import '../../../widgets/app_textfield_widget.dart';
import '../../../widgets/primary_btn.dart';

class EditProfilePage extends StatefulWidget{
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {

  late String _userName;
  late String _emailAddress;

  late String _userPhone;

  late ProfileProvider provider;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      final provider = Provider.of<ProfileProvider>(context, listen: false);
      _userName = provider.user!.name;
      _emailAddress = provider.user!.email;
      _userPhone = provider.user!.mobile;
      setState(() {});
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    provider = Provider.of<ProfileProvider>(context);
    return BgGradientScreen(child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 65.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BackButton(color: Colors.white,),
              Text(AppLocalizations.of(context)!.profile, style: AppTextStyles.regularTextStyle,),
              const SizedBox(width: 40,)
            ],
          ),
        ),
        Expanded(
          child: SizedBox(
            width: double.infinity,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                    top: 65,
                    right: 0,
                    left: 0,
                    child: Card(
                        color: Colors.white,
                        elevation: 1,
                        margin: EdgeInsets.zero,
                        child: Padding(padding: EdgeInsets.only(top: 100, right: 15, left: 15,),
                          child: SizedBox(
                            height: size.height*0.7,
                            child: ListView(
                              children: [
                                EditProfileItemWidget(
                                  title: AppLocalizations.of(context)!.name,
                                  value: _userName,
                                  onTap: (){
                                    _onEditTap(title: AppLocalizations.of(context)!.name, value: _userName, onUpdated: (val) {
                                      if(val.isNotEmpty){
                                        _userName = val;
                                        setState(() {});
                                      }
                                    });
                                  },),
                                EditProfileItemWidget(
                                  title: AppLocalizations.of(context)!.email,
                                  value: _emailAddress,
                                  onTap: (){},),
                                EditProfileItemWidget(
                                  title: AppLocalizations.of(context)!.phone,
                                  value: _userPhone,
                                  onTap: (){
                                    _onEditTap(title: AppLocalizations.of(context)!.phone,  value: _userPhone, onUpdated: (val) {
                                      if(val.isNotEmpty){
                                        _userPhone = val;
                                        setState(() {});
                                      }
                                    });
                                  },),
                                EditProfileItemWidget(
                                  title: AppLocalizations.of(context)!.password, value: "*********", onTap: () {},),

                                const SizedBox(height: 30,),

                                Padding(
                                  padding: EdgeInsets.only(top: 40,bottom: size.height*0.05),
                                  child: Consumer<ProfileProvider>(
                                      builder: (context, provider,  _) {
                                        return SizedBox(
                                          height: 50,
                                          width: double.infinity,
                                          child: PrimaryBtn(onTap: _onUpdateTap, btnText: AppLocalizations.of(context)!.update, isLoading: provider.updatingProfile,),
                                        );
                                      }
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                    )),
                Column(
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
                    Text(_userName, style: AppTextStyles.bottomSheetHeadingTextStyle.copyWith(color: Colors.black),),
                    /*  InkWell(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> EditProfilePage()));
                        },
                        child: Text("View Profile", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black),))*/
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    ));
  }

  void _onEditTap({required String title, required String value, required Function(String updatedVal) onUpdated}){
    TextEditingController editingController = TextEditingController(text: value);
    showModalBottomSheet(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))),
        context: context,
        isScrollControlled: true,
        builder: (ctx){
          return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                spacing: 16,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(AppLocalizations.of(context)!.editProfile, style: AppTextStyles.tileTitleTextStyle,),
                      IconButton(onPressed: ()=> Navigator.of(context).pop(), icon: Icon(Icons.close_rounded))
                    ],
                  ),
                  Text(AppLocalizations.of(context)!.updateYour(title), style: AppTextStyles.btnTextStyle.copyWith(color: Colors.black),),
                  AppTextField(textController: editingController, hintText: title)
                ],
              ),
            ),
          );
        }).then((_){
      onUpdated(editingController.text.trim());
      editingController.dispose();
    });
  }

  Future<void> _onUpdateTap() async {


    final map = {
      'name' : _userName,
      'mobile' : _userPhone,
      "additionalDetails": {
        "vehicleName": provider.user!.additionalDetails.vehicleName,
        "color":  provider.user!.additionalDetails.color,
        "licensePlate": provider.user!.additionalDetails.licensePlate,
        "registrationNumber": provider.user!.additionalDetails.registrationNumber
      },
      "emergencyContacts": provider.user!.emergencyContacts
    };

    final userProvider = Provider.of<HomeProvider>(context, listen: false);
    bool result = await context.read<ProfileProvider>().updateUserProfile(data: map);
    if(result){
      userProvider.setUserName(name: _userName);
      Fluttertoast.showToast(msg: AppLocalizations.of(context)!.profileInfoUpdated);
      Navigator.of(context).pop();
    }
  }
}

class EditProfileItemWidget extends StatelessWidget {
  const EditProfileItemWidget({
    super.key,
    required String title, required String value, required VoidCallback onTap, List<String>? emergencyContacts
  }): _title = title, _value = value, _onTap = onTap, _emergencyContacts = emergencyContacts;
  final String _title;
  final String _value;
  final VoidCallback _onTap;
  final List<String>? _emergencyContacts;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        spacing: 5,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(_title, style: AppTextStyles.editProfileHeadingTextStyle,),
              InkWell(onTap: _onTap, child: SvgPicture.asset(AppIcons.icProfileEdit))
            ],
          ),
          _emergencyContacts == null ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_value, style: AppTextStyles.editProfileSubHeadingTextStyle,),
              Divider()
            ],
          ) : Column(
            spacing: 10,
            children: _emergencyContacts.map((contact){
              return Text(contact, style: AppTextStyles.editProfileSubHeadingTextStyle,);
            }).toList(),
          )


        ],
      ),
    );
  }
}