import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Liquid-Glass-Hintergrund (iOS 26) mit [child] darüber.
///
/// Die Glasfläche ist eine native Ansicht (`GlassPlatformView` in
/// `AppDelegate.swift`), weil sie den WebView der Karte dahinter sehen muss;
/// auf anderen Plattformen ersetzt eine halbtransparente Fläche sie.
class NativeGlass extends StatelessWidget {
  const NativeGlass({super.key, required this.radius, required this.child});

  final double radius;
  final Widget child;

  static const viewType = 'lindenhof/glass';

  @override
  Widget build(BuildContext context) {
    final isIOS = defaultTargetPlatform == TargetPlatform.iOS;
    return Stack(
      children: [
        Positioned.fill(
          child: IgnorePointer(
            child: isIOS
                ? UiKitView(
                    viewType: viewType,
                    creationParams: {'radius': radius},
                    creationParamsCodec: const StandardMessageCodec(),
                  )
                : DecoratedBox(
                    decoration: BoxDecoration(
                      color: const Color(0xF7F6F6F2),
                      boxShadow: const [
                        BoxShadow(color: Color(0x33000000), blurRadius: 16),
                      ],
                      borderRadius: BorderRadius.circular(radius),
                    ),
                  ),
          ),
        ),
        child,
      ],
    );
  }
}
