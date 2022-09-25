import 'package:flutter/material.dart';
import 'package:pomotimer/dependencies/initial_dependencies.dart';
import 'package:pomotimer/pomotimer_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initInitialDependencies();
  runApp(const PomoTimerApp());
}
