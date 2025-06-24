import 'dart:async';

import 'package:sptimer/common/events_bus/events.dart';

abstract final class EventsBus {
  final _controller = StreamController<GlobalEvent>.broadcast();

  Stream<GlobalEvent> get events => _controller.stream;

  StreamSubscription on<T extends GlobalEvent>(
    void Function(T event) handler,
  ) {
    return events.where((e) => e is T).listen((e) => handler(e as T));
  }

  void add(GlobalEvent event) {
    _controller.add(event);
  }
}
