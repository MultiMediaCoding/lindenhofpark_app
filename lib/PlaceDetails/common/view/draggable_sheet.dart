import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lindenhofpark/Common/view/small_space.dart';
import 'package:sheet/sheet.dart';

class DraggableSheet extends StatefulWidget {
  const DraggableSheet({super.key, required this.child});
  final Widget child;

  @override
  State<DraggableSheet> createState() => _DraggableSheetState();
}

class _DraggableSheetState extends State<DraggableSheet> {
  @override
  Widget build(BuildContext context) {
    final SheetController controller = SheetController();

    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return AnimatedBuilder(
        animation: controller.animation,
        builder: (context, child) {
          return Sheet(
            controller: controller,
            maxExtent: 600,
            minExtent: 250,
            initialExtent: 250,
            backgroundColor: Colors.transparent,
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: colorScheme.background,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      width: 32.0,
                      height: 4.0,
                      decoration: BoxDecoration(
                        color: colorScheme.onBackground,
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    const SmallSpace(),
                    widget.child,
                    const SmallSpace(),
                    GestureDetector(
                        onTap: () {
                          controller.animateTo(600,
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.bounceInOut);
                        },
                        child: Text(
                          "Mehr lesen",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: Colors.grey),
                        ))
                  ],
                )),
          );
        });
  }
}
