import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pomotimer/util/util.dart';
import 'custom_slider_controller.dart';
import 'painters/custom_slider_thumb.dart';
import 'painters/custom_track_slider.dart';

class CustomSlider extends StatelessWidget {
  const CustomSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CustomSliderController controller = Get.find();
    final double height = 60.h;
    final double padding = 20.w;
    return LayoutBuilder(
      builder: (context, constraints) {
        final double width = constraints.maxWidth;
        return SizedBox(
          height: height,
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              Neumorphic(
                style: NeumorphicStyle(
                  boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(30)),
                  depth: -10,
                  intensity: 0.75,
                  lightSource: LightSource.topLeft,
                  color: const Color(0xFFF5F5F5),
                ),
                child: SizedBox(
                  width: width,
                  height: height * 0.7,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: padding),
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    overlayShape: SliderComponentShape.noOverlay,
                    thumbShape: CustomSliderThumb(),
                    trackShape: const CustomSliderTrack(),
                    inactiveTrackColor: const Color(0xFFcdd4de),
                  ),
                  child: Obx(
                    () => Slider(
                      min: 1,
                      max: 6,
                      value: controller.sliderValue,
                      onChanged: controller.setSliderValue,
                    ),
                  ),
                ),
              ),
              for (int i = 0; i <= 5; i++)
                Positioned(
                  top: height,
                  left: i == 0
                      ? padding
                      : (width - padding * 2).divideToFraction(numerator: i, denominator: 5) +
                          padding,
                  child: Text(
                    '${i + 1}',
                    style: const TextStyle(color: Colors.black45),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
