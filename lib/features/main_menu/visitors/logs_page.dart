import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:portalixmx_guards_app/models/verified_user.dart';
import 'package:portalixmx_guards_app/providers/home_provider.dart';
import 'package:portalixmx_guards_app/res/app_icons.dart';
import 'package:portalixmx_guards_app/res/app_textstyles.dart';
import 'package:provider/provider.dart';

class LogsPage extends StatelessWidget {
  const LogsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final verifiedUsers = Provider.of<HomeProvider>(context).verifiedUsers;
    // Group by date (logsIn)
    final Map<String, List<VerifiedUser>> grouped = {};
    for (var user in verifiedUsers) {
      final dateKey = DateFormat('yyyy-MM-dd').format(user.logsIn);
      grouped.putIfAbsent(dateKey, () => []).add(user);
    }
    // Sort dates descending
    final sortedKeys = grouped.keys.toList()
      ..sort((a, b) => b.compareTo(a));

    return ListView.builder(
      itemCount: sortedKeys.length,
      itemBuilder: (context, dateIndex) {
        final dateKey = sortedKeys[dateIndex];
        final users = grouped[dateKey]!;
        final date = DateTime.parse(dateKey);
        bool isToday = date.isSameDate(DateTime.now());
        bool isYesterday = date.isSameDate(DateTime.now().subtract(Duration(days: 1)));
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
              child: Text(
                isToday
                    ? 'TODAY'
                    : isYesterday
                        ? 'YESTERDAY'
                        : date.formatDate(),
                style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.white),
              ),
            ),
            ...users.map((user) => LogsItemWidget(item: user)).toList(),
          ],
        );
      },
    );
  }
}

class LogsItemWidget extends StatelessWidget {
  const LogsItemWidget({
    super.key,
    required this.item,
  });

  final VerifiedUser item;

  @override
  Widget build(BuildContext context) {
    final user = item.user;
    final name = user.name;
    // final imageUrl = user is dynamic && user.imageUrl != null ? user.imageUrl : '';
    final logsIn = item.logsIn.formatDateTime();
    final logsOut = item.logsOut?.formatDateTime();
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: ListTile(
          onTap: () {
            // TODO: Pass user to detail page if needed
            // Navigator.of(context).push(MaterialPageRoute(builder: (_)=> VisitorDetailPage()));
          },
          contentPadding: const EdgeInsets.only(left: 10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          tileColor: Colors.white,
          leading:
          // imageUrl.isNotEmpty
          //     ? CircleAvatar(
          //         backgroundImage: CachedNetworkImageProvider(imageUrl, errorListener: (val) {}),
          //       )
          //     :
          const CircleAvatar(child: Icon(Icons.person)),
          title: Text(name, style: AppTextStyles.tileTitleTextStyle),
          subtitle: Text('In: $logsIn${logsOut != null ? '\nOut: $logsOut' : ''}', style: AppTextStyles.tileSubtitleTextStyle),
          trailing: IconButton(onPressed: () {}, icon: SvgPicture.asset(AppIcons.icLogsOut, height: 20)),
        ),
      ),
    );
  }
}

const String dateFormatter = 'MMMM dd, y';
const String dateTimeFormatter = 'MMMM dd, y – HH:mm';

extension DateHelper on DateTime {
  String formatDate() {
    final formatter = DateFormat(dateFormatter);
    return formatter.format(this);
  }
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
  int getDifferenceInDaysWithNow() {
    final now = DateTime.now();
    return now.difference(this).inDays;
  }
  String formatDateTime() {
    final formatter = DateFormat(dateTimeFormatter);
    return formatter.format(this);
  }
}