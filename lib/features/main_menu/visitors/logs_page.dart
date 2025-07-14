import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:portalixmx_guards_app/app_data/app_data.dart';
import 'package:portalixmx_guards_app/features/main_menu/visitors/visitor_detail_page.dart';
import 'package:portalixmx_guards_app/models/log_user_model.dart';
import 'package:portalixmx_guards_app/res/app_icons.dart';
import 'package:portalixmx_guards_app/res/app_textstyles.dart';

class LogsPage extends StatelessWidget{
  const LogsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: AppData.logsUsers.length,
      itemBuilder: (context, index) {
        bool isSameDate = true;

        final item = AppData.logsUsers[index];
        final DateTime date = item.dateTime;

        bool isToday = date.isSameDate(DateTime.now());
        bool isYesterday = date.isSameDate(DateTime.now().subtract(Duration(days: 1)));
        if (index == 0) {
          isSameDate = false;
        } else {
          final DateTime prevDate = AppData.logsUsers[index-1].dateTime;
          isSameDate = date.isSameDate(prevDate);
        }
        if (index == 0 || !(isSameDate)) {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: [
            Text(isToday ? 'TODAY' : isYesterday ? 'YESTERDAY' : date.formatDate(), style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.white),),
                LogsItemWidget(item: item)
          ]);
        } else {
          return LogsItemWidget(item: item);
        }
        }
    );
  }
}

class LogsItemWidget extends StatelessWidget {
  const LogsItemWidget({
    super.key,
    required this.item,
  });

  final LogsUserModel item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Material(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
        ),
        child: ListTile(
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (_)=> VisitorDetailPage()));
          },
          contentPadding: EdgeInsets.only(left: 10),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)
          ),
          tileColor: Colors.white,
          leading: CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(item.imageUrl, errorListener: (val){}),
          ),
          title: Text(item.name, style: AppTextStyles.tileTitleTextStyle,),
          subtitle: Text(item.dateTime.formatDate(), style: AppTextStyles.tileSubtitleTextStyle,),
          trailing: IconButton(onPressed: (){}, icon: SvgPicture.asset(AppIcons.icLogsOut, height: 20,)),
        ),
      ),
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
    return year == other.year &&
        month == other.month &&
        day == other.day;
  }

  int getDifferenceInDaysWithNow() {
    final now = DateTime.now();
    return now.difference(this).inDays;
  }

}