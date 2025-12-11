import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sptimer/common/extensions/extensions.dart';
import 'package:sptimer/common/service_locator/service_locator.dart';
import 'package:sptimer/config/localization/localization_cubit.dart';
import 'package:sptimer/logic/calendar/date_picker/custom_date_picker_cubit.dart';
import 'calendar_screen_controller.dart';
import 'widgets/custom_date_picker/custom_date_picker.dart';
import 'widgets/tasks_reportage_list_view/tasks_reportage_list_view.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> with AutomaticKeepAliveClientMixin {
  // late final CalendarScreenController controller;
  late CustomDatePickerCubit _datePickerCubit;

  @override
  void initState() {
    // controller = Get.find();
    // controller.screenNotifier.listen((event) {
    //   if (!mounted) return;
    //   ScaffoldMessenger.of(context).hideCurrentSnackBar();
    //   if (event.isTaskNotFound) {
    //     showCalendarTaskNotFoundSnackBar(context);
    //   } else {
    //     showCalendarScreenErrorSnackbar(context);
    //   }
    // });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final isEnglish = context.watch<LocalizationCubit>().state.isEnglish;
    _datePickerCubit = CustomDatePickerCubit(
      datePickerType: isEnglish ? DatePickerType.english : DatePickerType.persian,
      reportageRepository: locator(),
    );

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _datePickerCubit.close();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider.value(
      value: _datePickerCubit,
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.localization.calendarTitle),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomDatePicker(),
            Expanded(child: SizedBox()),
            // const Expanded(child: TasksReportageListView()),
          ],
        ),
      ),
    );
  }
}
