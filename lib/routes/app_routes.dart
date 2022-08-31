import 'package:get/get.dart';
import 'package:pomotimer/routes/routes_name.dart';
import 'package:pomotimer/ui/screens/add_pomodoro_task/add_pomodoro_task_screen.dart';
import 'package:pomotimer/ui/screens/home/home_screen.dart';

final appRoutes = [
  GetPage(
    name: RoutesName.homeScreen,
    page: () => const HomeScreen(),
  ),
  GetPage(
    name: RoutesName.addPomodoroTaskScreen,
    page: () => const AddPomodoroTaskScreen(),
  ),
];
