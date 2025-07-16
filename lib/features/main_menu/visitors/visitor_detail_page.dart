import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:portalixmx_guards_app/features/main_menu/visitors/vistor_info_item_widget.dart';
import 'package:portalixmx_guards_app/models/guest_api_response.dart';
import 'package:portalixmx_guards_app/models/visitor_api_response.dart';
import 'package:portalixmx_guards_app/providers/home_provider.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import '../../../app_data/app_data.dart';
import '../../../l10n/app_localizations.dart';
import '../../../providers/datetime_format_helpers.dart';
import '../../../res/app_colors.dart';
import '../../../res/app_icons.dart';
import '../../../res/app_textstyles.dart';
import '../../../widgets/bg_gradient_screen.dart';
import '../../../widgets/loading_widget.dart';
import '../../../widgets/primary_btn.dart';


class VisitorDetailPage extends StatefulWidget{
  const VisitorDetailPage({super.key, Guest? guest, Visitor? visitor}): _guest = guest, _visitor = visitor;
  final Guest? _guest;
  final Visitor? _visitor;

  @override
  State<VisitorDetailPage> createState() => _VisitorDetailPageState();
}

class _VisitorDetailPageState extends State<VisitorDetailPage> {

  bool _loadingSave = false;

  @override
  Widget build(BuildContext context) {
    return BgGradientScreen(
        paddingFromTop: 50,
        child: Stack(
          children: [
            Column(
              spacing: 11,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(onPressed: ()=> Navigator.of(context).pop(), icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.white,)),
                    Column(
                      children: [
                        Text(widget._guest != null ? widget._guest!.name :widget._visitor!.name, style: AppTextStyles.regularTextStyle,),
                        Text(widget._guest != null ? AppLocalizations.of(context)!.guest : AppLocalizations.of(context)!.regularVisitor, style: AppTextStyles.tileSubtitleTextStyle,)
                      ],
                    ),
                    IconButton(onPressed: ()=> _showEditBottomSheet(context), icon: Icon(Icons.more_vert_rounded, color: Colors.white,))
                  ],
                ),
                Expanded(
                  child: Card(
                    color: Colors.white,
                    elevation: 0,
                    margin: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))
                    ),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(top: 36.0, left: 18, right: 18),
                      child: Column(
                        children: [
                          Row(
                            spacing: 20,
                            children: [
                              Expanded(
                                child: VisitorInfoItemWidget(
                                    title: AppLocalizations.of(context)!.requestedTime,
                                    subTitle: widget._guest != null
                                        ? DateTimeFormatHelpers.formatDateTime(widget._guest!.createdAt)
                                        : DateTimeFormatHelpers.formatDateTime(widget._visitor!.createdAt),
                                    showDivider: true),
                              ),
                              Expanded(
                                  child: VisitorInfoItemWidget(title: AppLocalizations.of(context)!.accessFor, subTitle: '',  showDivider: true)
                              ),
                            ],
                          ),

                          Row(
                            spacing: 20,
                            children: [
                              Expanded(
                                child: VisitorInfoItemWidget(title: AppLocalizations.of(context)!.accessApprovedDate, subTitle:widget._guest != null
                                    ? DateTimeFormatHelpers.formatDateTime(
                                    widget._guest!.updatedAt)
                                    : DateTimeFormatHelpers.formatDateTime(
                                    widget._visitor!.updatedAt), ),
                              ),
                              Expanded(
                                  child: VisitorInfoItemWidget(title: AppLocalizations.of(context)!.contactNum, subTitle: widget._guest != null
                                      ? widget._guest!.contactNumber
                                      : widget._visitor!.contactNumber,)
                              ),
                            ],
                          ),
                          Divider(),
                          widget._guest != null ? _buildGuestDetailPage(context) : _buildVisitorDetailPage(context)

                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            if(_loadingSave)
              Container(
                color: Colors.black45,
                width: double.infinity,
                height: double.infinity,
                child: LoadingWidget(color: AppColors.primaryColor,),
              )
          ],
        ));
  }

  void _showEditBottomSheet(BuildContext context){
    showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context, builder: (ctx){
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 35),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 10,
          children: [
            _buildEditDeleteItem(icon: AppIcons.icEdit, text: AppLocalizations.of(context)!.edit, onTap: (){
              Navigator.of(context).pop();
              showModalBottomSheet(
                  backgroundColor: Colors.white,
                  context: context,
                  isScrollControlled: true,
                  builder: (context) {
                    return FractionallySizedBox(
                      heightFactor: 0.82,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                        // child: AddGuestPage(visitor: widget._visitor, guest: widget._guest,),
                      ),
                    );
                  });
            }),
            _buildEditDeleteItem(icon: AppIcons.icDelete, text: AppLocalizations.of(context)!.delete, onTap: () async {
              debugPrint("on Delete tap");
              bool result = false;
              if(widget._guest != null){
                result = await context.read<HomeProvider>().deleteGuest(guestID: widget._guest!.id);
              }else{
                result = await context.read<HomeProvider>().deleteGuest(guestID: widget._visitor!.id, isVisitor: true);
              }

              if(result){
                Fluttertoast.showToast(msg: "User deleted successfully");
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              }else{
                Fluttertoast.showToast(msg: "Failed to delete user, Try again");
                Navigator.of(context).pop();
              }
            }),

          ],
        ),
      );
    });
  }

  Widget _buildEditDeleteItem({required String icon, required String text, required VoidCallback onTap}) {
    return TextButton(
      onPressed: onTap,
      child: Row(
        spacing: 20,
        children: [
          SvgPicture.asset(icon),
          Text(text, style: AppTextStyles.visitorDetailSubtitleTextStyle,)
        ],
      ),
    );
  }

  Widget _buildGuestDetailPage(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppLocalizations.of(context)!.from, style: AppTextStyles.visitorDetailTitleTextStyle,),
                  Text('${DateFormat('EEEE').format(widget._guest!.fromDate)} - ${widget._guest!.fromTime}',
                    style: AppTextStyles.visitorDetailSubtitleTextStyle,)
                ],
              ),
            ),
            Container(
              height: 1,
              width: double.infinity,
              color: AppColors.dividerColor,
            ),
          ],
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppLocalizations.of(context)!.to,
                    style: AppTextStyles.visitorDetailTitleTextStyle,),
                  Text('${DateFormat('EEEE').format(widget._guest!.toDate)} - ${widget._guest!.toTime}',
                    style: AppTextStyles.visitorDetailSubtitleTextStyle,)
                ],
              ),
            ),
            Container(
              height: 1,
              width: double.infinity,
              color: AppColors.dividerColor,
            ),
          ],
        ),
        const SizedBox(height: 20,),

        // _buildQRImage(),
        const SizedBox(height: 20,),
        SizedBox(
          height: 50,
          width: double.infinity,
          child: PrimaryBtn(onTap: ()=> _shareQrCode(widget._guest != null ? widget._guest!.id : widget._visitor!.id), btnText: AppLocalizations.of(context)!.shareKey, color: AppColors.primaryColor,),
        )
      ],
    );
  }

  Widget _buildVisitorDetailPage(BuildContext context) {
    return Column(
      children: [
        Column(
            children: List.generate(7, (index){
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(AppData.days[index], style: AppTextStyles.visitorDetailTitleTextStyle,),
                        Text(getVisitorTimeByIndex(index), style: AppTextStyles.visitorDetailSubtitleTextStyle,)
                      ],
                    ),
                    Container(
                      height: 1,
                      width: double.infinity,
                      color: AppColors.dividerColor,
                    ),
                  ],
                ),
              );
            })
        ),
        Text(AppLocalizations.of(context)!.qrCode, style: AppTextStyles.visitorDetailTitleTextStyle,),
        // Image.asset(AppIcons.icQRCode),
        const SizedBox(height: 20,),
        SizedBox(
          height: 50,
          width: double.infinity,
          child: PrimaryBtn(onTap: ()=> _shareQrCode(widget._guest != null ? widget._guest!.id : widget._visitor!.id), btnText: AppLocalizations.of(context)!.shareKey, color: AppColors.primaryColor,),
        )
      ],
    );
  }

  String getVisitorTimeByIndex(int index) {
    switch(index){
      case 0:
        return widget._visitor!.moTime ?? '';
      case 1:
        return widget._visitor!.tueTime ?? '';
      case 2:
        return widget._visitor!.wedTime ?? '';
      case 3:
        return widget._visitor!.thuTime ?? '';
      case 4:
        return widget._visitor!.friTime ?? '';
      case 5:
        return widget._visitor!.satTime ?? '';
      case 6:
        return widget._visitor!.sunTime ?? '';

      default:
        return  '';
    }
  }

  void _shareQrCode(String? content) async{
    String userName = widget._guest != null ? widget._guest!.name : widget._visitor!.name;
    if (content != null && content.isNotEmpty) {
      try{
        setState(() => _loadingSave = true);
        Uint8List? capturedImage = await _takeScreenshot();
        final directory = await getTemporaryDirectory();
        final imagePath = '${directory.path}/$userName.png';
        final imageFile = File(imagePath);
        await imageFile.writeAsBytes(capturedImage!);

        // Share the image
        await Share.shareXFiles(
          [XFile(imagePath)],
          text: content,
        );
      }catch(e){
        debugPrint("Failed to share QR Code: ${e.toString()}");
      }
      setState(() => _loadingSave = false);
      // Share.share(content);
    }
  }

  Future<Uint8List?> _takeScreenshot() async{
    Uint8List? uint8List;
    ScreenshotController screenshotController = ScreenshotController();

   /* try{
      uint8List = await screenshotController.captureFromWidget(
        InheritedTheme.captureAll(
            context, _buildQRImage()
        ),
        delay: const Duration(seconds: 1), // Optional delay to ensure rendering
      );
    }catch(e){
      debugPrint('Error while taking screenshot: ${e.toString()}');
    }*/
    return uint8List;
  }

/*  Widget _buildQRImage() {
    final map = {
      'isGuest' : widget._guest != null,
      'userID' : widget._guest != null ? widget._guest!.id : widget._visitor!.id
    };
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SizedBox(
          height: 200,
          child: QrImageView(data: jsonEncode(map)),
        ),
      ),
    );
  }*/
}