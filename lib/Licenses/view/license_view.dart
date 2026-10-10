import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lindenhofpark/Common/view/symbol_icon.dart';
import 'package:flutter/material.dart'
    show Material, MaterialType, SelectableText;
import 'package:lindenhofpark/Licenses/model/license.dart';
import 'package:url_launcher/url_launcher.dart';

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
    // Bewusst kein CupertinoTheme-Stil: der hat `inherit: false` und lässt
    // SelectableText an einer Assertion scheitern.
    final textStyle = TextStyle(
      fontSize: 14,
      height: 1.35,
      color: CupertinoColors.label.resolveFrom(context),
    );
    // Material-Vorfahr liefert den Standard-Textstil (sonst gelb unterstrichen).
    return Material(
      type: MaterialType.transparency,
      child: CupertinoPageScaffold(
        backgroundColor: CupertinoColors.systemGroupedBackground,
        child: CustomScrollView(
          slivers: [
            CupertinoSliverNavigationBar(
              largeTitle: Text(license.name),
              backgroundColor: CupertinoColors.systemGroupedBackground,
              trailing: CupertinoButton(
                padding: EdgeInsets.zero,
                minimumSize: const Size.square(32),
                onPressed: _openSource,
                child: SymbolIcon(
                  symbol: symbolSpec('link', FontAwesomeIcons.link),
                  size: 20,
                  color: CupertinoColors.activeBlue,
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
      ),
    );
  }
}
