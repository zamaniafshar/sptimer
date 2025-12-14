enum CalendarScreenEvent {
  taskNotFound,
  error;

  bool get isTaskNotFound => this == taskNotFound;
  bool get isError => this == error;
}
