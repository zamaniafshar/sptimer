import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
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
    _itemPositionsListener.itemPositions.addListener(_onScroll);
  }

  final TasksReportageRepository _tasksReportageRepository;
  final _itemScrollController = ItemScrollController();
  final _itemPositionsListener = ItemPositionsListener.create();
  bool _isScrollingToSpecificDate = false;

  ItemScrollController get itemScrollController => _itemScrollController;
  ItemPositionsListener get itemPositionsListener => _itemPositionsListener;

  @override
  Future<void> close() async {
    _itemPositionsListener.itemPositions.removeListener(_onScroll);
    super.close();
  }

  void _onScroll() {
    final positions = _itemPositionsListener.itemPositions.value;
    if (positions.isEmpty) return;

    final isAtEnd = positions.lastOrNull?.index == state.reportages.length - 1;
    if (isAtEnd) {
      loadMore();
    }

    if (_isScrollingToSpecificDate) return;
    final currentVisible = positions.lastOrNull;
    if (currentVisible != null) {
      final index = currentVisible.index;
      final visibleReportage = state.reportages[index];
      emit(state.copyWith(visibleReportage: visibleReportage));
    }
  }

  Future<void> scrollToDate(DateTime date) async {
    emit(
      state.copyWith(
        scrollToDateStatus: TasksReportageScrollToDateStatus.inProgress,
      ),
    );
    int index = state.reportages.indexWhere(
      (reportage) => reportage.startDate.isInSameDay(date),
    );

    if (index == -1) {
      return _loadAndThenScrollToIndex(date, index);
    }

    await _scrollToIndex(index);
  }

  Future<void> _loadAndThenScrollToIndex(DateTime date, int index) async {
    final start = state.reportages.last.startDate;
    final end = date;
    final newReportages = await _tasksReportageRepository.getAllReportagesInDates(start, end);
    final updatedReportages = [...state.reportages, ...newReportages];

    emit(
      state.copyWith(
        reportages: updatedReportages,
      ),
    );

    index = state.reportages.indexWhere(
      (reportage) => reportage.startDate.isInSameDay(date),
    );

    if (index == -1) {
      emit(
        state.copyWith(
          scrollToDateStatus: TasksReportageScrollToDateStatus.noReportage,
        ),
      );
    } else {
      await _scrollToIndex(index);
    }
  }

  Future<void> _scrollToIndex(int index) async {
    _isScrollingToSpecificDate = true;
    await _itemScrollController.scrollTo(
      index: index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    _isScrollingToSpecificDate = false;

    emit(
      state.copyWith(
        visibleReportage: state.reportages[index],
        scrollToDateStatus: TasksReportageScrollToDateStatus.success,
      ),
    );
  }

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
