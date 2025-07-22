part of 'service_locator.dart';

Future<void> _registerRepositories() async {
  final tasksReportageDB = await DatabaseFactory.createAdvanced(Constants.taskReportageDB);
  locator.registerSingleton(TasksReportageRepository(tasksReportageDB));

  final tasksDB = await DatabaseFactory.createAdvanced('tasks');
  locator.registerSingleton(TasksRepository(tasksDB));
}
