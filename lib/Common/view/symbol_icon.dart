import 'package:cupertino_native/cupertino_native.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// Native Apple-Symbole (SF Symbols) gibt es nur auf iOS und macOS.
bool get hasSfSymbols =>
    defaultTargetPlatform == TargetPlatform.iOS ||
    defaultTargetPlatform == TargetPlatform.macOS;

/// Symbol für einen Eintrag: ein SF Symbol, wo es das gibt, sonst ein
/// Font-Awesome-Ersatz (auch dort, wo Apple kein passendes Symbol hat).
typedef SymbolSpec = ({String? sf, FaIconData fa});

SymbolSpec symbolSpec(String? sf, FaIconData fa) => (sf: sf, fa: fa);

class SymbolIcon extends StatelessWidget {
  const SymbolIcon({
    super.key,
    required this.symbol,
    required this.size,
    required this.color,
  });

  final SymbolSpec symbol;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    if (hasSfSymbols && symbol.sf != null) {
      return CNIcon(
        symbol: CNSymbol(symbol.sf!, size: size, color: color),
        size: size,
      );
    }
    return FaIcon(symbol.fa, size: size - 1, color: color);
  }
}
