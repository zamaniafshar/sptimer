import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sptimer/data/models/task.dart';
import 'package:sptimer/view/add_edit_task/add_edit_task_screen.dart';
import 'package:sptimer/view/base/base_screen.dart';
import 'package:sptimer/view/introduction/app_introduction_screen.dart';
import 'package:sptimer/view/pomodoro_timer/pomodoro_timer_screen.dart';
import 'package:sptimer/view/splash/splash_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, path: '/', initial: true),
        AutoRoute(page: BaseRoute.page, path: '/base'),
        AutoRoute(page: PomodoroTimerRoute.page, path: '/pomodoro-timer'),
        AutoRoute(page: AddEditTaskRoute.page, path: '/add-task'),
        AutoRoute(page: AppIntroductionRoute.page, path: '/introduction'),
      ];
}
