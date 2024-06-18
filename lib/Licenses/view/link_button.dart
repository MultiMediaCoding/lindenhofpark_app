import 'package:flutter/material.dart';
import 'package:lindenhofpark/Common/view/glasmorphic_button.dart';
import 'package:lindenhofpark/Common/view/vector_icon.dart';
import 'package:lindenhofpark/resources/resources.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkButton extends StatelessWidget {
  const LinkButton({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return GlassmorphicButton(
      icon: Padding(
        padding: const EdgeInsets.all(10.0),
        child: VectorIcon(
          icon: FontAwesomeIcon.link,
          color: Color.fromRGBO(59, 105, 57, 1),
          size: 5,
        ),
      ),
      onPressed: () => _launchUrl(),
    );
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }
}
