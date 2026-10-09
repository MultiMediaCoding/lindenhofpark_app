import 'package:flutter/material.dart';
import 'package:lindenhofpark/PlaceDetails/common/view/sheet/sheet_handle_delegate.dart';

/// Bottom sheet over the place image with two detents ([minSize], [maxSize]).
///
/// Dragging the sheet and scrolling its content share a single
/// [ScrollController], so a drag first moves the sheet and only then scrolls
/// the text, without the two gestures competing.
class DraggableSheet extends StatelessWidget {
  const DraggableSheet({
    super.key,
    required this.child,
    this.minSize = 0.4,
    this.maxSize = 0.9,
  });

  final double minSize;
  final double maxSize;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return DraggableScrollableSheet(
      initialChildSize: minSize,
      minChildSize: minSize,
      maxChildSize: maxSize,
      snap: true,
      snapSizes: [minSize, maxSize],
      builder: (context, scrollController) {
        return Material(
          color: Theme.of(context).colorScheme.surface,
          clipBehavior: Clip.antiAlias,
          shape: const RoundedSuperellipseBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverPersistentHeader(
                pinned: true,
                delegate: SheetHandleDelegate(),
              ),
              SliverPadding(
                padding: EdgeInsets.fromLTRB(20, 4, 20, bottomInset + 24),
                sliver: SliverToBoxAdapter(child: child),
              ),
            ],
          ),
        );
      },
    );
  }
}
