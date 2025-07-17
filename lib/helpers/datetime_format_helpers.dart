import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeFormatHelpers{
  static String formatDateTime(DateTime dateTime){
    String formattedDateTime = '';
    DateFormat dateFormat = DateFormat('MMM d, yyyy');
    formattedDateTime = dateFormat.format(dateTime);
    return formattedDateTime;
  }

  static String formatTime(TimeOfDay time){
    String formattedTime = '';
    // DateFormat timeFormat = DateFormat('hh:mm aa');
    // formattedTime = timeFormat.format(DateTime.)
    formattedTime = '${time.hour}:${time.minute} ${time.period.name.toUpperCase()}';
    return formattedTime;
  }
}