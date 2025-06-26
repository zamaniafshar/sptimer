part of 'service_locator.dart';

Future<void> _registerRepositories() async {
  final tasksReportage = await Database.create(Constants.taskReportageDB);
  locator.registerSingleton(TasksReportageRepository(tasksReportage));
}
