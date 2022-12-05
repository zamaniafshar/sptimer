enum TaskStatus {
  remain,
  done;

  bool get isRemain => this == remain;
  bool get isDone => this == done;
}
