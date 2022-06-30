import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pomotimer/controller/home_screen_controller.dart';
import 'package:pomotimer/ui/widgets/circle_start_button/circle_start_button.dart';
import 'package:pomotimer/ui/widgets/circle_timer/circle_timer.dart';
import 'package:pomotimer/ui/widgets/custom_slider/custom_slider.dart';
import 'package:pomotimer/ui/screens/home/widgets/header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return AnimatedContainer(
          duration: const Duration(seconds: 1),
          width: Get.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Get.find<HomeScreenController>().showGradiantColor()
                    ? const Color(0xFFBFDDE2)
                    : const Color(0xFFEBE8E8),
                const Color(0xFFECECEC),
              ],
              stops: const [
                0.1,
                0.55,
              ],
            ),
          ),
          child: const _Body(),
        );
      }),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 20.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Header(),
            SizedBox(height: 5.h),
            const CircleTimer(),
            const SizedBox(),
            const CustomSlider(),
            const CircleStartButton(),
          ],
        ),
      ),
    );
  }
}
