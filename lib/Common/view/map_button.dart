import 'package:cupertino_native/cupertino_native.dart';
import 'package:flutter/material.dart';
import 'package:lindenhofpark/Common/view/symbol_icon.dart';

/// Runder Knopf über der Karte: auf iOS ein natives Liquid-Glass-Element,
/// sonst ein heller, runder Material-Knopf.
class MapButton extends StatelessWidget {
  const MapButton({
    super.key,
    required this.sfSymbol,
    required this.fallbackIcon,
    required this.label,
    required this.onPressed,
    this.color,
    this.fallbackText,
  });

  final String sfSymbol;
  final IconData fallbackIcon;

  /// Statt [fallbackIcon], wenn das Symbol selbst Text ist (2D/3D).
  final String? fallbackText;
  final String label;
  final Color? color;
  final VoidCallback onPressed;

  static const double size = 44;

  @override
  Widget build(BuildContext context) {
    if (hasSfSymbols) {
      return CNButton.icon(
        icon: CNSymbol(sfSymbol, size: 17, color: color),
        onPressed: onPressed,
      );
    }
    final tint = color ?? const Color(0xFF1D2420);
    return Semantics(
      button: true,
      label: label,
      excludeSemantics: true,
      child: Material(
        color: const Color(0xF2FFFFFF),
        shape: const CircleBorder(),
        elevation: 3,
        shadowColor: const Color(0x40000000),
        child: InkResponse(
          onTap: onPressed,
          containedInkWell: true,
          customBorder: const CircleBorder(),
          child: SizedBox(
            width: size,
            height: size,
            child: Center(
              child: fallbackText != null
                  ? Text(
                      fallbackText!,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: tint,
                      ),
                    )
                  : Icon(fallbackIcon, size: 22, color: tint),
            ),
          ),
        ),
      ),
    );
  }
}
