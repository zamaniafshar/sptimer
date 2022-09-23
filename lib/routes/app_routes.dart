import 'package:get/get.dart';
import 'package:pomotimer/bindings/start_pomodoro_task_screen_binding.dart';
import 'package:pomotimer/routes/routes_name.dart';
import 'package:pomotimer/ui/screens/add_pomodoro_task/add_pomodoro_task_screen.dart';
import 'package:pomotimer/ui/screens/add_pomodoro_task/add_pomodoro_task_screen_controller.dart';
import 'package:pomotimer/ui/screens/base/base_screen.dart';
import 'package:pomotimer/ui/screens/tasks/tasks_screen.dart';
import 'package:pomotimer/ui/screens/start_pomodoro_task_screen/start_pomodoro_task_screen.dart';

final appRoutes = [
  GetPage(
    name: RoutesName.baseScreen,
    page: () => BaseScreen(),
  ),
  GetPage(
    transition: Transition.rightToLeftWithFade,
    name: RoutesName.startPomodoroTaskScreen,
    binding: StartPomodoroTaskScreenBinding(),
    page: () => StartPomodoroTaskScreen(),
  ),
  GetPage(
    transition: Transition.rightToLeftWithFade,
    name: RoutesName.addPomodoroTaskScreen,
    binding: BindingsBuilder.put(() => AddPomodoroTaskScreenController()),
    page: () => AddPomodoroTaskScreen(),
  ),
];
