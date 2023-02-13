import 'package:flutter/material.dart';
import 'package:sptimer/data/models/pomodoro_task_model.dart';
import 'package:sptimer/config/routes/routes_name.dart';
import 'package:sptimer/ui/screens/add_pomodoro_task/add_pomodoro_task_screen.dart';
import 'package:sptimer/ui/screens/base/base_screen.dart';
import 'package:sptimer/ui/screens/start_pomodoro_task/start_pomodoro_task_screen.dart';

final Map<String, WidgetBuilder> appRoutes = {
  RoutesName.baseScreen: (context) => const BaseScreen(),
  RoutesName.startPomodoroTaskScreen: (context) => const StartPomodoroTaskScreen(),
  RoutesName.addPomodoroTaskScreen: (context) => AddPomodoroTaskScreen(
        task: ModalRoute.of(context)!.settings.arguments as PomodoroTaskModel?,
      ),
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
  final List<Route> result = [];
  result.add(
    MaterialPageRoute(builder: appRoutes[RoutesName.baseScreen]!),
  );
  if (initRoute != RoutesName.baseScreen) {
    result.add(
      MaterialPageRoute(builder: appRoutes[RoutesName.startPomodoroTaskScreen]!),
    );
  }

  return result;
}
