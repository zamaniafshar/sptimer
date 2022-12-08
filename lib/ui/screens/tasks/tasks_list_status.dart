enum TasksListStatus {
  loading,
  loaded,
  error;

  bool get isLoading => this == loading;
  bool get isLoaded => this == loaded;
  bool get isError => this == error;
}
