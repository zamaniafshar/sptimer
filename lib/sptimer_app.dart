import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sptimer/app_life_cycle.dart';
import 'package:sptimer/controller/app_settings_controller.dart';
import 'package:sptimer/config/localization/app_localization.dart';
import 'package:sptimer/config/localization/localizations.dart';
import 'package:sptimer/config/routes/app_routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class SptimerApp extends StatelessWidget {
  const SptimerApp({Key? key}) : super(key: key);

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
                  localization: controller.localization,
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
                    locale: controller.localization.locale,
                    color: controller.theme.backgroundColor,
                    theme: controller.theme,
                    onGenerateInitialRoutes: onGenerateInitialRoutes,
                    onGenerateRoute: onGenerateRoute,
                    initialRoute: getInitialRoute(),
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
