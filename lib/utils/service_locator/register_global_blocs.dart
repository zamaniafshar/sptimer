part of 'service_locator.dart';

Future<void> _registerGlobalBlocs() async {
  locator.registerSingleton(
    LocalizationCubit.create(locator()),
  );

  locator.registerSingleton(
    ThemeCubit.create(locator()),
  );
}
