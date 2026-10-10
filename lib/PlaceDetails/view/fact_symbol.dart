import 'package:cupertino_native/cupertino_native.dart';
import 'package:flutter/material.dart';

/// SF-Symbol-Name zu einem biologischen Fakt, nach seinem Titel.
String factSymbolName(String title) => switch (title) {
  'Borke' => 'tree.fill',
  'Blattform' || 'Blatt/Nadelform' || 'Nadelform' || 'Nadeln' => 'leaf.fill',
  'Blütezeit' => 'camera.macro',
  'Frucht' => 'basket.fill',
  'Fortpflanzung' => 'sparkles',
  'Durchschnittliches Alter' || 'Alter' => 'hourglass',
  'Fledermauskasten' => 'moon.stars.fill',
  'Lebensraum' => 'bird.fill',
  'Leben am Baum' => 'ladybug.fill',
  'Besonderheiten' => 'star.fill',
  _ => 'leaf.fill',
};

/// Runde Plakette mit SF Symbol, wie das Ortssymbol in Apple Karten.
class FactSymbol extends StatelessWidget {
  const FactSymbol({super.key, required this.title});

  static const double size = 28;

  final String title;

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
      child: CNIcon(
        symbol: CNSymbol(
          factSymbolName(title),
          size: 14,
          color: const Color(0xFF2F7A36),
        ),
        size: 14,
      ),
    );
  }
}
