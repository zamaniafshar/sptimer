import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomotimer/app_life_cycle.dart';
import 'package:pomotimer/controller/app_settings_controller.dart';
import 'package:pomotimer/controller/main_controller.dart';
import 'package:pomotimer/localization/app_localization.dart';
import 'package:pomotimer/localization/localizations.dart';
import 'package:pomotimer/routes/app_routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class PomoTimerApp extends StatelessWidget {
  const PomoTimerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppLifeCycle(
      child: ScreenUtilInit(
          designSize: const Size(360, 690),
          builder: (_, __) {
            return GetBuilder<AppSettingsController>(
              initState: (_) => Get.find<AppSettingsController>().initializeTheme(),
              builder: (controller) {
                return AppLocalization(
                  appTexts: controller.appTexts,
                  isEnglish: controller.isEnglish,
                  child: MaterialApp(
                    debugShowCheckedModeBanner: false,
                    onGenerateTitle: (context) => AppLocalization.of(context).appName,
                    localizationsDelegates: const [
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],
                    supportedLocales: supportedLocales,
                    locale: controller.appTexts.locale,
                    color: controller.theme.backgroundColor,
                    theme: controller.theme,
                    onGenerateInitialRoutes: onGenerateInitialRoutes,
                    onGenerateRoute: onGenerateRoute,
                    initialRoute: Get.find<MainController>().initialRoute,
                    builder: _builder,
                  ),
                );
              },
            );
          }),
    );
  }

  Widget _builder(context, widget) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: widget!,
    );
  }
}
