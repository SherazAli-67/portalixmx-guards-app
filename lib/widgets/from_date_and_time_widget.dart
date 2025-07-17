import 'package:flutter/material.dart';
import '../helpers/datetime_format_helpers.dart';
import '../res/app_colors.dart';
import '../res/app_textstyles.dart';

class FromDateAndTimeWidget extends StatelessWidget {
  const FromDateAndTimeWidget({
    super.key,
    required String title, required VoidCallback onDateTap, required VoidCallback onTimeTap, DateTime? selectedDate, TimeOfDay? selectedTime, bool showTitle = true
  }): _title = title, _onDateTap = onDateTap, _onTimeTap = onTimeTap, _selectedDate = selectedDate, _selectedTime = selectedTime, _showTitle = showTitle;


  final String _title;
  final VoidCallback _onDateTap;
  final VoidCallback _onTimeTap;
  final DateTime? _selectedDate;
  final TimeOfDay? _selectedTime;
  final bool _showTitle;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 5,
      children: [
        if(_showTitle)
          Text(_title, style: AppTextStyles.regularTextStyle.copyWith(color: AppColors.btnColor),),
        Row(
          spacing: 20,
          children: [
            Expanded(child: Container(
                padding: EdgeInsets.only(left: 15,  top: 2, bottom: 2),
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.borderColor),
                    color: AppColors.fillColorGrey,
                    borderRadius: BorderRadius.circular(8)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_selectedDate != null ? DateTimeFormatHelpers.formatDateTime(_selectedDate) : "Date", style: AppTextStyles.regularTextStyle.copyWith(color: AppColors.greyColor2),),
                    IconButton(onPressed: _onDateTap, icon: Icon(Icons.calendar_month_outlined, color: AppColors.darkGreyColor2,))
                  ],
                )
            ),),
            Expanded(child: Container(
                padding: EdgeInsets.only(left: 15, top: 2, bottom: 2),
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.borderColor),
                    color: AppColors.fillColorGrey,
                    borderRadius: BorderRadius.circular(8)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_selectedTime != null ? DateTimeFormatHelpers.formatTime(_selectedTime) :"Time", style: AppTextStyles.regularTextStyle.copyWith(color: AppColors.greyColor2),),
                    IconButton(onPressed: _onTimeTap, icon: Icon(Icons.access_time, color: AppColors.darkGreyColor2,))
                  ],
                )
            ),)
          ],
        )
      ],
    );
  }
}