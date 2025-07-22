import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sptimer/config/localization/app_localizations.dart';
import 'package:sptimer/config/localization/localization_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sptimer/config/routes/app_router.dart';
import 'package:sptimer/config/theme/theme_cubit.dart';
import 'package:sptimer/common/service_locator/service_locator.dart';
import 'package:sptimer/logic/tasks/tasks_cubit.dart';

class SptimerApp extends StatelessWidget {
  SptimerApp({Key? key}) : super(key: key);

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: locator<LocalizationCubit>()),
        BlocProvider.value(value: locator<ThemeCubit>()),
        BlocProvider.value(value: locator<TasksCubit>()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        builder: (_, __) {
          return Builder(
            builder: (context) {
              final locale = context.watch<LocalizationCubit>().state;
              final themeState = context.watch<ThemeCubit>().state;
              final theme = themeState.createThemeData(locale);

              return MaterialApp.router(
                debugShowCheckedModeBanner: false,
                title: 'Sptimer',
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                locale: locale,
                color: theme.scaffoldBackgroundColor,
                theme: theme,
                routerConfig: _appRouter.config(),
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
