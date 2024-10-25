import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class AnimatedThemeButton extends StatefulWidget {
  const AnimatedThemeButton({
    Key? key,
    required this.showMoonAtFirst,
    required this.radius,
    required this.onChange,
  }) : super(key: key);
  final void Function(bool) onChange;
  final bool showMoonAtFirst;
  final double radius;

  @override
  State<AnimatedThemeButton> createState() => _AnimatedThemeButtonState();
}

class _AnimatedThemeButtonState extends State<AnimatedThemeButton> {
  late bool isShowingMoon;
  StateMachineController? controller;
  SMITrigger? animate;
  Artboard? artboard;

  bool get isAnimating => controller?.isActive ?? false;

  Future<void> initRiveAnimation() async {
    final data = await rootBundle.load('assets/icons/moon_to_sun_animated_icon.riv');
    artboard = RiveFile.import(data).mainArtboard;
    controller = StateMachineController.fromArtboard(artboard!, 'moonToSunAnimatedIcon');
    artboard!.addController(controller!);
    SMIInput<bool>? showMoonAtFirst = controller!.findInput('showMoonAtFirst');
    animate = controller!.findSMI('animate');
    showMoonAtFirst!.value = widget.showMoonAtFirst;
    isShowingMoon = widget.showMoonAtFirst;
    setState(() {});
  }

  void onTap() {
    if (isAnimating) return;
    isShowingMoon = !isShowingMoon;
    animate?.fire();
    widget.onChange(isShowingMoon);
  }

  @override
  void initState() {
    initRiveAnimation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: widget.radius,
      child: GestureDetector(
        onTap: onTap,
        child: artboard == null
            ? const SizedBox()
            : Rive(
                artboard: artboard!,
              ),
      ),
    );
  }
}
