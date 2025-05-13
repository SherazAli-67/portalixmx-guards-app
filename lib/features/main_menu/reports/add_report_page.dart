import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:portalixmx_guards_app/features/main_menu/reports/report_summary_page.dart';
import 'package:portalixmx_guards_app/widgets/bg_gradient_screen.dart';

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
  final TextEditingController _titleTextEditingController = TextEditingController();

  final List<XFile> _pickedImages =  [];
  @override
  void dispose() {
    _titleTextEditingController.dispose();
    _complaintTextEditingController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BgGradientScreen(child: Column(
      spacing: 15,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16, top: 65),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back, color: Colors.white,),),
              Text("Add Reports", style: AppTextStyles.regularTextStyle),
              const SizedBox(width: 40,)
            ],
          ),
        ),
        Expanded(child: Card(
          elevation: 1,
          margin: EdgeInsets.zero,
          color: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30))
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 25),
            child: Column(
              spacing: 16,
              children: [
                const SizedBox(height: 10,),
                AppTextField(textController: _titleTextEditingController, hintText: "Title", fillColor: AppColors.fillColorGrey,),
                AppTextField(textController: _complaintTextEditingController, hintText: "Complaint", fillColor: AppColors.fillColorGrey, maxLines: 5,),
                Row(
                  spacing: 20,
                  children: [
                    Expanded(child: _buildUploadPicturesWidget(title: "Upload Photos", icon: AppIcons.icUploadPhotos, onTap: _onUploadPhotosTap)),
                    Expanded(child: _buildUploadPicturesWidget(title: "Open Camera", icon: AppIcons.icCamera, onTap: _onOpenCameraTap)),

                  ],
                ),
                Expanded(child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, mainAxisSpacing: 20, crossAxisSpacing: 20),

                    itemCount: _pickedImages.length,
                    itemBuilder: (ctx, index){
                      XFile image = _pickedImages[index];
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.file(File(image.path), fit: BoxFit.cover,),
                      );
                    })),
                Padding(
                  padding: const EdgeInsets.only(bottom: 18.0),
                  child: SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: PrimaryBtn(onTap: (){
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=> ReportSummaryPage()));
                    }, btnText: "Submit & Share to A  dmin"),
                  ),
                )
              ],
            ),
          ),
        ))

      ],
    ));
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
}