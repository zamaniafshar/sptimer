import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pomotimer/theme/app_colors.dart';
import 'package:pomotimer/theme/theme_manager.dart';
import 'package:pomotimer/ui/screens/home/widgets/animated_theme_button.dart';
import 'package:get/get.dart';
import 'package:pomotimer/ui/widgets/circle_neumorphic_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Tasks',
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Icon(
              Icons.sunny,
              size: 35,
              color: Colors.black87,
            ),
            // child: Container(
            //   decoration: BoxDecoration(
            //     shape: BoxShape.circle,
            //     gradient: LinearGradient(
            //       begin: Alignment.topLeft,
            //       end: Alignment.bottomRight,
            //       colors: [
            //         AppColors.lightBlue.shade300,
            //         AppColors.lightBlue.shade700,
            //       ],
            //     ),
            //   ),
            //   child: AnimatedThemeButton(
            //     radius: 37.r,
            //     showMoonAtFirst: true,
            //     onChange: (value) {
            //       Get.find<ThemeManager>().toggleTheme();
            //     },
            //   ),
            // ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: theme.backgroundColor,
        shape: const CircularNotchedRectangle(),
        notchMargin: 12,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 40,
                padding: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: theme.primaryColorDark,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.home_outlined,
                      color: Colors.white,
                      size: 25,
                    ),
                    10.horizontalSpace,
                    Text(
                      'Home',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 40,
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Icon(
                      Icons.category_outlined,
                      color: Colors.black87,
                      size: 25,
                    ),
                    10.horizontalSpace,
                    Text(
                      'Status',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: CircleNeumorphicButton(
        height: 65.r,
        width: 65.r,
        icon: Icon(
          Icons.add,
          color: Colors.white,
        ),
        color: theme.primaryColor,
        onTap: () {},
      ),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            Container(
              height: 50.h,
              margin: EdgeInsets.symmetric(horizontal: 10),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.lightBlue.shade300,
                    AppColors.lightBlue.shade700,
                  ],
                ),
              ),
              child: TabBar(
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white70,
                // unselectedLabelStyle: TextStyle(fontSize: 13),
                labelPadding: EdgeInsets.zero,
                indicatorPadding: EdgeInsets.zero,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white30,
                ),
                tabs: [
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('All'),
                        5.horizontalSpace,
                        Container(
                          width: 25.w,
                          height: 25.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: theme.backgroundColor.withOpacity(0.3),
                          ),
                          child: Text('6'),
                        ),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Done'),
                        5.horizontalSpace,
                        Container(
                          width: 25.w,
                          height: 25.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: theme.backgroundColor.withOpacity(0.3),
                          ),
                          child: Text('2'),
                        ),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Remain'),
                        5.horizontalSpace,
                        Container(
                          width: 25.w,
                          height: 25.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: theme.backgroundColor.withOpacity(0.3),
                          ),
                          child: Text('4'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                itemCount: 5,
                itemExtent: 110,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: Neumorphic(
                      padding: EdgeInsets.all(15.r),
                      style: NeumorphicStyle(
                        color: theme.colorScheme.surface,
                        shadowLightColor: Colors.black12,
                        depth: 5,
                        boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(15.r),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Programming',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      '0/4',
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                                15.verticalSpace,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '25 minutes',
                                      style: TextStyle(
                                        color: Colors.black54,
                                      ),
                                    ),
                                    Text(
                                      '5 minutes',
                                      style: TextStyle(
                                        color: Colors.black54,
                                      ),
                                    ),
                                    Text(
                                      '15 minutes',
                                      style: TextStyle(
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          10.horizontalSpace,
                          CircleNeumorphicButton(
                            height: 50.r,
                            width: 50.r,
                            icon: Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                            ),
                            color: theme.primaryColor,
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
