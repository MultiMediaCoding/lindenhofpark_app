import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lindenhofpark/PlaceDetails/common/view/back_button.dart';
import 'package:lindenhofpark/PlaceDetails/common/view/sheet/draggable_sheet.dart';

/// Full-screen image with a back button and a draggable detail sheet.
class PlaceDetailsLayout extends StatelessWidget {
  const PlaceDetailsLayout({
    super.key,
    required this.image,
    required this.child,
    this.minSheetSize = 0.4,
    this.maxSheetSize = 0.9,
  });

  /// Space above an expanded sheet: status bar, back button and a small gap.
  static const double _backButtonBand = 44 + 8 + 8 + 8;

  final String image;
  final Widget child;
  final double minSheetSize;
  final double maxSheetSize;

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.paddingOf(context).top;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      // The status bar sits on top of a photo: keep its content light.
      value: SystemUiOverlayStyle.light,
      child: Stack(
        children: [
          SizedBox.expand(child: Image.asset(image, fit: BoxFit.cover)),
          // Scrim so status bar and back button stay readable on bright photos.
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: topInset + 80,
            child: const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0x66000000), Color(0x00000000)],
                ),
              ),
            ),
          ),
          SafeArea(child: NavigationBackButton()),
          LayoutBuilder(
            builder: (context, constraints) {
              // Keep the back button visible when the sheet is fully open.
              final fitsBelowButton =
                  1 - (topInset + _backButtonBand) / constraints.maxHeight;
              return DraggableSheet(
                minSize: minSheetSize,
                maxSize: maxSheetSize
                    .clamp(minSheetSize, fitsBelowButton)
                    .toDouble(),
                child: child,
              );
            },
          ),
        ],
      ),
    );
  }
}
