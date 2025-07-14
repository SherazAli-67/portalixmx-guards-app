import 'package:flutter/material.dart';

class LogsUserModel {
  String imageUrl;
  String name;
  DateTime dateTime;
  TimeOfDay timeOfDay;
  String contactNumber;

  LogsUserModel({
    required this.name,
    required this.imageUrl,
    required this.dateTime,
    required this.timeOfDay,
    required this.contactNumber,
  });
}

abstract class LogListItem {}

class LogHeaderItem extends LogListItem {
  final String title;
  LogHeaderItem(this.title);
}

class LogUserItem extends LogListItem {
  final LogsUserModel user;
  LogUserItem(this.user);
}
