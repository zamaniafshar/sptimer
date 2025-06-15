import 'dart:async';

import 'package:flutter/material.dart';

mixin class StreamableChanges<Change> {
  final _streamController = StreamController<Change>.broadcast();

  Stream<Change> get changes => _streamController.stream;

  Future<void> close() async {
    await _streamController.close();
  }

  @protected
  void addChange(Change change) {
    _streamController.add(change);
  }
}
