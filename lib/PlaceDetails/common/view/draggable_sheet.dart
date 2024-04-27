import 'package:flutter/material.dart';
import 'package:lindenhofpark/Common/view/small_space.dart';
import 'package:sheet/sheet.dart';

class DraggableSheet extends StatefulWidget {
  const DraggableSheet({super.key, required this.child});
  final Widget child;

  @override
  State<DraggableSheet> createState() => _DraggableSheetState();
}

class _DraggableSheetState extends State<DraggableSheet> {
  final SheetController controller = SheetController();

  void animateSheet() {
    controller.relativeAnimateTo(
      0.9,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return AnimatedBuilder(
        animation: controller.animation,
        builder: (context, child) {
          return Sheet(
            controller: controller,
            physics: const SnapSheetPhysics(
              stops: <double>[0.4, 0.9],
              parent: BouncingSheetPhysics(
                overflowViewport: true,
              ),
            ),
            initialExtent: 0.4,
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
                        onTap: () => animateSheet(),
                        child: Container(
                          alignment: Alignment.center,
                          color: Colors.transparent,
                          width: 200,
                          height: 50,
                          child: Text(
                            "Mehr lesen",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: Colors.grey),
                          ),
                        ))
                  ],
                )),
          );
        });
  }
}
