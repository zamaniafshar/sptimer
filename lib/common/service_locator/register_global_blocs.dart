part of 'service_locator.dart';

Future<void> _registerBlocs() async {
  locator.registerSingleton(
    LocalizationCubit.create(locator()),
  );

  locator.registerSingleton(
    ThemeCubit.create(locator()),
  );

  locator.registerFactory<TasksCubit>(
    () => TasksCubit(
      tasksRepository: locator(),
      reportageRepository: locator(),
      removeItemBuilder: (item, context, animation) => TaskWidget(
        animation: animation,
        task: item,
      ),
    ),
  );
}
