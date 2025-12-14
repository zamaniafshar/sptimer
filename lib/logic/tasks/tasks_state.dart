part of 'tasks_cubit.dart';

@freezed
abstract class TasksState with _$TasksState {
  const TasksState._();

  const factory TasksState({
    required bool isLoading,
    required ListModel tasks,
    required ListModel remainingTasks,
    required ListModel completedTasks,
  }) = _TasksState;

  factory TasksState.initial({
    required RemovedItemBuilder<Task> removeItemBuilder,
  }) =>
      TasksState(
        isLoading: true,
        tasks: ListModel.empty(
          removedItemBuilder: removeItemBuilder,
        ),
        remainingTasks: ListModel.empty(
          removedItemBuilder: removeItemBuilder,
        ),
        completedTasks: ListModel.empty(
          removedItemBuilder: removeItemBuilder,
        ),
      );
}

typedef RemovedItemBuilder<T> = Widget Function(
    T item, BuildContext context, Animation<double> animation);

@freezed
abstract class ListModel with _$ListModel {
  const ListModel._();
  const factory ListModel({
    required GlobalKey<AnimatedListState> listKey,
    required RemovedItemBuilder<Task> removedItemBuilder,
    required List<Task> items,
  }) = _ListModel;

  factory ListModel.empty({
    required RemovedItemBuilder<Task> removedItemBuilder,
  }) =>
      ListModel(
        listKey: GlobalKey<AnimatedListState>(),
        removedItemBuilder: removedItemBuilder,
        items: [],
      );

  AnimatedListState? get _animatedList => listKey.currentState;

  ListModel init(List<Task> initItems) {
    _initAnimatedList(initItems.length);
    return copyWith(items: initItems);
  }

  void _initAnimatedList(int length) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (_animatedList == null) return _initAnimatedList(length);

      for (int i = 0; i < length; i++) {
        _animatedList!.insertItem(i);
        await Future.delayed(const Duration(milliseconds: 100));
      }
    });
  }

  ListModel add(Task item) {
    final newItems = List.of(items);
    newItems.insert(0, item);
    _animatedList?.insertItem(0);
    return copyWith(items: newItems);
  }

  ListModel remove(String taskId) {
    final newItems = List.of(items);
    final removedItemIndex = newItems.indexWhere((item) => item.id == taskId);
    if (removedItemIndex != -1) {
      final removedItem = newItems.removeAt(removedItemIndex);

      _animatedList?.removeItem(removedItemIndex, (
        BuildContext context,
        Animation<double> animation,
      ) {
        return removedItemBuilder(removedItem, context, animation);
      });
    }
    return copyWith(items: newItems);
  }

  ListModel update(Task task) {
    final newItems = List.of(items);
    newItems.updateById(task);
    return copyWith(items: newItems);
  }

  int get length => items.length;

  Task operator [](int index) => items[index];
}
