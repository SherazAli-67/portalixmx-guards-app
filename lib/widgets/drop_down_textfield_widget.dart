import 'package:flutter/material.dart';
import '../res/app_colors.dart';
import '../res/app_textstyles.dart';

class DropdownTextfieldWidget extends StatelessWidget{
  const DropdownTextfieldWidget(
      {super.key,
        required this.isEmpty,
        required this.selectedValue,
        required this.onChanged,
        required this.guestTypes,
        required this.width,
        required this.hintText,
      });

  final bool isEmpty;
  final String? selectedValue;
  final Function(String? newValue) onChanged;
  final List<String> guestTypes;
  final double width;
  final String hintText;
  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      builder: (FormFieldState<String> state) {
        return InputDecorator(
          decoration: InputDecoration(
            labelStyle: AppTextStyles.hintTextStyle.copyWith(color: AppColors.hintTextColor),
            hintStyle: AppTextStyles.hintTextStyle.copyWith(color: AppColors.hintTextColor),
            contentPadding: EdgeInsets.zero,enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.borderColor)
          ),
            filled: true,
            fillColor: AppColors.fillColorGrey
            // hintText: 'Please select expense',
          ),
          isEmpty: isEmpty,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String >(
              value: selectedValue,
              hint: Text(hintText),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              isDense: true,
              elevation: 0,
              dropdownColor: Colors.white,
              /*onChanged: (PlayerLevelModel? newValue) {
                setState(()=> _selectedPickleBallPlayerLevel = newValue);
              },*/
              onChanged: onChanged,
              items: guestTypes.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

}