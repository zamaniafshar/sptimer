part of 'tasks_reportage_list_cubit.dart';

@freezed
abstract class TasksReportageListState with _$TasksReportageListState {
  const TasksReportageListState._();

  const factory TasksReportageListState({
    required bool isLoading,
    required bool isLoadingMore,
    required List<TaskReportage> reportages,
    required bool hasReachedEnd,
    required int currentPage,
    required Exception? error,
    required TaskReportage? visibleReportage,
    required TasksReportageScrollToDateStatus scrollToDateStatus,
  }) = _TasksReportageListState;

  factory TasksReportageListState.initial() => const TasksReportageListState(
    isLoading: true,
    isLoadingMore: false,
    reportages: [],
    hasReachedEnd: false,
    currentPage: 0,
    error: null,
    visibleReportage: null,
    scrollToDateStatus: TasksReportageScrollToDateStatus.initial,
  );
}

enum TasksReportageScrollToDateStatus {
  initial,
  inProgress,
  noReportage,
  success,
}
