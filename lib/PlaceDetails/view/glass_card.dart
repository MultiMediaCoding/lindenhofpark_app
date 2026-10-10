import 'package:flutter/material.dart';
import 'package:lindenhofpark/Common/view/symbol_icon.dart';
import 'package:lindenhofpark/PlaceDetails/view/fact_symbol.dart';

/// Systemschrift wie in Apple Karten (die App-Schrift Inter bleibt sonst).
final String sheetFont = hasSfSymbols ? 'CupertinoSystemText' : 'Inter';

/// Breite Variante des Systemschnitts für Titel.
final String sheetTitleFont = hasSfSymbols ? 'CupertinoSystemDisplay' : 'Inter';

/// Textfarben des Sheets, je nach hellem oder dunklem Erscheinungsbild.
extension SheetColors on BuildContext {
  bool get isDark => Theme.of(this).brightness == Brightness.dark;
  Color get sheetInk => hasSfSymbols
      ? (isDark ? const Color(0xFFF1F4F2) : const Color(0xFF1D2420))
      : Theme.of(this).colorScheme.onSurface;
  Color get sheetInkSoft => hasSfSymbols
      ? (isDark ? const Color(0xFFA2ACA6) : const Color(0xFF6A746E))
      : Theme.of(this).colorScheme.onSurfaceVariant;
}

/// Hellere, abgerundete Karte auf dem Glas, wie in Apple Karten.
class GlassCard extends StatelessWidget {
  const GlassCard({super.key, required this.child, this.padding});

  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      decoration: BoxDecoration(
        color: hasSfSymbols
            ? Colors.white.withValues(alpha: context.isDark ? 0.1 : 0.5)
            : Theme.of(context).colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(hasSfSymbols ? 22 : 16),
      ),
      child: child,
    );
  }
}

/// Eine Zeile der Eckdaten: Symbol, Beschriftung und Wert.
typedef InfoRow = ({SymbolSpec symbol, String label, String value});

/// Zeilen aus Symbol, Beschriftung und Wert, durch feine Linien getrennt.
class InfoRows extends StatelessWidget {
  const InfoRows({super.key, required this.rows});

  final List<InfoRow> rows;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        children: [
          for (var i = 0; i < rows.length; i++) ...[
            if (i > 0)
              Divider(
                height: 1,
                thickness: 0.5,
                indent: SymbolBadge.size + 12,
                color: context.sheetInk.withValues(alpha: 0.18),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                spacing: 12,
                children: [
                  SymbolBadge(symbol: rows[i].symbol),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          rows[i].label,
                          style: TextStyle(
                            fontSize: 17,
                            color: context.sheetInkSoft,
                          ),
                        ),
                        const SizedBox(height: 1),
                        Text(
                          rows[i].value,
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                            color: context.sheetInk,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
