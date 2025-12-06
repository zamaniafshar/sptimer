// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Task {

 String? get id; String get title; Duration get workDuration; Duration get shortBreakDuration; Duration get longBreakDuration; int get maxPomodoroRound; bool get vibrate; Tones get tone; double get toneVolume; double get statusVolume; bool get readStatusAloud;
/// Create a copy of Task
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskCopyWith<Task> get copyWith => _$TaskCopyWithImpl<Task>(this as Task, _$identity);

  /// Serializes this Task to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Task&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.workDuration, workDuration) || other.workDuration == workDuration)&&(identical(other.shortBreakDuration, shortBreakDuration) || other.shortBreakDuration == shortBreakDuration)&&(identical(other.longBreakDuration, longBreakDuration) || other.longBreakDuration == longBreakDuration)&&(identical(other.maxPomodoroRound, maxPomodoroRound) || other.maxPomodoroRound == maxPomodoroRound)&&(identical(other.vibrate, vibrate) || other.vibrate == vibrate)&&(identical(other.tone, tone) || other.tone == tone)&&(identical(other.toneVolume, toneVolume) || other.toneVolume == toneVolume)&&(identical(other.statusVolume, statusVolume) || other.statusVolume == statusVolume)&&(identical(other.readStatusAloud, readStatusAloud) || other.readStatusAloud == readStatusAloud));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,workDuration,shortBreakDuration,longBreakDuration,maxPomodoroRound,vibrate,tone,toneVolume,statusVolume,readStatusAloud);

@override
String toString() {
  return 'Task(id: $id, title: $title, workDuration: $workDuration, shortBreakDuration: $shortBreakDuration, longBreakDuration: $longBreakDuration, maxPomodoroRound: $maxPomodoroRound, vibrate: $vibrate, tone: $tone, toneVolume: $toneVolume, statusVolume: $statusVolume, readStatusAloud: $readStatusAloud)';
}


}

/// @nodoc
abstract mixin class $TaskCopyWith<$Res>  {
  factory $TaskCopyWith(Task value, $Res Function(Task) _then) = _$TaskCopyWithImpl;
@useResult
$Res call({
 String? id, String title, Duration workDuration, Duration shortBreakDuration, Duration longBreakDuration, int maxPomodoroRound, bool vibrate, Tones tone, double toneVolume, double statusVolume, bool readStatusAloud
});




}
/// @nodoc
class _$TaskCopyWithImpl<$Res>
    implements $TaskCopyWith<$Res> {
  _$TaskCopyWithImpl(this._self, this._then);

  final Task _self;
  final $Res Function(Task) _then;

/// Create a copy of Task
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? title = null,Object? workDuration = null,Object? shortBreakDuration = null,Object? longBreakDuration = null,Object? maxPomodoroRound = null,Object? vibrate = null,Object? tone = null,Object? toneVolume = null,Object? statusVolume = null,Object? readStatusAloud = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,workDuration: null == workDuration ? _self.workDuration : workDuration // ignore: cast_nullable_to_non_nullable
as Duration,shortBreakDuration: null == shortBreakDuration ? _self.shortBreakDuration : shortBreakDuration // ignore: cast_nullable_to_non_nullable
as Duration,longBreakDuration: null == longBreakDuration ? _self.longBreakDuration : longBreakDuration // ignore: cast_nullable_to_non_nullable
as Duration,maxPomodoroRound: null == maxPomodoroRound ? _self.maxPomodoroRound : maxPomodoroRound // ignore: cast_nullable_to_non_nullable
as int,vibrate: null == vibrate ? _self.vibrate : vibrate // ignore: cast_nullable_to_non_nullable
as bool,tone: null == tone ? _self.tone : tone // ignore: cast_nullable_to_non_nullable
as Tones,toneVolume: null == toneVolume ? _self.toneVolume : toneVolume // ignore: cast_nullable_to_non_nullable
as double,statusVolume: null == statusVolume ? _self.statusVolume : statusVolume // ignore: cast_nullable_to_non_nullable
as double,readStatusAloud: null == readStatusAloud ? _self.readStatusAloud : readStatusAloud // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}



/// @nodoc
@JsonSerializable()

class _Task implements Task {
  const _Task({this.id, required this.title, required this.workDuration, required this.shortBreakDuration, required this.longBreakDuration, required this.maxPomodoroRound, required this.vibrate, required this.tone, required this.toneVolume, required this.statusVolume, required this.readStatusAloud});
  factory _Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

@override final  String? id;
@override final  String title;
@override final  Duration workDuration;
@override final  Duration shortBreakDuration;
@override final  Duration longBreakDuration;
@override final  int maxPomodoroRound;
@override final  bool vibrate;
@override final  Tones tone;
@override final  double toneVolume;
@override final  double statusVolume;
@override final  bool readStatusAloud;

/// Create a copy of Task
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaskCopyWith<_Task> get copyWith => __$TaskCopyWithImpl<_Task>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TaskToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Task&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.workDuration, workDuration) || other.workDuration == workDuration)&&(identical(other.shortBreakDuration, shortBreakDuration) || other.shortBreakDuration == shortBreakDuration)&&(identical(other.longBreakDuration, longBreakDuration) || other.longBreakDuration == longBreakDuration)&&(identical(other.maxPomodoroRound, maxPomodoroRound) || other.maxPomodoroRound == maxPomodoroRound)&&(identical(other.vibrate, vibrate) || other.vibrate == vibrate)&&(identical(other.tone, tone) || other.tone == tone)&&(identical(other.toneVolume, toneVolume) || other.toneVolume == toneVolume)&&(identical(other.statusVolume, statusVolume) || other.statusVolume == statusVolume)&&(identical(other.readStatusAloud, readStatusAloud) || other.readStatusAloud == readStatusAloud));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,workDuration,shortBreakDuration,longBreakDuration,maxPomodoroRound,vibrate,tone,toneVolume,statusVolume,readStatusAloud);

@override
String toString() {
  return 'Task(id: $id, title: $title, workDuration: $workDuration, shortBreakDuration: $shortBreakDuration, longBreakDuration: $longBreakDuration, maxPomodoroRound: $maxPomodoroRound, vibrate: $vibrate, tone: $tone, toneVolume: $toneVolume, statusVolume: $statusVolume, readStatusAloud: $readStatusAloud)';
}


}

/// @nodoc
abstract mixin class _$TaskCopyWith<$Res> implements $TaskCopyWith<$Res> {
  factory _$TaskCopyWith(_Task value, $Res Function(_Task) _then) = __$TaskCopyWithImpl;
@override @useResult
$Res call({
 String? id, String title, Duration workDuration, Duration shortBreakDuration, Duration longBreakDuration, int maxPomodoroRound, bool vibrate, Tones tone, double toneVolume, double statusVolume, bool readStatusAloud
});




}
/// @nodoc
class __$TaskCopyWithImpl<$Res>
    implements _$TaskCopyWith<$Res> {
  __$TaskCopyWithImpl(this._self, this._then);

  final _Task _self;
  final $Res Function(_Task) _then;

/// Create a copy of Task
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? title = null,Object? workDuration = null,Object? shortBreakDuration = null,Object? longBreakDuration = null,Object? maxPomodoroRound = null,Object? vibrate = null,Object? tone = null,Object? toneVolume = null,Object? statusVolume = null,Object? readStatusAloud = null,}) {
  return _then(_Task(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,workDuration: null == workDuration ? _self.workDuration : workDuration // ignore: cast_nullable_to_non_nullable
as Duration,shortBreakDuration: null == shortBreakDuration ? _self.shortBreakDuration : shortBreakDuration // ignore: cast_nullable_to_non_nullable
as Duration,longBreakDuration: null == longBreakDuration ? _self.longBreakDuration : longBreakDuration // ignore: cast_nullable_to_non_nullable
as Duration,maxPomodoroRound: null == maxPomodoroRound ? _self.maxPomodoroRound : maxPomodoroRound // ignore: cast_nullable_to_non_nullable
as int,vibrate: null == vibrate ? _self.vibrate : vibrate // ignore: cast_nullable_to_non_nullable
as bool,tone: null == tone ? _self.tone : tone // ignore: cast_nullable_to_non_nullable
as Tones,toneVolume: null == toneVolume ? _self.toneVolume : toneVolume // ignore: cast_nullable_to_non_nullable
as double,statusVolume: null == statusVolume ? _self.statusVolume : statusVolume // ignore: cast_nullable_to_non_nullable
as double,readStatusAloud: null == readStatusAloud ? _self.readStatusAloud : readStatusAloud // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
