import 'package:flutter/cupertino.dart';
import 'package:lindenhofpark/Common/view/glassmorphism.dart';

/// Round glass button following the Human Interface Guidelines: a 44 pt
/// touch target with the standard iOS pressed-state feedback.
class GlassmorphicButton extends StatelessWidget {
  const GlassmorphicButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.semanticLabel,
  });

  static const double size = 44;

  final Widget icon;
  final VoidCallback onPressed;
  final String semanticLabel;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel,
      button: true,
      excludeSemantics: true,
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        minimumSize: const Size.square(size),
        pressedOpacity: 0.6,
        onPressed: onPressed,
        child: GlassMorphism(
          borderRadius: size / 2,
          child: SizedBox.square(
            dimension: size,
            child: Center(child: icon),
          ),
        ),
      ),
    );
  }
}
