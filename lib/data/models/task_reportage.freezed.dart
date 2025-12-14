// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_reportage.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TaskReportage {

 String? get id; DateTime get endDate; DateTime get startDate; TaskStatus get taskStatus; String get taskId; String get taskTitle;
/// Create a copy of TaskReportage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaskReportageCopyWith<TaskReportage> get copyWith => _$TaskReportageCopyWithImpl<TaskReportage>(this as TaskReportage, _$identity);

  /// Serializes this TaskReportage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaskReportage&&(identical(other.id, id) || other.id == id)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.taskStatus, taskStatus) || other.taskStatus == taskStatus)&&(identical(other.taskId, taskId) || other.taskId == taskId)&&(identical(other.taskTitle, taskTitle) || other.taskTitle == taskTitle));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,endDate,startDate,taskStatus,taskId,taskTitle);

@override
String toString() {
  return 'TaskReportage(id: $id, endDate: $endDate, startDate: $startDate, taskStatus: $taskStatus, taskId: $taskId, taskTitle: $taskTitle)';
}


}

/// @nodoc
abstract mixin class $TaskReportageCopyWith<$Res>  {
  factory $TaskReportageCopyWith(TaskReportage value, $Res Function(TaskReportage) _then) = _$TaskReportageCopyWithImpl;
@useResult
$Res call({
 String? id, DateTime endDate, DateTime startDate, TaskStatus taskStatus, String taskId, String taskTitle
});




}
/// @nodoc
class _$TaskReportageCopyWithImpl<$Res>
    implements $TaskReportageCopyWith<$Res> {
  _$TaskReportageCopyWithImpl(this._self, this._then);

  final TaskReportage _self;
  final $Res Function(TaskReportage) _then;

/// Create a copy of TaskReportage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? endDate = null,Object? startDate = null,Object? taskStatus = null,Object? taskId = null,Object? taskTitle = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,taskStatus: null == taskStatus ? _self.taskStatus : taskStatus // ignore: cast_nullable_to_non_nullable
as TaskStatus,taskId: null == taskId ? _self.taskId : taskId // ignore: cast_nullable_to_non_nullable
as String,taskTitle: null == taskTitle ? _self.taskTitle : taskTitle // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}



/// @nodoc
@JsonSerializable()

class _TaskReportage implements TaskReportage {
  const _TaskReportage({this.id, required this.endDate, required this.startDate, required this.taskStatus, required this.taskId, required this.taskTitle});
  factory _TaskReportage.fromJson(Map<String, dynamic> json) => _$TaskReportageFromJson(json);

@override final  String? id;
@override final  DateTime endDate;
@override final  DateTime startDate;
@override final  TaskStatus taskStatus;
@override final  String taskId;
@override final  String taskTitle;

/// Create a copy of TaskReportage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaskReportageCopyWith<_TaskReportage> get copyWith => __$TaskReportageCopyWithImpl<_TaskReportage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TaskReportageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TaskReportage&&(identical(other.id, id) || other.id == id)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.taskStatus, taskStatus) || other.taskStatus == taskStatus)&&(identical(other.taskId, taskId) || other.taskId == taskId)&&(identical(other.taskTitle, taskTitle) || other.taskTitle == taskTitle));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,endDate,startDate,taskStatus,taskId,taskTitle);

@override
String toString() {
  return 'TaskReportage(id: $id, endDate: $endDate, startDate: $startDate, taskStatus: $taskStatus, taskId: $taskId, taskTitle: $taskTitle)';
}


}

/// @nodoc
abstract mixin class _$TaskReportageCopyWith<$Res> implements $TaskReportageCopyWith<$Res> {
  factory _$TaskReportageCopyWith(_TaskReportage value, $Res Function(_TaskReportage) _then) = __$TaskReportageCopyWithImpl;
@override @useResult
$Res call({
 String? id, DateTime endDate, DateTime startDate, TaskStatus taskStatus, String taskId, String taskTitle
});




}
/// @nodoc
class __$TaskReportageCopyWithImpl<$Res>
    implements _$TaskReportageCopyWith<$Res> {
  __$TaskReportageCopyWithImpl(this._self, this._then);

  final _TaskReportage _self;
  final $Res Function(_TaskReportage) _then;

/// Create a copy of TaskReportage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? endDate = null,Object? startDate = null,Object? taskStatus = null,Object? taskId = null,Object? taskTitle = null,}) {
  return _then(_TaskReportage(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,taskStatus: null == taskStatus ? _self.taskStatus : taskStatus // ignore: cast_nullable_to_non_nullable
as TaskStatus,taskId: null == taskId ? _self.taskId : taskId // ignore: cast_nullable_to_non_nullable
as String,taskTitle: null == taskTitle ? _self.taskTitle : taskTitle // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
