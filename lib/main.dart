import 'package:flutter/material.dart';
import 'package:sptimer/dependencies/initial_dependencies.dart';
import 'package:sptimer/sptimer_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initInitialDependencies();
  runApp(const SptimerApp());
}
