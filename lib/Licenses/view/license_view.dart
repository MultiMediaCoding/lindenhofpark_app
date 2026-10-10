import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show SelectableText;
import 'package:lindenhofpark/Licenses/model/license.dart';
import 'package:url_launcher/url_launcher.dart';

const _background = Color(0xFFDDDFD8);

/// Eine einzelne Lizenz: große Titelleiste, Quelle oben rechts, Lizenztext in
/// einer eingerückten Gruppe.
class LicenseView extends StatelessWidget {
  const LicenseView({super.key, required this.license});

  final License license;

  Future<void> _openSource() => launchUrl(
    Uri.parse(license.source),
    mode: LaunchMode.externalApplication,
  );

  @override
  Widget build(BuildContext context) {
    final textStyle = CupertinoTheme.of(context).textTheme.textStyle
        .copyWith(fontSize: 14, height: 1.35);
    return CupertinoPageScaffold(
      backgroundColor: _background,
      child: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: Text(license.name),
            backgroundColor: _background,
            trailing: CupertinoButton(
              padding: EdgeInsets.zero,
              minimumSize: const Size.square(32),
              onPressed: _openSource,
              child: const Icon(
                CupertinoIcons.link,
                semanticLabel: 'Quelle öffnen',
              ),
            ),
          ),
          SliverSafeArea(
            top: false,
            sliver: SliverToBoxAdapter(
              child: CupertinoListSection.insetGrouped(
                header: Text(license.type),
                footer: Text(license.licenseName),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: SelectableText(
                      license.licenseText,
                      style: textStyle,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
