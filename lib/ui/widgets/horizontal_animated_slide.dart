import 'package:flutter/material.dart';

class HorizontalAnimatedSlide extends StatefulWidget {
  const HorizontalAnimatedSlide({
    Key? key,
    required this.child,
    required this.reverse,
    required this.duration,
    required this.tween,
    required this.animate,
    this.onDone,
    this.height,
    this.width,
  }) : super(key: key);
  final Widget child;
  final Tween<Offset> tween;
  final double? height;
  final double? width;
  final bool reverse;
  final bool animate;
  final VoidCallback? onDone;
  final Duration duration;
  @override
  State<HorizontalAnimatedSlide> createState() => _HorizontalAnimatedSlideState();
}

class _HorizontalAnimatedSlideState extends State<HorizontalAnimatedSlide>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<Offset> newOffset;
  late final Animation<Offset> previousOffset;
  late Widget newWidget;
  late Widget previousWidget;

  @override
  void initState() {
    previousWidget = widget.child;
    newWidget = widget.child;
    controller = AnimationController(vsync: this, duration: widget.duration, value: 1.0);
    newOffset = Tween<Offset>(
      begin: widget.tween.begin,
      end: Offset.zero,
    ).animate(controller);
    previousOffset = Tween<Offset>(begin: Offset.zero, end: widget.tween.end).animate(controller);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant HorizontalAnimatedSlide oldWidget) {
    animate();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  Future<void> animate() async {
    final previousValue = controller.isAnimating
        ? controller.value
        : widget.reverse
            ? 1.0
            : 0.0;

    if (widget.reverse) {
      newWidget = previousWidget;
      previousWidget = widget.child;
      if (!widget.animate) return;
      await controller.reverse(from: previousValue).then((value) => widget.onDone?.call());
    } else {
      previousWidget = newWidget;
      newWidget = widget.child;
      if (!widget.animate) return;
      await controller.forward(from: previousValue).then((value) => widget.onDone?.call());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          SlideTransition(
            position: previousOffset,
            child: previousWidget,
          ),
          SlideTransition(
            position: newOffset,
            child: newWidget,
          ),
        ],
      ),
    );
  }
}
