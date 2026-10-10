import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show MaterialPageRoute;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lindenhofpark/Common/view/symbol_icon.dart';

/// Akzentfarbe der App (wie die Symbole im Detail-Sheet).
const licenseAccent = Color(0xFF2F7A36);
const _accentLight = Color(0xFF52AC5A);

/// Abstände auf einem 4-pt-Raster: Seitenrand 20, Zeile 14 × 16, Symbol 40,
/// Abschnitt 28.
const licenseGutter = 20.0;
const licenseSectionGap = 28.0;

/// Abgerundetes Quadrat mit leichtem Verlauf, wie die Symbole in Einstellungen.
class AccentTile extends StatelessWidget {
  const AccentTile({super.key, required this.symbol});

  final SymbolSpec symbol;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(11),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [_accentLight, licenseAccent],
        ),
      ),
      child: SymbolIcon(symbol: symbol, size: 19, color: CupertinoColors.white),
    );
  }
}

/// Zurück-Pfeil ohne Schriftsymbol-Abhängigkeit (SF Symbol bzw. Font Awesome).
class LicenseBackButton extends StatelessWidget {
  const LicenseBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      minimumSize: const Size.square(44),
      onPressed: () => Navigator.of(context).maybePop(),
      child: IgnorePointer(
        child: SymbolIcon(
          symbol: symbolSpec('chevron.left', FontAwesomeIcons.chevronLeft),
          size: 20,
          color: licenseAccent,
        ),
      ),
    );
  }
}

/// Weiße, stark gerundete Gruppe mit eingerückten Trennlinien.
class LicenseGroup extends StatelessWidget {
  const LicenseGroup({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CupertinoColors.secondarySystemGroupedBackground.resolveFrom(
          context,
        ),
        borderRadius: BorderRadius.circular(26),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          for (var i = 0; i < children.length; i++) ...[
            if (i > 0)
              Padding(
                padding: const EdgeInsets.only(left: 70),
                child: Container(
                  height: 0.5,
                  color: CupertinoColors.separator.resolveFrom(context),
                ),
              ),
            children[i],
          ],
        ],
      ),
    );
  }
}

/// Seitenwechsel im Stil der Plattform: iOS-Wischgeste bzw. Material-Übergang.
Route<void> licenseRoute(WidgetBuilder builder) => hasSfSymbols
    ? CupertinoPageRoute<void>(builder: builder)
    : MaterialPageRoute<void>(builder: builder);
