import 'package:flutter/material.dart';

class AnimatedTextStyle extends StatefulWidget {
  const AnimatedTextStyle({
    Key? key,
    required this.text,
    required this.textStyle,
    required this.secondTextStyle,
  }) : super(key: key);

  final String? text;
  final TextStyle textStyle;
  final TextStyle secondTextStyle;

  @override
  State<AnimatedTextStyle> createState() => _AnimatedTextStyleState();
}

class _AnimatedTextStyleState extends State<AnimatedTextStyle> with SingleTickerProviderStateMixin {
  String? text;
  late final AnimationController controller;

  @override
  void initState() {
    text = widget.text;
    controller = AnimationController(
      vsync: this,
      value: text != null ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 500),
    );

    super.initState();
  }

  @override
  void didUpdateWidget(covariant AnimatedTextStyle oldWidget) {
    if (widget.text != oldWidget.text) {
      if (widget.text != null) {
        text = widget.text;
        controller.forward();
      } else {
        controller.reverse().then((value) => text = null);
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) {
        return Text(
          text ?? '',
          style: TextStyle.lerp(
            widget.textStyle,
            widget.secondTextStyle,
            controller.value,
          ),
        );
      },
    );
  }
}
