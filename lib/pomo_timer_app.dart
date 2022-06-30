import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomotimer/app_life_cycle.dart';
import 'package:pomotimer/routes/app_routes.dart';
import 'package:pomotimer/routes/routes_name.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PomoTimerApp extends StatelessWidget {
  const PomoTimerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppLifeCycle(
      child: ScreenUtilInit(
        designSize: const Size(360, 640),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, __) => GetMaterialApp(
          getPages: appRoutes,
          initialRoute: RoutesName.homeScreen,
          builder: _builder,
        ),
      ),
    );
  }

  Widget _builder(context, widget) {
    ScreenUtil.init(context);
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: widget!,
    );
  }
}
