import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sptimer/config/localization/app_localizations.dart';
import 'package:sptimer/config/localization/localization_cubit.dart';
import 'package:sptimer/config/routes/app_routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sptimer/config/theme/theme_cubit.dart';
import 'package:sptimer/common/extensions/extensions.dart';
import 'package:sptimer/common/service_locator/service_locator.dart';

class SptimerApp extends StatelessWidget {
  const SptimerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: locator<LocalizationCubit>()),
        BlocProvider.value(value: locator<ThemeCubit>()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        builder: (_, __) {
          return Builder(
            builder: (context) {
              final locale = context.watch<LocalizationCubit>().state;
              final themeState = context.watch<ThemeCubit>().state;
              final theme = themeState.createThemeData(locale);

              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Sptimer',
                localizationsDelegates: const [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: AppLocalizations.supportedLocales,
                locale: locale,
                color: theme.scaffoldBackgroundColor,
                theme: theme,
                onGenerateInitialRoutes: onGenerateInitialRoutes,
                onGenerateRoute: onGenerateRoute,
                initialRoute: getInitialRoute(),
                builder: _builder,
              );
            },
          );
        },
      ),
    );
  }

  Widget _builder(context, widget) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: widget!,
    );
  }
}
