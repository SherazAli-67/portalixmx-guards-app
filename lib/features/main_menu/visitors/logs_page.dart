import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:portalixmx_guards_app/app_data/app_data.dart';

class LogsPage extends StatelessWidget{
  const LogsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: AppData.groupLogsByDate(AppData.logsUsers).length,
      itemBuilder: (context, index) {
        bool isSameDate = true;

        final item = AppData.logsUsers[index];
        final DateTime date = item.dateTime;
        if (index == 0) {
          isSameDate = false;
        } else {
          final DateTime prevDate = AppData.logsUsers[index-1].dateTime;
          isSameDate = date.isSameDate(prevDate);
        }
        if (index == 0 || !(isSameDate)) {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            Text(date.formatDate()),
           ListTile(title: Text('item $index'))
          ]);
        } else {
          return ListTile(title: Text('item $index'));
        }
        }
    );
  }
}

const String dateFormatter = 'MMMM dd, y';

extension DateHelper on DateTime {

  String formatDate() {
    final formatter = DateFormat(dateFormatter);
    return formatter.format(this);
  }
  bool isSameDate(DateTime other) {
    return this.year == other.year &&
        this.month == other.month &&
        this.day == other.day;
  }

  int getDifferenceInDaysWithNow() {
    final now = DateTime.now();
    return now.difference(this).inDays;
  }
}