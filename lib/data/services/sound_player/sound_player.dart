import 'package:just_audio/just_audio.dart';

class PomodoroSoundPlayer {
  static Future<void> playRestTime() async {
    await _play('rest');
  }

  static Future<void> playWorkTime() async {
    await _play('work');
  }

  static Future<void> _play(String name) async {
    final player = AudioPlayer();
    await player.setAsset('assets/audio/its_time_to_$name.mp3');
    await player.play();
  }
}
