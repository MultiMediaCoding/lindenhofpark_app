import 'package:flutter/cupertino.dart';
import 'package:lindenhofpark/Licenses/model/license.dart';
import 'package:lindenhofpark/Licenses/model/licenses.dart';
import 'package:lindenhofpark/Licenses/view/license_view.dart';

const _background = Color(0xFFDDDFD8);
const _green = Color(0xFF3B6939);

/// Lizenzen der verwendeten Pakete als Einstellungen-Liste im iOS-Stil:
/// große Titelleiste, eingerückte Gruppe, Chevron.
class LicensesView extends StatelessWidget {
  const LicensesView({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: _background,
      child: CustomScrollView(
        slivers: [
          const CupertinoSliverNavigationBar(
            largeTitle: Text('Lizenzen'),
            backgroundColor: _background,
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
          color: _green,
          borderRadius: BorderRadius.circular(7),
        ),
        alignment: Alignment.center,
        child: const Icon(
          CupertinoIcons.cube_box_fill,
          size: 18,
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
