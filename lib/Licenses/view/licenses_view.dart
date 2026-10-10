import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Material, MaterialType;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lindenhofpark/Common/view/symbol_icon.dart';
import 'package:lindenhofpark/Licenses/model/license.dart';
import 'package:lindenhofpark/Licenses/model/licenses.dart';
import 'package:lindenhofpark/Licenses/view/license_view.dart';

/// Lizenzen der verwendeten Pakete als Einstellungen-Liste im iOS-Stil:
/// große Titelleiste, eingerückte Gruppe, Chevron.
class LicensesView extends StatelessWidget {
  const LicensesView({super.key});

  @override
  Widget build(BuildContext context) {
    // Material-Vorfahr liefert den Standard-Textstil (sonst gelb unterstrichen).
    return Material(
      type: MaterialType.transparency,
      child: CupertinoPageScaffold(
        backgroundColor: CupertinoColors.systemGroupedBackground,
        child: CustomScrollView(
          slivers: [
            const CupertinoSliverNavigationBar(
              largeTitle: Text('Lizenzen'),
              backgroundColor: CupertinoColors.systemGroupedBackground,
            ),
            SliverSafeArea(
              top: false,
              sliver: SliverToBoxAdapter(
                child: CupertinoListSection.insetGrouped(
                  footer: const Text(
                    'Die Lindenhofpark-App nutzt diese Open-Source-Pakete.',
                  ),
                  children: [
                    for (final license in licenses)
                      _LicenseTile(license: license),
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

class _LicenseTile extends StatelessWidget {
  const _LicenseTile({required this.license});

  final License license;

  @override
  Widget build(BuildContext context) {
    return CupertinoListTile.notched(
      leading: Container(
        decoration: BoxDecoration(
          color: CupertinoColors.systemGrey,
          borderRadius: BorderRadius.circular(7),
        ),
        alignment: Alignment.center,
        child: SymbolIcon(
          symbol: symbolSpec('shippingbox.fill', FontAwesomeIcons.boxOpen),
          size: 17,
          color: CupertinoColors.white,
        ),
      ),
      title: Text(license.name),
      subtitle: Text(license.type),
      trailing: const CupertinoListTileChevron(),
      onTap: () => Navigator.of(context).push(
        CupertinoPageRoute<void>(builder: (_) => LicenseView(license: license)),
      ),
    );
  }
}
