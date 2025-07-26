part of 'service_locator.dart';

Future<void> _registerServices() async {
  await RiveFile.initialize();
  await Hive.initFlutter();

  final database = await DatabaseFactory.createSimpleDB();
  locator.registerSingleton(database);

  final pomodoroTimerService = PomodoroTimerService();
  await pomodoroTimerService.init();
  locator.registerSingleton(pomodoroTimerService);
}
