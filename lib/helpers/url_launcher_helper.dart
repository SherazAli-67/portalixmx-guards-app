import 'package:url_launcher/url_launcher.dart';

class UrlLauncherHelper {
  static void launchAppUrl({required String url}) async {
    Uri termsOfUse = Uri.parse(url);
    if(await canLaunchUrl(termsOfUse)){
      await launchUrl(termsOfUse);
    }
  }

  static Future<void> makingPhoneCall({required String phoneNum}) async {
    var url = Uri.parse("tel:$phoneNum");
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }
}