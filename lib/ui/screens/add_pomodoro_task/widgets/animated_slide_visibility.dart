import 'package:flutter/material.dart';

class AnimatedSlideVisibility extends StatelessWidget {
  const AnimatedSlideVisibility({
    Key? key,
    required this.show,
    required this.child,
    required this.title,
    required this.maxHeight,
    required this.minHeight,
    required this.childHeight,
  }) : super(key: key);

  final bool show;
  final Widget child;
  final Widget title;
  final double maxHeight;
  final double minHeight;
  final double childHeight;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: show ? maxHeight : minHeight,
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          AnimatedSlide(
            offset: Offset(0.0, show ? 1 : 0),
            duration: const Duration(milliseconds: 300),
            child: SizedBox(
              height: childHeight,
              child: child,
            ),
          ),
          SizedBox(
            height: minHeight,
            child: title,
          ),
        ],
      ),
    );
  }
}
