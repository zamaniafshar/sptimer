import 'package:flutter/material.dart';
import 'package:sptimer/sptimer_app.dart';
import 'package:sptimer/utils/service_locator/service_locator.dart';

import 'data/repositories/tasks_reportage_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupServiceLocator();

  runApp(const SptimerApp());
}
