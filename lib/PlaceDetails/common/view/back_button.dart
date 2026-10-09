import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lindenhofpark/Common/view/glasmorphic_button.dart';

class NavigationBackButton extends StatelessWidget {
  const NavigationBackButton({super.key, this.color});
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: GlassmorphicButton(
        semanticLabel: 'Zurück',
        onPressed: () => Navigator.of(context).pop(),
        icon: Padding(
          // The chevron glyph is optically off-centre; nudge it like SF Symbols.
          padding: const EdgeInsets.only(right: 2),
          child: Icon(
            CupertinoIcons.chevron_left,
            color: color ?? Colors.white,
            size: 22,
          ),
        ),
      ),
    );
  }
}
