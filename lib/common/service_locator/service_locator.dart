import 'package:get_it/get_it.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:hive_ce/hive.dart';
import 'package:rive/rive.dart';
import 'package:sptimer/common/database/database_factory.dart';
import 'package:sptimer/config/localization/localization_cubit.dart';
import 'package:sptimer/config/theme/theme_cubit.dart';
import 'package:sptimer/data/repositories/tasks_reportage_repository.dart';
import 'package:sptimer/data/repositories/tasks_repository.dart';
import 'package:sptimer/data/services/pomodoro_timer_service.dart';
import 'package:sptimer/common/constants/constants.dart';
import 'package:sptimer/common/database/database.dart';
import 'package:sptimer/logic/pomodoro_timer/pomodoro_timer_cubit.dart';
import 'package:sptimer/logic/tasks/tasks_cubit.dart';
import 'package:sptimer/view/tasks/widgets/task_widget.dart';

part 'register_global_blocs.dart';
part 'register_repositories.dart';
part 'register_services.dart';

final locator = GetIt.instance;

Future<void> setupServiceLocator() async {
  await _registerServices();
  await _registerRepositories();
  await _registerBlocs();
}
