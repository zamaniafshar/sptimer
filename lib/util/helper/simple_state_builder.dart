import 'package:flutter/material.dart';

typedef SimpleStateBuilderUpdater = void Function();
typedef SimpleStateBuilderBuilderCallBack = Widget Function(
    BuildContext context, SimpleStateBuilderUpdater updater);

class SimpleStateBuilder extends StatefulWidget {
  const SimpleStateBuilder({
    Key? key,
    required this.builder,
    this.onInit,
    this.onUpdate,
    this.onDispose,
  }) : super(key: key);

  final SimpleStateBuilderBuilderCallBack builder;
  final VoidCallback? onInit;
  final VoidCallback? onUpdate;
  final VoidCallback? onDispose;
  @override
  State<SimpleStateBuilder> createState() => _SimpleStateBuilderState();
}

class _SimpleStateBuilderState extends State<SimpleStateBuilder> {
  @override
  void initState() {
    widget.onInit?.call();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant SimpleStateBuilder oldWidget) {
    widget.onUpdate?.call();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    widget.onDispose?.call();
    super.dispose();
  }

  void updater() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, updater);
  }
}
