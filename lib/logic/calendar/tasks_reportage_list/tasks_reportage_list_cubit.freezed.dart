// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tasks_reportage_list_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TasksReportageListState {

 bool get isLoading; bool get isLoadingMore; List<TaskReportage> get reportages; bool get hasReachedEnd; int get currentPage; Exception? get error;
/// Create a copy of TasksReportageListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TasksReportageListStateCopyWith<TasksReportageListState> get copyWith => _$TasksReportageListStateCopyWithImpl<TasksReportageListState>(this as TasksReportageListState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TasksReportageListState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&const DeepCollectionEquality().equals(other.reportages, reportages)&&(identical(other.hasReachedEnd, hasReachedEnd) || other.hasReachedEnd == hasReachedEnd)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isLoadingMore,const DeepCollectionEquality().hash(reportages),hasReachedEnd,currentPage,error);

@override
String toString() {
  return 'TasksReportageListState(isLoading: $isLoading, isLoadingMore: $isLoadingMore, reportages: $reportages, hasReachedEnd: $hasReachedEnd, currentPage: $currentPage, error: $error)';
}


}

/// @nodoc
abstract mixin class $TasksReportageListStateCopyWith<$Res>  {
  factory $TasksReportageListStateCopyWith(TasksReportageListState value, $Res Function(TasksReportageListState) _then) = _$TasksReportageListStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool isLoadingMore, List<TaskReportage> reportages, bool hasReachedEnd, int currentPage, Exception? error
});




}
/// @nodoc
class _$TasksReportageListStateCopyWithImpl<$Res>
    implements $TasksReportageListStateCopyWith<$Res> {
  _$TasksReportageListStateCopyWithImpl(this._self, this._then);

  final TasksReportageListState _self;
  final $Res Function(TasksReportageListState) _then;

/// Create a copy of TasksReportageListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? isLoadingMore = null,Object? reportages = null,Object? hasReachedEnd = null,Object? currentPage = null,Object? error = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,reportages: null == reportages ? _self.reportages : reportages // ignore: cast_nullable_to_non_nullable
as List<TaskReportage>,hasReachedEnd: null == hasReachedEnd ? _self.hasReachedEnd : hasReachedEnd // ignore: cast_nullable_to_non_nullable
as bool,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as Exception?,
  ));
}

}



/// @nodoc


class _TasksReportageListState extends TasksReportageListState {
  const _TasksReportageListState({required this.isLoading, required this.isLoadingMore, required final  List<TaskReportage> reportages, required this.hasReachedEnd, required this.currentPage, required this.error}): _reportages = reportages,super._();
  

@override final  bool isLoading;
@override final  bool isLoadingMore;
 final  List<TaskReportage> _reportages;
@override List<TaskReportage> get reportages {
  if (_reportages is EqualUnmodifiableListView) return _reportages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_reportages);
}

@override final  bool hasReachedEnd;
@override final  int currentPage;
@override final  Exception? error;

/// Create a copy of TasksReportageListState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TasksReportageListStateCopyWith<_TasksReportageListState> get copyWith => __$TasksReportageListStateCopyWithImpl<_TasksReportageListState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TasksReportageListState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&const DeepCollectionEquality().equals(other._reportages, _reportages)&&(identical(other.hasReachedEnd, hasReachedEnd) || other.hasReachedEnd == hasReachedEnd)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isLoadingMore,const DeepCollectionEquality().hash(_reportages),hasReachedEnd,currentPage,error);

@override
String toString() {
  return 'TasksReportageListState(isLoading: $isLoading, isLoadingMore: $isLoadingMore, reportages: $reportages, hasReachedEnd: $hasReachedEnd, currentPage: $currentPage, error: $error)';
}


}

/// @nodoc
abstract mixin class _$TasksReportageListStateCopyWith<$Res> implements $TasksReportageListStateCopyWith<$Res> {
  factory _$TasksReportageListStateCopyWith(_TasksReportageListState value, $Res Function(_TasksReportageListState) _then) = __$TasksReportageListStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool isLoadingMore, List<TaskReportage> reportages, bool hasReachedEnd, int currentPage, Exception? error
});




}
/// @nodoc
class __$TasksReportageListStateCopyWithImpl<$Res>
    implements _$TasksReportageListStateCopyWith<$Res> {
  __$TasksReportageListStateCopyWithImpl(this._self, this._then);

  final _TasksReportageListState _self;
  final $Res Function(_TasksReportageListState) _then;

/// Create a copy of TasksReportageListState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? isLoadingMore = null,Object? reportages = null,Object? hasReachedEnd = null,Object? currentPage = null,Object? error = freezed,}) {
  return _then(_TasksReportageListState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,reportages: null == reportages ? _self._reportages : reportages // ignore: cast_nullable_to_non_nullable
as List<TaskReportage>,hasReachedEnd: null == hasReachedEnd ? _self.hasReachedEnd : hasReachedEnd // ignore: cast_nullable_to_non_nullable
as bool,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as Exception?,
  ));
}


}

// dart format on
