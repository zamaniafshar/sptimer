import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:hive/hive.dart';
import 'package:real_volume/real_volume.dart';
import 'package:sptimer/config/localization/localization_cubit.dart';
import 'package:sptimer/config/theme/theme_cubit.dart';
import 'package:sptimer/data/repositories/tasks_reportage_repository.dart';
import 'package:sptimer/data/services/pomodoro_timer_service.dart';
import 'package:sptimer/utils/constants/constants.dart';
import 'package:sptimer/utils/database.dart';
import 'package:vibration/vibration.dart';

part 'register_global_blocs.dart';
part 'register_repositories.dart';
part 'register_services.dart';

final locator = GetIt.instance;

Future<void> setupServiceLocator() async {
  await _registerServices();
  await _registerRepositories();
  await _registerGlobalBlocs();
}
