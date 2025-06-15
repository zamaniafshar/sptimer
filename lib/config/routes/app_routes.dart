import 'package:flutter/material.dart';
import 'package:sptimer/data/models/task.dart';
import 'package:sptimer/config/routes/routes_name.dart';
import 'package:sptimer/view/add_pomodoro_task/add_pomodoro_task_screen.dart';
import 'package:sptimer/view/base/base_screen.dart';
import 'package:sptimer/view/introduction/app_introduction_screen.dart';
import 'package:sptimer/view/pomodoro_timer/pomodoro_timer_screen.dart';

final Map<String, WidgetBuilder> appRoutes = {
  RoutesName.baseScreen: (context) => const BaseScreen(),
  RoutesName.startPomodoroTaskScreen: (context) => const PomodoroTimerScreen(),
  RoutesName.addPomodoroTaskScreen: (context) => AddPomodoroTaskScreen(
        task: ModalRoute.of(context)!.settings.arguments as Task?,
      ),
  RoutesName.appIntroductionScreen: (context) => const AppIntroductionScreen(),
};

Route onGenerateRoute(RouteSettings settings) {
  final curveTween = CurveTween(curve: Curves.ease);
  final tweenOffset = Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero).chain(curveTween);
  return PageRouteBuilder(
    settings: settings,
    pageBuilder: (context, animation, secondaryAnimation) {
      return appRoutes[settings.name]!(context);
    },
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: animation.drive(tweenOffset),
        child: child,
      );
    },
  );
}

List<Route> onGenerateInitialRoutes(String initRoute) {
  if (initRoute == RoutesName.appIntroductionScreen) {
    return [
      MaterialPageRoute(builder: appRoutes[RoutesName.appIntroductionScreen]!),
    ];
  }
  return [
    MaterialPageRoute(builder: appRoutes[RoutesName.baseScreen]!),
    if (initRoute != RoutesName.baseScreen)
      MaterialPageRoute(builder: appRoutes[RoutesName.startPomodoroTaskScreen]!),
  ];
}

String getInitialRoute() {
  if (Get.find<AppController>().isTimerAlreadyStarted) {
    return '${RoutesName.baseScreen}/${RoutesName.startPomodoroTaskScreen}';
  }
  if (Get.find<AppSettingsController>().isFirstAppRun) {
    return RoutesName.appIntroductionScreen;
  }
  return RoutesName.baseScreen;
}
