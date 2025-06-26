// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Task _$TaskFromJson(Map<String, dynamic> json) => _Task(
      id: json['id'] as String?,
      title: json['title'] as String,
      workDuration:
          Duration(microseconds: (json['work_duration'] as num).toInt()),
      shortBreakDuration:
          Duration(microseconds: (json['short_break_duration'] as num).toInt()),
      longBreakDuration:
          Duration(microseconds: (json['long_break_duration'] as num).toInt()),
      maxPomodoroRound: (json['max_pomodoro_round'] as num).toInt(),
      vibrate: json['vibrate'] as bool,
      tone: $enumDecode(_$TonesEnumMap, json['tone']),
      toneVolume: (json['tone_volume'] as num).toDouble(),
      statusVolume: (json['status_volume'] as num).toDouble(),
      readStatusAloud: json['read_status_aloud'] as bool,
    );

Map<String, dynamic> _$TaskToJson(_Task instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'work_duration': instance.workDuration.inMicroseconds,
      'short_break_duration': instance.shortBreakDuration.inMicroseconds,
      'long_break_duration': instance.longBreakDuration.inMicroseconds,
      'max_pomodoro_round': instance.maxPomodoroRound,
      'vibrate': instance.vibrate,
      'tone': _$TonesEnumMap[instance.tone]!,
      'tone_volume': instance.toneVolume,
      'status_volume': instance.statusVolume,
      'read_status_aloud': instance.readStatusAloud,
    };

const _$TonesEnumMap = {
  Tones.none: 'none',
  Tones.alert: 'alert',
  Tones.ding: 'ding',
  Tones.doorbell: 'doorbell',
  Tones.doubleBell: 'doubleBell',
  Tones.hello: 'hello',
  Tones.greetings: 'greetings',
  Tones.happyBells: 'happyBells',
  Tones.harp: 'harp',
  Tones.loudBeeps: 'loudBeeps',
  Tones.magical: 'magical',
  Tones.marbles: 'marbles',
  Tones.messageOld: 'messageOld',
  Tones.message: 'message',
  Tones.musicalAlert: 'musicalAlert',
  Tones.positive: 'positive',
  Tones.pristine: 'pristine',
  Tones.quickChime: 'quickChime',
  Tones.relax: 'relax',
  Tones.twinkle: 'twinkle',
};
