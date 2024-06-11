import 'package:flutter/material.dart';
import 'package:lindenhofpark/Common/view/vector_icon.dart';

class BoxContainer extends StatelessWidget {
  const BoxContainer(
      {super.key,
      required this.icon,
      required this.padding,
      required this.size,
      this.color,
      required this.borderRadius});

  final String icon;
  final double size;
  final double borderRadius;
  final double padding;

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 13.0),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: const Color.fromRGBO(241, 242, 239, 1),
        ),
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: VectorIcon(
            icon: icon,
            size: 16,
            color: color,
          ),
        ),
      ),
    );
  }
}
