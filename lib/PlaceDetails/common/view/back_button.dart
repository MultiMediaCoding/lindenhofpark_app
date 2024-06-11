import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lindenhofpark/Common/view/glasmorphic_button.dart';
import 'package:lindenhofpark/Common/view/vector_icon.dart';
import 'package:lindenhofpark/resources/resources.dart';

class NavigationBackButton extends StatelessWidget {
  const NavigationBackButton({super.key, this.color});
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GlassmorphicButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: Container(
          width: 7,
          height: 7,
          margin: EdgeInsets.all(10),
          child: VectorIcon(
            icon: FontAwesomeIcon.angleLeftSolid,
            color: color ?? Colors.white,
            size: 7,
          ),
        ),
      ),
    );
  }
}
