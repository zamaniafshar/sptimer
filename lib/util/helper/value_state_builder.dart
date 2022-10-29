import 'package:flutter/material.dart';

typedef ValueStateBuilderUpdater<T> = void Function(T);
typedef ValueStateBuilderBuilderCallBack<T> = Widget Function(
    BuildContext context, T value, ValueStateBuilderUpdater<T> updater);

class ValueStateBuilder<T> extends StatefulWidget {
  const ValueStateBuilder(
      {Key? key,
      required this.builder,
      required this.initialValue,
      this.onInit,
      this.onUpdate,
      this.onDispose})
      : super(key: key);

  final T initialValue;
  final ValueStateBuilderBuilderCallBack<T> builder;
  final VoidCallback? onInit;
  final VoidCallback? onUpdate;
  final VoidCallback? onDispose;
  @override
  State<ValueStateBuilder<T>> createState() => _ValueStateBuilderState<T>();
}

class _ValueStateBuilderState<T> extends State<ValueStateBuilder<T>> {
  late T value;
  @override
  void initState() {
    value = widget.initialValue;
    widget.onInit?.call();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ValueStateBuilder<T> oldWidget) {
    widget.onUpdate?.call();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    widget.onDispose?.call();
    super.dispose();
  }

  void updater(T newValue) {
    value = newValue;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, value, updater);
  }
}
