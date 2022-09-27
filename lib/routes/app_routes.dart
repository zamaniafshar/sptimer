import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomotimer/routes/routes_name.dart';
import 'package:pomotimer/ui/screens/add_pomodoro_task/add_pomodoro_task_screen.dart';
import 'package:pomotimer/ui/screens/add_pomodoro_task/add_pomodoro_task_screen_controller.dart';
import 'package:pomotimer/ui/screens/base/base_screen.dart';
import 'package:pomotimer/ui/screens/tasks/tasks_screen.dart';
import 'package:pomotimer/ui/screens/start_pomodoro_task_screen/start_pomodoro_task_screen.dart';

final Map<String, WidgetBuilder> appRoutes = {
  RoutesName.baseScreen: (_) => BaseScreen(),
  RoutesName.startPomodoroTaskScreen: (_) => StartPomodoroTaskScreen(),
  RoutesName.addPomodoroTaskScreen: (_) => AddPomodoroTaskScreen(),
};

Route onGenerateRoute(RouteSettings settings) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) {
      return appRoutes[settings.name]!(context);
    },
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final tweenOffset = Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero);
      final curveTween = CurveTween(curve: Curves.ease);
      return SlideTransition(
        position: animation.drive(tweenOffset.chain(curveTween)),
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
