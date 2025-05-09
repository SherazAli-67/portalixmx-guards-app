import 'package:flutter/material.dart';
import 'package:portalixmx_guards_app/models/log_user_model.dart';

class AppData {
  static final List<String> days = [
    'MON', 'TUE','WED', 'THU', 'FRI','SAT', 'SUN'
  ];

  static String getDayByID(int id){
    switch(id){
      case 0:
        return 'MON';
      case 1:
        return 'TUE';
      case 2:
        return 'WED';
      case 3:
        return 'THU';
      case 4:
        return 'FRI';
      case 5:
        return 'SAT';
      case 6:
        return 'SUN';
      default:
        return 'MON';
    }
  }

  static List<LogsUserModel> get logsUsers {
    return [
      LogsUserModel(name: "Muhammad Ali", imageUrl: "", dateTime: DateTime.now(), timeOfDay: TimeOfDay.now(), contactNumber: "+92 307 2215500"),
      LogsUserModel(name: "Isela Trujillo", imageUrl: "", dateTime: DateTime.now().subtract(Duration(hours: 2)), timeOfDay: TimeOfDay.fromDateTime(DateTime.now().subtract(Duration(hours: 2)) ), contactNumber: "+92 307 2215500"),
      LogsUserModel(name: "Nasser Tahan", imageUrl: "", dateTime: DateTime.now().subtract(Duration(days: 1)), timeOfDay: TimeOfDay.fromDateTime(DateTime.now().subtract(Duration(days: 1))), contactNumber: "+92 307 2215500"),
      LogsUserModel(name: "Emil Eagle", imageUrl: "", dateTime: DateTime.now().subtract(Duration(days: 1)), timeOfDay: TimeOfDay.fromDateTime(DateTime.now().subtract(Duration(days: 1))), contactNumber: "+92 307 2215500"),
      LogsUserModel(name: "Morne Holland", imageUrl: "", dateTime: DateTime.now().subtract(Duration(days: 2)), timeOfDay: TimeOfDay.fromDateTime(DateTime.now().subtract(Duration(days: 2))), contactNumber: "+92 307 2215500"),
      LogsUserModel(name: "Mesut Toruk", imageUrl: "", dateTime: DateTime.now().subtract(Duration(days: 2)), timeOfDay: TimeOfDay.fromDateTime(DateTime.now().subtract(Duration(days: 2))), contactNumber: "+92 307 2215500"),

    ];
  }

  static Map<String, List<LogsUserModel>> groupLogsByDate(List<LogsUserModel> logs) {
    final now = DateTime.now();
    Map<String, List<LogsUserModel>> grouped = {};

    for (var log in logs) {
      final logDate = DateTime(log.dateTime.year, log.dateTime.month, log.dateTime.day);
      final today = DateTime(now.year, now.month, now.day);
      final yesterday = today.subtract(Duration(days: 1));

      String key;
      if (logDate == today) {
        key = 'TODAY';
      } else if (logDate == yesterday) {
        key = 'YESTERDAY';
      } else {
        key = '${log.dateTime.day}/${log.dateTime.month}/${log.dateTime.year}';
      }

      grouped.putIfAbsent(key, () => []).add(log);
    }

    return grouped;
  }

  static List<LogListItem> buildGroupedList(List<LogsUserModel> logs) {
    final grouped = groupLogsByDate(logs);
    List<LogListItem> items = [];

    grouped.forEach((date, users) {
      items.add(LogHeaderItem(date));
      users.sort((a, b) => b.dateTime.compareTo(a.dateTime)); // sort by time descending
      items.addAll(users.map((u) => LogUserItem(u)));
    });

    return items;
  }
/*
  static List<AccessRequestModel> get getRequestAccessList {
    return [
      AccessRequestModel(id: 1, icon: AppIcons.icPool, title: "Pool"),
      AccessRequestModel(id: 2, icon: AppIcons.icGame, title: "Game"),
      AccessRequestModel(id: 3, icon: AppIcons.icGym, title: "Gym"),
    ];
  }

  static List<EmergencyContactModel> get emergencyContacts {
    return [
      EmergencyContactModel(id: 1, name: "Isela Trujillo", phoneNumber: "+92 3072215500"),
      EmergencyContactModel(id: 1, name: "Sheraz Ali", phoneNumber: "+92 3072215500"),

    ];
  }

 */
}