enum TasksReportageListViewState {
  empty,
  error,
  initialLoading,
  loadingAtCenter,
  loadingAtBottom,
  loadingAtTop,
  loaded;

  bool get isEmpty => this == empty;
  bool get isError => this == error;
  bool get isInitialLoading => this == initialLoading;
  bool get isLoadingAtCenter => this == loadingAtCenter;
  bool get isLoadingAtBottom => this == loadingAtBottom;
  bool get isLoadingAtTop => this == loadingAtTop;
  bool get isLoaded => this == loaded;
}
