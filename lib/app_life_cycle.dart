import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomotimer/controller/main_controller.dart';

class AppLifeCycle extends StatefulWidget {
  const AppLifeCycle({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  State<AppLifeCycle> createState() => _AppLifeCycleState();
}

class _AppLifeCycleState extends State<AppLifeCycle> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive) {
      Get.find<MainController>().onAppResume();
    } else if (state == AppLifecycleState.resumed) {
      Get.find<MainController>().init();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
