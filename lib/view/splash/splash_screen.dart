import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:sptimer/common/constants/assets.dart';
import 'package:sptimer/common/database/database.dart';
import 'package:sptimer/common/service_locator/service_locator.dart';
import 'package:sptimer/config/routes/app_router.dart';
import 'package:sptimer/data/services/pomodoro_timer_service.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), navigateTo);
    super.initState();
  }

  Future<void> navigateTo() async {
    final pomodoroTimerService = locator<PomodoroTimerService>();
    final database = locator<SimpleDatabase>();

    final isFirstRun = database.get('is_first') as bool? ?? true;
    final timerState = await pomodoroTimerService.state;

    if (isFirstRun) {
      context.router.replace(AppIntroductionRoute());
    } else if (timerState != null) {
      context.router.replaceAll([
        BaseRoute(),
        PomodoroTimerRoute(task: timerState.task),
      ]);
    } else {
      context.router.replace(BaseRoute());
    }

    database.save('is_first', false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          Assets.appIcon,
          height: 250.w,
          width: 250.w,
        ),
      ),
    );
  }
}
