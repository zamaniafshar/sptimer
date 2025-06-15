import 'package:just_audio/just_audio.dart';
import 'package:sptimer/data/enums/pomodoro_status.dart';
import 'package:sptimer/data/enums/tones.dart';
import 'package:sptimer/data/models/task.dart';
import 'package:real_volume/real_volume.dart';
import 'package:sptimer/common/constants/assets.dart';
import 'package:sptimer/common/constants/constants.dart';
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

final class PomodoroSoundPlayer {
  late AudioPlayer _tonePlayer;
  late AudioPlayer _statusPlayer;

  Future<void> init() async {
    _statusPlayer = AudioPlayer();
    _tonePlayer = AudioPlayer();
    (await AudioSession.instance).configure(_ringtoneAudioConfig);
  }

  Future<bool> isSoundPlayerMuted(Task task) async {
    if (await canVibrate() && task.vibrate) return false;
    return (task.tone == Tones.none && task.readStatusAloud == false) ||
        await isRingerMuted() ||
        (task.statusVolume == 0.0 && task.toneVolume == 0.0);
  }

  Future<bool> isRingerMuted() async {
    return await RealVolume.getRingerMode() == RingerMode.SILENT;
  }

  Future<bool> cantPlaySound() async {
    return await RealVolume.getRingerMode() != RingerMode.NORMAL;
  }

  Future<bool> canVibrate() async {
    return (await RealVolume.getRingerMode() != RingerMode.SILENT) &&
        ((await Vibration.hasVibrator()) ?? false);
  }

  Future<void> vibrate() async {
    if (await canVibrate()) {
      await Vibration.vibrate(pattern: Constants.vibrationPattern);
    } else {
      await Vibration.vibrate();
    }
  }

  Future<void> setVolume(double volume) async {
    if (await cantPlaySound()) return;
    await RealVolume.setVolume(volume, showUI: false, streamType: StreamType.RING);
  }

  Future<void> playTone(Tones tone, [double? volume]) async {
    if (await cantPlaySound()) return;
    if (tone != Tones.none && volume != 0.0) {
      if (volume != null) setVolume(volume);
      final path = '${Assets.tonesBasePath}${tone.name}.${tone.type}';
      await _tonePlayer.setAsset(path);
      await _tonePlayer.play();
    }
  }

  Future<void> playPomodoroSound({
    required Task task,
    required PomodoroStatus pomodoroStatus,
  }) async {
    if (task.vibrate) {
      vibrate();
    }

    playTone(task.tone, task.toneVolume);

    if (task.readStatusAloud && task.statusVolume != 0.0) {
      await Future.delayed(const Duration(seconds: 1));
      await setVolume(task.toneVolume);
      await readStatusAloud(pomodoroStatus);
    }
  }

  Future<void> readStatusAloud(PomodoroStatus status) async {
    if (await cantPlaySound()) return;
    if (status.isWorkTime) {
      await _statusPlayer.setAsset(Assets.workTimeSoundPath);
    } else if (status.isShortBreakTime) {
      await _statusPlayer.setAsset(Assets.shortBreakTimeSoundPath);
    } else {
      await _statusPlayer.setAsset(Assets.longBreakSoundPath);
    }
    await _statusPlayer.play();
  }

  Future<void> dispose() async {
    await _statusPlayer.dispose();
    await _tonePlayer.dispose();
  }
}
