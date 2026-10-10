import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'
    show Material, MaterialType, SelectableText;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lindenhofpark/Common/view/symbol_icon.dart';
import 'package:lindenhofpark/Licenses/model/license.dart';
import 'package:lindenhofpark/Licenses/view/license_style.dart';
import 'package:url_launcher/url_launcher.dart';

/// Eine einzelne Lizenz: Titel, Quelle oben rechts, darunter Art des Pakets
/// und der Lizenztext in zurückgenommenem Grau, ohne Kasten.
class LicenseView extends StatelessWidget {
  const LicenseView({super.key, required this.license});

  final License license;

  Future<void> _openSource() => launchUrl(
    Uri.parse(license.source),
    mode: LaunchMode.externalApplication,
  );

  /// Die Texte sind hart umbrochen; Absätze und Aufzählungen bleiben, der
  /// Rest läuft als Fließtext.
  String get _text {
    final paragraphs = license.licenseText.trim().split(RegExp(r'\n\s*\n'));
    final bullet = RegExp(r'^(\*|-|\d+[.)]|\([a-z0-9]+\))\s');
    return paragraphs
        .map((p) {
          final out = StringBuffer();
          for (final raw in p.split('\n')) {
            final line = raw.trim();
            if (line.isEmpty) continue;
            if (out.isNotEmpty) out.write(bullet.hasMatch(line) ? '\n' : ' ');
            out.write(line);
          }
          return out.toString();
        })
        .join('\n\n');
  }

  @override
  Widget build(BuildContext context) {
    final secondary = CupertinoColors.secondaryLabel.resolveFrom(context);
    return Material(
      type: MaterialType.transparency,
      child: CupertinoPageScaffold(
        backgroundColor: CupertinoColors.systemGroupedBackground,
        child: CustomScrollView(
          slivers: [
            CupertinoSliverNavigationBar(
              largeTitle: Text(license.name),
              leading: const LicenseBackButton(),
              automaticallyImplyLeading: false,
              automaticallyImplyTitle: false,
              trailing: CupertinoButton(
                padding: EdgeInsets.zero,
                minimumSize: const Size.square(44),
                onPressed: _openSource,
                child: SymbolIcon(
                  symbol: symbolSpec('link', FontAwesomeIcons.link),
                  size: 24,
                  color: licenseAccent,
                ),
              ),
            ),
            SliverSafeArea(
              top: false,
              minimum: const EdgeInsets.fromLTRB(
                licenseGutter,
                8,
                licenseGutter,
                licenseSectionGap,
              ),
              sliver: SliverList.list(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 12),
                    child: Text(
                      license.type,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: secondary,
                      ),
                    ),
                  ),
                  SelectableText(
                    _text,
                    scrollPhysics: const NeverScrollableScrollPhysics(),
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.45,
                      color: secondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
