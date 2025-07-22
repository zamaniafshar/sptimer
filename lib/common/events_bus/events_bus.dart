import 'dart:async';

import 'package:sptimer/common/events_bus/events.dart';

abstract final class EventsBus {
  static final _controller = StreamController<GlobalEvent>.broadcast();

  static Stream<GlobalEvent> get events => _controller.stream;

  static Stream<T> on<T extends GlobalEvent>() {
    return events
        .where(
          (e) => e is T,
        )
        .map((e) => e as T);
  }

  static void fire(GlobalEvent event) {
    _controller.add(event);
  }
}
