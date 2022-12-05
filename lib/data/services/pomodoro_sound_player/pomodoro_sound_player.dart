import 'package:just_audio/just_audio.dart';
import 'package:pomotimer/data/enums/pomodoro_status.dart';
import 'package:pomotimer/data/enums/tones.dart';
import 'package:pomotimer/data/models/pomodoro_task_model.dart';
import 'package:pomotimer/utils/utils.dart';
import 'package:real_volume/real_volume.dart';
import 'package:vibration/vibration.dart';
import 'package:audio_session/audio_session.dart';

const _ringtoneAudioConfig = AudioSessionConfiguration(
  avAudioSessionCategory: AVAudioSessionCategory.playback,
  avAudioSessionMode: AVAudioSessionMode.defaultMode,
  androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
  androidAudioAttributes: AndroidAudioAttributes(
    contentType: AndroidAudioContentType.speech,
    flags: AndroidAudioFlags.none,
    usage: AndroidAudioUsage.notificationRingtone,
  ),
);

class PomodoroSoundPlayer {
  late AudioPlayer _tonePlayer;
  late AudioPlayer _statusPlayer;

  Future<void> init() async {
    _statusPlayer = AudioPlayer();
    _tonePlayer = AudioPlayer();
    (await AudioSession.instance).configure(_ringtoneAudioConfig);
  }

  Future<bool> isSoundPlayerMuted(PomodoroTaskModel task) async {
    if (await canVibrate() && task.vibrate) return false;
    return (task.tone == Tones.none && task.readStatusAloud == false) ||
        await isRingerMuted() ||
        (task.statusVolume == 0.0 && task.toneVolume == 0.0);
  }

  Future<bool> isRingerMuted() async {
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
    if (await isRingerMuted()) return;
    await RealVolume.setVolume(volume, showUI: false, streamType: StreamType.RING);
  }

  Future<void> playTone(Tones tone) async {
    final path = '$kTonesBasePath${tone.name}.${tone.type}';
    await _tonePlayer.setAsset(path);
    await _tonePlayer.play();
  }

  Future<void> playPomodoroSound(PomodoroTaskModel task) async {
    if (await isRingerMuted()) return;
    if (task.vibrate) {
      vibrate();
    }
    if (task.tone != Tones.none && task.toneVolume != 0.0) {
      await setVolume(task.toneVolume);
      playTone(task.tone);
    }
    if (task.readStatusAloud && task.statusVolume != 0.0) {
      await Future.delayed(const Duration(seconds: 1));
      await setVolume(task.toneVolume);
      await readStatusAloud(status: task.pomodoroStatus);
    }
  }

  Future<void> readStatusAloud({
    required PomodoroStatus status,
  }) async {
    if (status.isWorkTime) {
      await _statusPlayer.setAsset(kWorkTimeSoundPath);
    } else if (status.isShortBreakTime) {
      await _statusPlayer.setAsset(kShortBreakTimeSoundPath);
    } else {
      await _statusPlayer.setAsset(kLongBreakSoundPath);
    }
    await _statusPlayer.play();
  }

  Future<void> dispose() async {
    await _statusPlayer.dispose();
    await _tonePlayer.dispose();
  }
}
