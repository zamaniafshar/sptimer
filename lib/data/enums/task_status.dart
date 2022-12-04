enum TaskStatus {
  init,
  remain,
  done;

  bool get isInit => this == init;
  bool get isRemain => this == remain;
  bool get isDone => this == done;
}
