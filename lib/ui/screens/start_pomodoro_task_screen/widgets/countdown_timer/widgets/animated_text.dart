import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnimatedText extends StatefulWidget {
  const AnimatedText({
    Key? key,
    required this.animateBack,
    required this.text,
  }) : super(key: key);

  final bool animateBack;
  final String text;

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

  final double fontSize = 35.sp;
  final TextStyle textStyle = const TextStyle(fontWeight: FontWeight.bold);

  String previousText = '';
  String newText = '';

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

    if (widget.animateBack) {
      animationController.value = 1.0;
      // animationController
      //     .animateBack(0.0, duration: const Duration(milliseconds: 50))
      //     .then((value) => setState(() {}));
    } else {
      animationController.forward(from: 0.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 20.w,
      child: Stack(
        children: [
          AnimatedBuilder(
            animation: animationController,
            builder: (context, _) {
              return Align(
                alignment: animationAlignmentPreviousText.value,
                child: Opacity(
                  opacity: animationOpacityPreviousText.value,
                  child: Text(previousText,
                      style: textStyle.copyWith(
                          fontSize: fontSize * animationScalePreviousText.value)),
                ),
              );
            },
          ),
          AnimatedBuilder(
            animation: animationController,
            builder: (context, _) {
              return Align(
                alignment: animationAlignmentNewText.value,
                child: Opacity(
                  opacity: animationController.value,
                  child: Text(newText,
                      style: textStyle.copyWith(fontSize: fontSize * animationScaleNewText.value)),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
