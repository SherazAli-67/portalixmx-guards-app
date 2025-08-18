import 'package:flutter/material.dart';
import 'package:portalixmx_guards_app/models/log_user_model.dart';

import '../generated/app_localizations.dart';

class AppData {
  static  List<String> getDays(BuildContext context) {
    return [
      AppLocalizations.of(context)!.monday,
      AppLocalizations.of(context)!.tuesday,
      AppLocalizations.of(context)!.wednesday,
      AppLocalizations.of(context)!.thursday,
      AppLocalizations.of(context)!.friday,
      AppLocalizations.of(context)!.saturday,
      AppLocalizations.of(context)!.sunday
    ];
  }

  static String getDayByID(BuildContext context, int id){
    switch(id){
      case 0:
        return AppLocalizations.of(context)!.monday;
      case 1:
        return AppLocalizations.of(context)!.tuesday;
      case 2:
        return AppLocalizations.of(context)!.wednesday;
      case 3:
        return AppLocalizations.of(context)!.thursday;
      case 4:
        return AppLocalizations.of(context)!.friday;
      case 5:
        return AppLocalizations.of(context)!.saturday;
      case 6:
        return AppLocalizations.of(context)!.sunday;
      default:
        return AppLocalizations.of(context)!.monday;
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