import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lindenhofpark/Common/view/glassmorphism.dart';

class GlassmorphicButton extends StatelessWidget {
  const GlassmorphicButton(
      {super.key, required this.icon, required this.onPressed});

  final Widget icon;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: GlassMorphism(
        borderRadius: 100,
        child: SizedBox(
          width: 45,
          height: 45,
          child: icon,
        ),
      ),
    );
  }
}
