import 'package:just_audio/just_audio.dart';
import 'package:pomotimer/data/enum/pomodoro_status.dart';
import 'package:pomotimer/data/enum/tones.dart';
import 'package:pomotimer/util/util.dart';
import 'package:real_volume/real_volume.dart';
import 'package:vibration/vibration.dart';
import 'package:audio_session/audio_session.dart';

class PomodoroSoundPlayer {
  PomodoroSoundPlayer() : _player = AudioPlayer();

  final AudioPlayer _player;
  bool _isInitialized = false;

  Future<bool> isMuted() async {
    return await RealVolume.getRingerMode() != RingerMode.NORMAL;
  }

  Future<bool> canVibrate() async {
    return (await RealVolume.getRingerMode() != RingerMode.SILENT) &&
        ((await Vibration.hasVibrator()) ?? false);
  }

  Future<void> vibrate() async {
    if (await canVibrate()) {
      await Vibration.vibrate(pattern: kVibrationPattern);
    }
  }

  Future<void> setVolume(double volume) async {
    if (await isMuted()) return;
    await RealVolume.setVolume(volume, showUI: false, streamType: StreamType.RING);
  }

  Future<void> playTone(Tones tone) async {
    final path = '$kTonesBasePath${tone.name}.${tone.type}';
    _play(path);
  }

  Future<void> playPomodoroSound({
    required PomodoroStatus status,
  }) async {
    if (status.isWorkTime) {
      await _play(kWorkTimeSoundPath);
    } else if (status.isShortBreakTime) {
      await _play(kShortBreakTimeSoundPath);
    } else {
      await _play(kLongBreakSoundPath);
    }
  }

  Future<void> _play(String path) async {
    if (!_isInitialized) {
      await _player.setAndroidAudioAttributes(
        const AndroidAudioAttributes(
          usage: AndroidAudioUsage.notificationRingtone,
        ),
      );
      _isInitialized = true;
    }
    await _player.setAsset(path);
    await _player.play();
  }

  Future<void> cancel() async {
    if (_player.playing) await _player.stop();
  }

  Future<void> dispose() async {
    await _player.dispose();
  }
}
