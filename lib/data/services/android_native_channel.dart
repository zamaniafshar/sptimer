import 'dart:async';
import 'package:flutter/services.dart';
import 'package:sptimer/data/models/pomodoro_app_state_data.dart';

class AndroidNativeChannel {
  static const _platformChannel = MethodChannel('ActivityChannel');

  Future<bool> get isServiceRunning async =>
      await _platformChannel.invokeMethod('isServiceRunning');

  Future<bool> startService(PomodoroAppSateData initData) async {
    return (await _platformChannel.invokeMethod('startService', initData.toMap()));
  }

  Future<PomodoroAppSateData?> stopService() async {
    final data = await _platformChannel.invokeMethod('stopService');
    return PomodoroAppSateData.fromMap(data);
  }

  Future<PomodoroAppSateData?> getState() async {
    final data = await _platformChannel.invokeMethod('getState');
    if (data == null) return null;
    return PomodoroAppSateData.fromMap(data);
  }

  Future<void> saveState(PomodoroAppSateData appSateData) async {
    await _platformChannel.invokeMethod('saveState', appSateData.toMap());
  }
}
