import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'
    show Icons, ListTile, Material, MaterialType, Scaffold, SliverAppBar, Theme;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lindenhofpark/Common/view/symbol_icon.dart';
import 'package:lindenhofpark/Licenses/model/license.dart';
import 'package:lindenhofpark/Licenses/model/licenses.dart';
import 'package:lindenhofpark/Licenses/view/license_style.dart';
import 'package:lindenhofpark/Licenses/view/license_view.dart';

/// Lizenzen der verwendeten Pakete: große Titelleiste, eine Gruppe mit
/// Akzent-Symbolen, kein Beiwerk.
class LicensesView extends StatelessWidget {
  const LicensesView({super.key});

  @override
  Widget build(BuildContext context) {
    if (!hasSfSymbols) return const _MaterialLicenses();
    final secondary = CupertinoColors.secondaryLabel.resolveFrom(context);
    return Material(
      type: MaterialType.transparency,
      child: CupertinoPageScaffold(
        backgroundColor: CupertinoColors.systemGroupedBackground,
        child: CustomScrollView(
          slivers: [
            const CupertinoSliverNavigationBar(
              largeTitle: Text('Lizenzen'),
              leading: LicenseBackButton(),
              automaticallyImplyLeading: false,
              automaticallyImplyTitle: false,
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
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                    child: Text(
                      'Pakete',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: secondary,
                      ),
                    ),
                  ),
                  LicenseGroup(
                    children: [
                      for (final license in licenses)
                        _LicenseRow(license: license),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                    child: Text(
                      'Die Lindenhofpark-App nutzt diese Open-Source-Pakete.',
                      style: TextStyle(fontSize: 13, color: secondary),
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

class _LicenseRow extends StatelessWidget {
  const _LicenseRow({required this.license});

  final License license;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      minimumSize: Size.zero,
      pressedOpacity: 0.55,
      onPressed: () =>
          Navigator.of(context)
              .push(licenseRoute((_) => LicenseView(license: license))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            AccentTile(
              symbol: symbolSpec('shippingbox.fill', FontAwesomeIcons.boxOpen),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    license.name,
                    style: TextStyle(
                      fontSize: 17,
                      color: CupertinoColors.label.resolveFrom(context),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    license.type,
                    style: TextStyle(
                      fontSize: 13,
                      color: CupertinoColors.secondaryLabel.resolveFrom(
                        context,
                      ),
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

/// Android: Material-3-Liste mit großer, einklappender Titelleiste.
class _MaterialLicenses extends StatelessWidget {
  const _MaterialLicenses();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar.large(title: Text('Lizenzen')),
          SliverList.builder(
            itemCount: licenses.length,
            itemBuilder: (context, i) {
              final license = licenses[i];
              return ListTile(
                leading: Icon(
                  Icons.inventory_2_outlined,
                  color: theme.colorScheme.primary,
                ),
                title: Text(license.name),
                subtitle: Text(license.type),
                onTap: () => Navigator.of(context)
                    .push(licenseRoute((_) => LicenseView(license: license))),
              );
            },
          ),
          SliverSafeArea(
            top: false,
            sliver: SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                child: Text(
                  'Die Lindenhofpark-App nutzt diese Open-Source-Pakete.',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
