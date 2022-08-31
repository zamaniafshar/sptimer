import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pomotimer/ui/screens/add_pomodoro_task/widgets/list_tile_switch.dart';
import 'package:pomotimer/ui/widgets/background_container.dart';
import 'package:pomotimer/ui/widgets/custom_slider/custom_slider.dart';

import 'widgets/horizontal_number_picker.dart';

class AddPomodoroTaskScreen extends StatelessWidget {
  const AddPomodoroTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: const Color(0xFFECECEC),
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          splashRadius: 30.r,
          icon: Icon(
            Icons.arrow_back_ios,
            size: 27.r,
          ),
        ),
        title: const Text('Add New Task'),
      ),
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.fromLTRB(10.w, 15.h, 10.w, 80.h),
            children: [
              BackgroundContainer(
                height: 130,
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 50.h,
                      child: TextField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          border: InputBorder.none,
                          labelText: 'Task name',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50.h,
                      child: TextField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          border: InputBorder.none,
                          labelText: 'Short description',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              BackgroundContainer(
                height: 420.h,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        HorizontalNumberPicker(
                          min: 1,
                          max: 10,
                          title: 'Rounds',
                          suffix: 'Intervals',
                          height: 80.h,
                          width: constraints.maxWidth,
                          initialNumber: 5,
                          onSelectedItemChanged: (int index) {},
                        ),
                        HorizontalNumberPicker(
                          min: 15,
                          max: 90,
                          title: 'Work interval',
                          suffix: 'Minutes',
                          initialNumber: 25,
                          height: 80.h,
                          width: constraints.maxWidth,
                          onSelectedItemChanged: (int index) {},
                        ),
                        HorizontalNumberPicker(
                          min: 1,
                          max: 15,
                          title: 'Short break',
                          suffix: 'Minutes',
                          height: 80.h,
                          width: constraints.maxWidth,
                          initialNumber: 5,
                          onSelectedItemChanged: (int selectedNumber) {},
                        ),
                        HorizontalNumberPicker(
                          min: 1,
                          max: 30,
                          title: 'Long break',
                          suffix: 'Minutes',
                          height: 80.h,
                          width: constraints.maxWidth,
                          initialNumber: 15,
                          onSelectedItemChanged: (int selectedNumber) {},
                        ),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(height: 30.h),
              BackgroundContainer(
                height: 150,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ListTileSwitch(
                        title: 'Vibration',
                        description: 'Add vibration when an event comes.',
                        onChange: (bool value) {}),
                    ListTileSwitch(
                      title: 'Read the Status',
                      description: 'Read pomodoro timer status aloud.',
                      onChange: (bool value) {},
                    ),
                  ],
                ),
              )
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 50.h,
                width: 300.w,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text('Add New Task'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
