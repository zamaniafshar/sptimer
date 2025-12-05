import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sptimer/common/logger/app_bloc_observer.dart';
import 'package:sptimer/sptimer_app.dart';
import 'package:sptimer/common/service_locator/service_locator.dart';

void main() async {
  Bloc.observer = AppBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();

  await setupServiceLocator();

  runApp(SptimerApp());
}
