import 'package:flutter/material.dart';
import 'package:portalixmx_guards_app/widgets/bg_gradient_screen.dart';
import '../../../res/app_colors.dart';
import '../../../res/app_textstyles.dart';
import '../../../widgets/app_textfield_widget.dart';
import '../../../widgets/drop_down_textfield_widget.dart';
import '../../../widgets/primary_btn.dart';

class AddVisitorPage extends StatefulWidget{
  const AddVisitorPage({super.key});

  @override
  State<AddVisitorPage> createState() => _AddVisitorPageState();
}

class _AddVisitorPageState extends State<AddVisitorPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contactNumberController = TextEditingController();
  final TextEditingController _apartmentNumber = TextEditingController();

  final TextEditingController _carPlatNumberController = TextEditingController();
  final TextEditingController _vehicleModelController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();
  final TextEditingController _purposeOfVisitController = TextEditingController();

  final List<String> _guestType = [
    'Regular Visitor', 'Guest'
  ];
  String? selectedGuestType;

  @override
  void dispose() {
    _nameController.dispose();
    _contactNumberController.dispose();
    _carPlatNumberController.dispose();
    _vehicleModelController.dispose();
    _colorController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BgGradientScreen(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 20,
        children: [
          Padding(padding: EdgeInsets.only(top: 65),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BackButton(color: Colors.white,),
                Text("Add Visitor", style: AppTextStyles.regularTextStyle,),
                const SizedBox(width: 40,)
                // IconButton(onPressed: ()=> _showEditBottomSheet(context), icon: Icon(Icons.more_vert_rounded, color: Colors.white,))
              ],
            ),
          ),

          Expanded(child: Card(
            margin: EdgeInsets.zero,
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30)
            ),
            color: Colors.white,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 27),
              child: Column(
                spacing: 17,
                children: [
                  AppTextField(textController: _nameController, hintText: "Name", fillColor: AppColors.fillColorGrey, hintTextColor: AppColors.hintTextColor, borderColor: AppColors.borderColor,),
                  DropdownTextfieldWidget(isEmpty: selectedGuestType == null, selectedValue: selectedGuestType, onChanged: (val)=> setState(()=> selectedGuestType = val!), guestTypes: _guestType, width: double.infinity, hintText: 'Visitor Type'),
                  AppTextField(textController: _apartmentNumber, hintText: "Apartment Number",fillColor: AppColors.fillColorGrey, hintTextColor: AppColors.hintTextColor, borderColor: AppColors.borderColor,),
                  AppTextField(textController: _carPlatNumberController, hintText: "Car Plate Number",fillColor: AppColors.fillColorGrey, hintTextColor: AppColors.hintTextColor, borderColor: AppColors.borderColor,),
                  AppTextField(textController: _vehicleModelController, hintText: "Vehicle Model",fillColor: AppColors.fillColorGrey, hintTextColor: AppColors.hintTextColor, borderColor: AppColors.borderColor,),
                  AppTextField(textController: _colorController, hintText: "Color",fillColor: AppColors.fillColorGrey, hintTextColor: AppColors.hintTextColor, borderColor: AppColors.borderColor,),

                  AppTextField(textController: _contactNumberController, hintText: "Contact Number",fillColor: AppColors.fillColorGrey, hintTextColor: AppColors.hintTextColor, borderColor: AppColors.borderColor,),
                  AppTextField(textController: _purposeOfVisitController, hintText: "Purpose of visit",fillColor: AppColors.fillColorGrey, hintTextColor: AppColors.hintTextColor, borderColor: AppColors.borderColor,),
                  const SizedBox(height: 20,),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: PrimaryBtn(onTap: (){
                      // Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> VisitorAddedSummaryPage()));
                    }, btnText: "Submit"),
                  )
                ],
              ),
            ),
          ))


        ],
      ),
    );
  }
}

