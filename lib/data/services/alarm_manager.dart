import 'package:just_audio/just_audio.dart';

class AlarmManager {
  static Future<void> playAlarm(bool isRestTime) async {
    String address = isRestTime ? 'rest' : 'work';
    final player = AudioPlayer();
    await player.setAsset('assets/audio/its_time_to_$address.mp3');
    await player.play();
  }
}
