import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:portalixmx_guards_app/providers/reports_provider.dart';
import 'package:provider/provider.dart';
import '../../../generated/app_localizations.dart';
import '../../../res/app_colors.dart';
import '../../../res/app_icons.dart';
import '../../../res/app_textstyles.dart';
import '../../../widgets/app_textfield_widget.dart';
import '../../../widgets/primary_btn.dart';

class AddReportPage extends StatefulWidget{
  const AddReportPage({super.key});

  @override
  State<AddReportPage> createState() => _AddReportPageState();
}

class _AddReportPageState extends State<AddReportPage> {
  final TextEditingController _complaintTextEditingController = TextEditingController();
  final List<XFile> _pickedImages =  [];
  @override
  void dispose() {
    _complaintTextEditingController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 25),
      child: Column(
        spacing: 15,
        children: [
          Text(AppLocalizations.of(context)!.reports, style: AppTextStyles.bottomSheetHeadingTextStyle,),
          const SizedBox(height: 10,),
          AppTextField(textController: _complaintTextEditingController, hintText: AppLocalizations.of(context)!.writeAboutTheReport, fillColor: AppColors.fillColorGrey, maxLines: 5,),
          Row(
            spacing: 20,
            children: [
              Expanded(child: _buildUploadPicturesWidget(title: AppLocalizations.of(context)!.uploadPhotos, icon: AppIcons.icUploadPhotos, onTap: _onUploadPhotosTap)),
              Expanded(child: _buildUploadPicturesWidget(title: AppLocalizations.of(context)!.openCamera, icon: AppIcons.icCamera, onTap: _onOpenCameraTap)),

            ],
          ),
          Expanded(child: ListView.builder(
              itemCount: _pickedImages.length,
              itemBuilder: (ctx, index){
                XFile image = _pickedImages[index];
                return Column(
                  children: [
                    Row(
                      children: [
                        Expanded(child: Text(AppLocalizations.of(context)!.imageUploaded(index+1), style: AppTextStyles.tileTitleTextStyle.copyWith(color: AppColors.primaryColor),)),
                        IconButton(onPressed: (){
                          _pickedImages.remove(image);
                          setState(() {});
                        }, icon: Icon(Icons.delete))
                      ],
                    ),
                    if(index != _pickedImages.length-1)
                      Divider()
                  ],
                );
              })),
          Consumer<ReportProvider>(builder: (ctx,provider, _){
            return  Padding(
              padding: const EdgeInsets.only(bottom: 18.0),
              child: SizedBox(
                height: 50,
                width: double.infinity,
                child: PrimaryBtn(onTap: _onAddComplaintTap, btnText: AppLocalizations.of(context)!.submit, isLoading: provider.addingReport,),
              ),
            );
          })
        ],
      ),
    );
  }

  Widget _buildUploadPicturesWidget({required String title, required VoidCallback onTap, required String icon}) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.fillColorGrey,
            elevation: 0,
            padding: EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            )
        ),
        onPressed: onTap, child: Column(
      spacing: 12,
      children: [
        SvgPicture.asset(icon),
        Text(title, style: AppTextStyles.hintTextStyle.copyWith(
            fontWeight: FontWeight.w400, color: Color(0xff777777)),)
      ],
    ));
  }

  void _onUploadPhotosTap()async{
    final imagePicker = ImagePicker();
    List<XFile> pickedFiles = await imagePicker.pickMultiImage();
    if(pickedFiles.isNotEmpty){
      _pickedImages.addAll(pickedFiles) ;
      setState(() {});
    }
  }

  void _onOpenCameraTap()async{
    final imagePicker = ImagePicker();
    XFile? pickedFiles = await imagePicker.pickImage(source: ImageSource.camera);
    if(pickedFiles != null){
      _pickedImages.add(pickedFiles) ;
      setState(() {});
    }
  }

  void _onAddComplaintTap()async{
    String complaint = _complaintTextEditingController.text.trim();
    List<File> files = _pickedImages.map((image)=> File(image.path)).toList();

    final maintenanceProvider = Provider.of<ReportProvider>(context, listen: false);
    bool result = await maintenanceProvider.addReport(files: files, complaint: complaint);
    if(result){
      Navigator.of(context).pop();
    }
  }
}