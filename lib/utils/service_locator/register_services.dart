part of 'service_locator.dart';

Future<void> _registerServices() async {
  await Hive.initFlutter();

  final database = await Database.open('app_db');
  locator.registerSingleton(database);
  locator.registerSingleton(PomodoroTimerService());
}
