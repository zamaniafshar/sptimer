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

class _AnimatedTextState extends State<AnimatedText>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<AlignmentGeometry> animationAlignment1;
  late final Animation<AlignmentGeometry> animationAlignment2;
  late final Animation<double> animationOpacity1;
  late final Animation<double> animationScale1;
  late final Animation<double> animationScale2;

  final TextStyle textStyle =
      TextStyle(fontSize: 35.sp, fontWeight: FontWeight.bold);

  String text1 = '';
  String text2 = '';
  bool isFirstBuild = true;

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 250));
    animationAlignment1 =
        AlignmentTween(begin: Alignment.center, end: Alignment.topCenter)
            .animate(animationController);
    animationAlignment2 =
        AlignmentTween(begin: Alignment.bottomCenter, end: Alignment.center)
            .animate(animationController);
    animationOpacity1 =
        Tween<double>(begin: 1.0, end: 0.0).animate(animationController);
    animationScale1 =
        Tween<double>(begin: 1.0, end: 0.5).animate(animationController);
    animationScale2 =
        Tween<double>(begin: 0.5, end: 1.0).animate(animationController);
    super.initState();
  }

  void animate() {
    if (widget.text == text1 || widget.text == text2 || isFirstBuild) {
      text1 = widget.text;
      text2 = widget.text;
      return;
    }
    text1 = text2;
    text2 = widget.text;

    if (widget.animateBack) {
      animationController.reverse(from: 1.0).then((value) => setState(() {}));
    } else {
      animationController.forward(from: 0.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    animate();
    isFirstBuild = false;
    return Stack(
      children: [
        AlignTransition(
          alignment: animationAlignment1,
          child: ScaleTransition(
            scale: animationScale1,
            child: FadeTransition(
              opacity: animationOpacity1,
              child: Text(text1, style: textStyle),
            ),
          ),
        ),
        AlignTransition(
          alignment: animationAlignment2,
          child: ScaleTransition(
            scale: animationScale2,
            child: FadeTransition(
              opacity: animationController,
              child: Text(text2, style: textStyle),
            ),
          ),
        ),
      ],
    );
  }
}
