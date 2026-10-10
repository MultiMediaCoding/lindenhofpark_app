import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lindenhofpark/Common/view/symbol_icon.dart';

/// Symbol zu einem biologischen Fakt, nach seinem Titel: ein SF-Symbol, wo
/// Apple ein passendes hat (es gibt dort z. B. keine Frucht und keinen
/// Keimling), sonst Font Awesome; auf Android immer Font Awesome.
SymbolSpec factSymbol(String title) => switch (title) {
  'Borke' => symbolSpec('tree.fill', FontAwesomeIcons.tree),
  'Blattform' ||
  'Blatt/Nadelform' => symbolSpec('leaf.fill', FontAwesomeIcons.leaf),
  'Nadelform' || 'Nadeln' => symbolSpec('asterisk', FontAwesomeIcons.asterisk),
  'Blütezeit' => symbolSpec('camera.macro', FontAwesomeIcons.spa),
  'Frucht' => symbolSpec(null, FontAwesomeIcons.appleWhole),
  'Fortpflanzung' => symbolSpec(null, FontAwesomeIcons.seedling),
  'Durchschnittliches Alter' ||
  'Alter' => symbolSpec('birthday.cake.fill', FontAwesomeIcons.cakeCandles),
  'Fledermauskasten' => symbolSpec('moon.stars.fill', FontAwesomeIcons.moon),
  'Lebensraum' => symbolSpec('bird.fill', FontAwesomeIcons.dove),
  'Leben am Baum' => symbolSpec('ladybug.fill', FontAwesomeIcons.bug),
  'Besonderheiten' => symbolSpec('rosette', FontAwesomeIcons.award),
  _ => symbolSpec('leaf.fill', FontAwesomeIcons.leaf),
};

const _green = Color(0xFF2F7A36);

/// Runde Plakette mit Symbol, wie das Ortssymbol in Apple Karten.
class SymbolBadge extends StatelessWidget {
  const SymbolBadge({super.key, required this.symbol});

  static const double size = 28;

  final SymbolSpec symbol;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.85),
        shape: BoxShape.circle,
      ),
      child: SymbolIcon(symbol: symbol, size: 14, color: _green),
    );
  }
}

class FactSymbol extends StatelessWidget {
  const FactSymbol({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) => SymbolBadge(symbol: factSymbol(title));
}
