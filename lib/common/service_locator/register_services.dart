part of 'service_locator.dart';

Future<void> _registerServices() async {
  await Hive.initFlutter();

  final database = await DatabaseFactory.createSimpleDB();
  locator.registerSingleton(database);
  locator.registerSingleton(PomodoroTimerService());
}
