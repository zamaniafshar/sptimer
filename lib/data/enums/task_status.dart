enum TaskStatus {
  uncompleted,
  completed;

  bool get isUncompleted => this == uncompleted;
  bool get isCompleted => this == completed;
}
