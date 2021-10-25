import 'package:url_launcher/url_launcher.dart';

class LaunchUtils {
  static Future openLink({required String url}) => _launcherUrl(url);

  static _launcherUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  static openEmail({required String toEmail, required String subject}) async {
    final url = 'mailto:$toEmail?subject=${Uri.encodeFull(subject)}';
    await _launcherUrl(url);
  }

  static openPhoneCall({required String phoneNumber}) async {
    final url = 'tel:$phoneNumber';
    await _launcherUrl(url);
  }
}
