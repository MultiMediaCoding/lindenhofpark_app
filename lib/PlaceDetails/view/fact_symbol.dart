import 'package:cupertino_native/cupertino_native.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// Symbol zu einem biologischen Fakt, nach seinem Titel: ein SF-Symbol-Name,
/// oder ein Font-Awesome-Symbol, wo Apple kein passendes hat (es gibt dort z. B.
/// keine Frucht und keinen Keimling).
typedef FactIcon = ({String? sf, FaIconData? fa});

FactIcon _sf(String name) => (sf: name, fa: null);
FactIcon _fa(FaIconData icon) => (sf: null, fa: icon);

FactIcon factSymbol(String title) => switch (title) {
  'Borke' => _sf('tree.fill'),
  'Blattform' || 'Blatt/Nadelform' => _sf('leaf.fill'),
  'Nadelform' || 'Nadeln' => _sf('asterisk'),
  'Blütezeit' => _sf('camera.macro'),
  'Frucht' => _fa(FontAwesomeIcons.appleWhole),
  'Fortpflanzung' => _fa(FontAwesomeIcons.seedling),
  'Durchschnittliches Alter' || 'Alter' => _sf('birthday.cake.fill'),
  'Fledermauskasten' => _sf('moon.stars.fill'),
  'Lebensraum' => _sf('bird.fill'),
  'Leben am Baum' => _sf('ladybug.fill'),
  'Besonderheiten' => _sf('rosette'),
  _ => _sf('leaf.fill'),
};

const _green = Color(0xFF2F7A36);

/// Runde Plakette mit SF Symbol, wie das Ortssymbol in Apple Karten.
class FactSymbol extends StatelessWidget {
  const FactSymbol({super.key, required this.title});

  static const double size = 28;

  final String title;

  @override
  Widget build(BuildContext context) {
    final symbol = factSymbol(title);
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.85),
        shape: BoxShape.circle,
      ),
      child: symbol.sf != null
          ? CNIcon(
              symbol: CNSymbol(symbol.sf!, size: 14, color: _green),
              size: 14,
            )
          : FaIcon(symbol.fa, size: 13, color: _green),
    );
  }
}
