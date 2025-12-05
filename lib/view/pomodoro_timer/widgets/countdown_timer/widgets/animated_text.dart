import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sptimer/common/extensions/extensions.dart';

class AnimatedText extends StatefulWidget {
  const AnimatedText({
    Key? key,
    this.reverse = false,
    required this.text,
    required this.textStyle,
    this.width,
    this.animateWhenReverse = true,
  }) : super(key: key);

  final bool reverse;
  final String text;
  final double? width;
  final TextStyle textStyle;
  final bool animateWhenReverse;

  @override
  State<AnimatedText> createState() => _AnimatedTextState();
}

class _AnimatedTextState extends State<AnimatedText> with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<AlignmentGeometry> animationAlignmentPreviousText;
  late final Animation<AlignmentGeometry> animationAlignmentNewText;
  late final Animation<double> animationOpacityPreviousText;
  late final Animation<double> animationScalePreviousText;
  late final Animation<double> animationScaleNewText;

  late String previousText;
  late String newText;

  @override
  void initState() {
    previousText = widget.text;
    newText = widget.text;

    animationController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 250), value: 1.0);
    animationAlignmentPreviousText =
        AlignmentTween(begin: Alignment.center, end: Alignment.topCenter)
            .animate(animationController);
    animationAlignmentNewText = AlignmentTween(begin: Alignment.bottomCenter, end: Alignment.center)
        .animate(animationController);
    animationOpacityPreviousText = Tween<double>(begin: 1.0, end: 0.0).animate(animationController);
    animationScalePreviousText = Tween<double>(begin: 1.0, end: 0.5).animate(animationController);
    animationScaleNewText = Tween<double>(begin: 0.5, end: 1.0).animate(animationController);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant AnimatedText oldWidget) {
    animate();
    super.didUpdateWidget(oldWidget);
  }

  void animate() {
    if (widget.text == newText) {
      previousText = widget.text;
      newText = widget.text;
      return;
    }
    previousText = newText;
    newText = widget.text;

    final previousValue = animationController.isAnimating
        ? animationController.value
        : widget.reverse
            ? 1.0
            : 0.0;
    if (widget.reverse) {
      if (widget.animateWhenReverse) {
        animationController.reverse(from: previousValue);
      } else {
        animationController.value = 1.0;
      }
    } else {
      animationController.forward(from: previousValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = widget.textStyle;
    final fontSize = widget.textStyle.fontSize ?? 14.sp;

    return SizedBox(
      height: fontSize * 5,
      width: widget.width,
      child: Stack(
        children: [
          AnimatedBuilder(
            animation: animationController,
            builder: (context, _) {
              return Align(
                alignment: animationAlignmentPreviousText.value,
                child: Text(
                  previousText,
                  style: textStyle.copyWith(
                    fontSize: fontSize * animationScalePreviousText.value,
                    color: textStyle.color!.withOp(animationOpacityPreviousText.value),
                  ),
                ),
              );
            },
          ),
          AnimatedBuilder(
            animation: animationController,
            builder: (context, _) {
              return Align(
                alignment: animationAlignmentNewText.value,
                child: Text(
                  newText,
                  style: textStyle.copyWith(
                    fontSize: fontSize * animationScaleNewText.value,
                    color: textStyle.color!.withOp(animationController.value),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
