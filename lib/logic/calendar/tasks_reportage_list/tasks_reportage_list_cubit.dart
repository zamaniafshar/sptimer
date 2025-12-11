import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sptimer/data/models/task_reportage.dart';
import 'package:sptimer/data/repositories/tasks_reportage_repository.dart';
import 'package:sptimer/common/extensions/extensions.dart';

part 'tasks_reportage_list_state.dart';
part 'tasks_reportage_list_cubit.freezed.dart';

class TasksReportageListCubit extends Cubit<TasksReportageListState> {
  TasksReportageListCubit({
    required TasksReportageRepository tasksReportageRepository,
  }) : _tasksReportageRepository = tasksReportageRepository,
       super(TasksReportageListState.initial()) {
    _loadInitial();
  }

  final TasksReportageRepository _tasksReportageRepository;

  static const int _pageSize = 20;

  Future<void> _loadInitial() async {
    try {
      emit(
        state.copyWith(
          isLoading: true,
          error: null,
        ),
      );

      final reportages = await _fetchReportages(pageIndex: 0);

      emit(
        state.copyWith(
          isLoading: false,
          reportages: reportages,
          currentPage: 0,
          hasReachedEnd: reportages.length < _pageSize,
        ),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          error: e,
        ),
      );
    }
  }

  Future<void> loadMore() async {
    if (state.isLoadingMore || state.hasReachedEnd) {
      return;
    }

    try {
      emit(state.copyWith(isLoadingMore: true));

      final newReportages = await _fetchReportages(
        pageIndex: state.currentPage + 1,
      );

      final updatedReportages = [...state.reportages, ...newReportages];

      emit(
        state.copyWith(
          isLoadingMore: false,
          reportages: updatedReportages,
          currentPage: state.currentPage + 1,
          hasReachedEnd: newReportages.length < _pageSize,
          error: null,
        ),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(
          isLoadingMore: false,
          error: e,
        ),
      );
    }
  }

  Future<void> refresh() async {
    try {
      emit(
        state.copyWith(
          isLoading: true,
          error: null,
        ),
      );

      final reportages = await _fetchReportages(pageIndex: 0);

      emit(
        state.copyWith(
          isLoading: false,
          reportages: reportages,
          currentPage: 0,
          hasReachedEnd: reportages.length < _pageSize,
        ),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          error: e,
        ),
      );
    }
  }

  Future<List<TaskReportage>> _fetchReportages({
    required int pageIndex,
  }) async {
    final today = DateTime.now();
    final startDate = today.add(Duration(days: pageIndex * _pageSize));
    final endDate = startDate.add(Duration(days: _pageSize - 1));

    // Fetch reportages for the date range
    final reportages = await _tasksReportageRepository.getAllReportagesInDates(
      startDate,
      endDate,
    );

    return reportages;
  }
}
