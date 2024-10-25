import 'package:flutter/material.dart';

class GradientText extends StatelessWidget {
  const GradientText({
    Key? key,
    required this.colors,
    required this.text,
  }) : super(key: key);
  final Widget text;
  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (area) => LinearGradient(colors: colors).createShader(area),
      child: text,
    );
  }
}
