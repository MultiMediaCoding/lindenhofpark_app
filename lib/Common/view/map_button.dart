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
    final scheme = Theme.of(context).colorScheme;
    return Semantics(
      button: true,
      label: label,
      excludeSemantics: true,
      child: Tooltip(
        message: label,
        child: FloatingActionButton.small(
          heroTag: null,
          onPressed: onPressed,
          elevation: 2,
          backgroundColor: scheme.surfaceContainerHigh,
          foregroundColor: color ?? scheme.onSurface,
          child: fallbackText != null
              ? Text(
                  fallbackText!,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                )
              : Icon(fallbackIcon, size: 22),
        ),
      ),
    );
  }
}
