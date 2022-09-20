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
  late final Animation<AlignmentGeometry> animationAlignment1;
  late final Animation<AlignmentGeometry> animationAlignment2;
  late final Animation<double> animationOpacity1;
  late final Animation<double> animationScale1;
  late final Animation<double> animationScale2;

  final double fontSize = 35.sp;
  final TextStyle textStyle = const TextStyle(fontWeight: FontWeight.bold);

  String text1 = '';
  String text2 = '';
  bool isFirstBuild = true;

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 250));
    animationAlignment1 = AlignmentTween(begin: Alignment.center, end: Alignment.topCenter)
        .animate(animationController);
    animationAlignment2 = AlignmentTween(begin: Alignment.bottomCenter, end: Alignment.center)
        .animate(animationController);
    animationOpacity1 = Tween<double>(begin: 1.0, end: 0.0).animate(animationController);
    animationScale1 = Tween<double>(begin: 1.0, end: 0.5).animate(animationController);
    animationScale2 = Tween<double>(begin: 0.5, end: 1.0).animate(animationController);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
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
    return SizedBox(
      width: 20.w,
      child: Stack(
        children: [
          AnimatedBuilder(
            animation: animationController,
            builder: (context, _) {
              return Align(
                alignment: animationAlignment1.value,
                child: Opacity(
                  opacity: animationOpacity1.value,
                  child: Text(text1,
                      style: textStyle.copyWith(fontSize: fontSize * animationScale1.value)),
                ),
              );
            },
          ),
          AnimatedBuilder(
            animation: animationController,
            builder: (context, _) {
              return Align(
                alignment: animationAlignment2.value,
                child: Opacity(
                  opacity: animationController.value,
                  child: Text(text2,
                      style: textStyle.copyWith(fontSize: fontSize * animationScale2.value)),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
