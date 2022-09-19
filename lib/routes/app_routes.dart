import 'package:get/get.dart';
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
    name: RoutesName.tasksScreen,
    page: () => TasksScreen(),
  ),
  GetPage(
    name: RoutesName.startPomodoroTaskScreen,
    page: () => StartPomodoroTaskScreen(),
  ),
  GetPage(
    name: RoutesName.addPomodoroTaskScreen,
    binding: BindingsBuilder.put(() => AddPomodoroTaskScreenController()),
    page: () => AddPomodoroTaskScreen(),
  ),
];
