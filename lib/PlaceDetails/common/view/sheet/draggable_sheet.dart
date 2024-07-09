import 'package:flutter/material.dart';
import 'package:lindenhofpark/PlaceDetails/common/view/sheet/sheet_handle_delegate.dart';
import 'package:sheet/sheet.dart';

class DraggableSheet extends StatefulWidget {
  const DraggableSheet({super.key, required this.child, required this.stops});
  final List<double> stops;
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
              physics: SnapSheetPhysics(
                stops: widget.stops,
                parent: BouncingSheetPhysics(
                  overflowViewport: true,
                ),
              ),
              initialExtent: 0.4,
              backgroundColor: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
                child: CustomScrollView(
                  slivers: <Widget>[
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: SheetHandleDelegate(),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 100),
                        child: widget.child,
                      ),
                    )
                  ],
                ),
              ));
        });
  }
}
