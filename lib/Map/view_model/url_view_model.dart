import 'package:url_launcher/url_launcher.dart';

class UrlViewModel {
  Future launchOpenStreetMapCopyrightSite() async {
    await launchUrlString('https://openstreetmap.org/copyright');
  }

  Future launchUrlString(String url) async {
    final uri = Uri.parse(url);

    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }
}
