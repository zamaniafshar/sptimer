import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pomotimer/utils/utils.dart';

import 'calendar_screen_controller.dart';
import 'widgets/custom_date_picker/custom_date_picker.dart';
import 'widgets/tasks_reportage_list_view/tasks_reportage_list_view.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> with AutomaticKeepAliveClientMixin {
  late ThemeData theme;

  @override
  void initState() {
    final CalendarScreenController controller = Get.find();
    controller.screenNotifier.listen((event) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      if (event.isTaskNotFound) {
        showCalendarTaskNotFoundSnackBar(context);
      } else {
        showCalendarScreenErrorSnackbar(context);
      }
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    theme = Theme.of(context);
    super.didChangeDependencies();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomDatePicker(),
          Expanded(child: TasksReportageListView()),
        ],
      ),
    );
  }
}
