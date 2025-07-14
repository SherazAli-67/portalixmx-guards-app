import 'package:flutter/material.dart';

class DayTimeModel {
  int dayID;
  TimeOfDay? time;
  TimeOfDay? endTime;

  DayTimeModel({required this.dayID, this.time, this.endTime});
}