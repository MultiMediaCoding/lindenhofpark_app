import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class VectorIcon extends StatelessWidget {
  const VectorIcon(
      {super.key, required this.icon, required this.size, this.color});

  final String icon;
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
        width: size,
        height: size,
        colorFilter: ColorFilter.mode(color ?? Colors.black, BlendMode.srcIn),
        icon);
  }
}
