part of 'service_locator.dart';

Future<void> _registerGlobalBlocs() async {
  locator.registerSingleton(
    await LocalizationCubit.create(locator()),
  );

  locator.registerSingleton(
    await ThemeCubit.create(locator()),
  );
}
