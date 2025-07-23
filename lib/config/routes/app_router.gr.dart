// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [AddPomodoroTaskScreen]
class AddPomodoroTaskRoute extends PageRouteInfo<AddPomodoroTaskRouteArgs> {
  AddPomodoroTaskRoute({Key? key, Task? task, List<PageRouteInfo>? children})
      : super(
          AddPomodoroTaskRoute.name,
          args: AddPomodoroTaskRouteArgs(key: key, task: task),
          initialChildren: children,
        );

  static const String name = 'AddPomodoroTaskRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddPomodoroTaskRouteArgs>(
        orElse: () => const AddPomodoroTaskRouteArgs(),
      );
      return WrappedRoute(
        child: AddPomodoroTaskScreen(key: args.key, task: args.task),
      );
    },
  );
}

class AddPomodoroTaskRouteArgs {
  const AddPomodoroTaskRouteArgs({this.key, this.task});

  final Key? key;

  final Task? task;

  @override
  String toString() {
    return 'AddPomodoroTaskRouteArgs{key: $key, task: $task}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AddPomodoroTaskRouteArgs) return false;
    return key == other.key && task == other.task;
  }

  @override
  int get hashCode => key.hashCode ^ task.hashCode;
}

/// generated route for
/// [AppIntroductionScreen]
class AppIntroductionRoute extends PageRouteInfo<void> {
  const AppIntroductionRoute({List<PageRouteInfo>? children})
      : super(AppIntroductionRoute.name, initialChildren: children);

  static const String name = 'AppIntroductionRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AppIntroductionScreen();
    },
  );
}

/// generated route for
/// [BaseScreen]
class BaseRoute extends PageRouteInfo<void> {
  const BaseRoute({List<PageRouteInfo>? children})
      : super(BaseRoute.name, initialChildren: children);

  static const String name = 'BaseRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const BaseScreen();
    },
  );
}

/// generated route for
/// [PomodoroTimerScreen]
class PomodoroTimerRoute extends PageRouteInfo<PomodoroTimerRouteArgs> {
  PomodoroTimerRoute({
    Key? key,
    required Task task,
    List<PageRouteInfo>? children,
  }) : super(
          PomodoroTimerRoute.name,
          args: PomodoroTimerRouteArgs(key: key, task: task),
          initialChildren: children,
        );

  static const String name = 'PomodoroTimerRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PomodoroTimerRouteArgs>();
      return WrappedRoute(
        child: PomodoroTimerScreen(key: args.key, task: args.task),
      );
    },
  );
}

class PomodoroTimerRouteArgs {
  const PomodoroTimerRouteArgs({this.key, required this.task});

  final Key? key;

  final Task task;

  @override
  String toString() {
    return 'PomodoroTimerRouteArgs{key: $key, task: $task}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PomodoroTimerRouteArgs) return false;
    return key == other.key && task == other.task;
  }

  @override
  int get hashCode => key.hashCode ^ task.hashCode;
}

/// generated route for
/// [SplashScreen]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
      : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SplashScreen();
    },
  );
}
