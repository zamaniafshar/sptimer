part of 'service_locator.dart';

Future<void> _registerRepositories() async {
  final tasksReportage = await DatabaseFactory.createAdvanced(Constants.taskReportageDB);
  locator.registerSingleton(TasksReportageRepository(tasksReportage));
}
