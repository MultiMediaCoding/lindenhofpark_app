import 'package:flutter/material.dart';

/// Systemschrift wie in Apple Karten (die App-Schrift Inter bleibt sonst).
const String sheetFont = 'CupertinoSystemText';

/// Breite Variante des Systemschnitts für Titel.
const String sheetTitleFont = 'CupertinoSystemDisplay';

const Color sheetInk = Color(0xFF1D2420);
const Color sheetInkSoft = Color(0xFF6A746E);

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
        color: Colors.white.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(22),
      ),
      child: child,
    );
  }
}

/// Zeilen aus Beschriftung und Wert, durch feine Linien getrennt.
class InfoRows extends StatelessWidget {
  const InfoRows({super.key, required this.rows});

  final List<(String, String)> rows;

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
                color: sheetInk.withValues(alpha: 0.18),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      rows[i].$1,
                      style: const TextStyle(fontSize: 17, color: sheetInkSoft),
                    ),
                    const SizedBox(height: 1),
                    Text(
                      rows[i].$2,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: sheetInk,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
