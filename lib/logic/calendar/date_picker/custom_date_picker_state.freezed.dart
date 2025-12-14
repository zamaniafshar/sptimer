// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'custom_date_picker_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CustomDatePickerState {

 List<String> get daysOfWeekNames; List<String> get monthsNames; Date get today; Date get selectedDate; int get maxNumberOfWeek; int get month; int get year; int get currentWeek; List<Date> get daysOfMonth; bool get isLoading;
/// Create a copy of CustomDatePickerState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CustomDatePickerStateCopyWith<CustomDatePickerState> get copyWith => _$CustomDatePickerStateCopyWithImpl<CustomDatePickerState>(this as CustomDatePickerState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CustomDatePickerState&&const DeepCollectionEquality().equals(other.daysOfWeekNames, daysOfWeekNames)&&const DeepCollectionEquality().equals(other.monthsNames, monthsNames)&&(identical(other.today, today) || other.today == today)&&(identical(other.selectedDate, selectedDate) || other.selectedDate == selectedDate)&&(identical(other.maxNumberOfWeek, maxNumberOfWeek) || other.maxNumberOfWeek == maxNumberOfWeek)&&(identical(other.month, month) || other.month == month)&&(identical(other.year, year) || other.year == year)&&(identical(other.currentWeek, currentWeek) || other.currentWeek == currentWeek)&&const DeepCollectionEquality().equals(other.daysOfMonth, daysOfMonth)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(daysOfWeekNames),const DeepCollectionEquality().hash(monthsNames),today,selectedDate,maxNumberOfWeek,month,year,currentWeek,const DeepCollectionEquality().hash(daysOfMonth),isLoading);

@override
String toString() {
  return 'CustomDatePickerState(daysOfWeekNames: $daysOfWeekNames, monthsNames: $monthsNames, today: $today, selectedDate: $selectedDate, maxNumberOfWeek: $maxNumberOfWeek, month: $month, year: $year, currentWeek: $currentWeek, daysOfMonth: $daysOfMonth, isLoading: $isLoading)';
}


}

/// @nodoc
abstract mixin class $CustomDatePickerStateCopyWith<$Res>  {
  factory $CustomDatePickerStateCopyWith(CustomDatePickerState value, $Res Function(CustomDatePickerState) _then) = _$CustomDatePickerStateCopyWithImpl;
@useResult
$Res call({
 List<String> daysOfWeekNames, List<String> monthsNames, Date today, Date selectedDate, int maxNumberOfWeek, int month, int year, int currentWeek, List<Date> daysOfMonth, bool isLoading
});




}
/// @nodoc
class _$CustomDatePickerStateCopyWithImpl<$Res>
    implements $CustomDatePickerStateCopyWith<$Res> {
  _$CustomDatePickerStateCopyWithImpl(this._self, this._then);

  final CustomDatePickerState _self;
  final $Res Function(CustomDatePickerState) _then;

/// Create a copy of CustomDatePickerState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? daysOfWeekNames = null,Object? monthsNames = null,Object? today = null,Object? selectedDate = null,Object? maxNumberOfWeek = null,Object? month = null,Object? year = null,Object? currentWeek = null,Object? daysOfMonth = null,Object? isLoading = null,}) {
  return _then(_self.copyWith(
daysOfWeekNames: null == daysOfWeekNames ? _self.daysOfWeekNames : daysOfWeekNames // ignore: cast_nullable_to_non_nullable
as List<String>,monthsNames: null == monthsNames ? _self.monthsNames : monthsNames // ignore: cast_nullable_to_non_nullable
as List<String>,today: null == today ? _self.today : today // ignore: cast_nullable_to_non_nullable
as Date,selectedDate: null == selectedDate ? _self.selectedDate : selectedDate // ignore: cast_nullable_to_non_nullable
as Date,maxNumberOfWeek: null == maxNumberOfWeek ? _self.maxNumberOfWeek : maxNumberOfWeek // ignore: cast_nullable_to_non_nullable
as int,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,currentWeek: null == currentWeek ? _self.currentWeek : currentWeek // ignore: cast_nullable_to_non_nullable
as int,daysOfMonth: null == daysOfMonth ? _self.daysOfMonth : daysOfMonth // ignore: cast_nullable_to_non_nullable
as List<Date>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}



/// @nodoc


class _CustomDatePickerState extends CustomDatePickerState {
  const _CustomDatePickerState({required final  List<String> daysOfWeekNames, required final  List<String> monthsNames, required this.today, required this.selectedDate, required this.maxNumberOfWeek, required this.month, required this.year, required this.currentWeek, required final  List<Date> daysOfMonth, required this.isLoading}): _daysOfWeekNames = daysOfWeekNames,_monthsNames = monthsNames,_daysOfMonth = daysOfMonth,super._();
  

 final  List<String> _daysOfWeekNames;
@override List<String> get daysOfWeekNames {
  if (_daysOfWeekNames is EqualUnmodifiableListView) return _daysOfWeekNames;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_daysOfWeekNames);
}

 final  List<String> _monthsNames;
@override List<String> get monthsNames {
  if (_monthsNames is EqualUnmodifiableListView) return _monthsNames;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_monthsNames);
}

@override final  Date today;
@override final  Date selectedDate;
@override final  int maxNumberOfWeek;
@override final  int month;
@override final  int year;
@override final  int currentWeek;
 final  List<Date> _daysOfMonth;
@override List<Date> get daysOfMonth {
  if (_daysOfMonth is EqualUnmodifiableListView) return _daysOfMonth;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_daysOfMonth);
}

@override final  bool isLoading;

/// Create a copy of CustomDatePickerState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CustomDatePickerStateCopyWith<_CustomDatePickerState> get copyWith => __$CustomDatePickerStateCopyWithImpl<_CustomDatePickerState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CustomDatePickerState&&const DeepCollectionEquality().equals(other._daysOfWeekNames, _daysOfWeekNames)&&const DeepCollectionEquality().equals(other._monthsNames, _monthsNames)&&(identical(other.today, today) || other.today == today)&&(identical(other.selectedDate, selectedDate) || other.selectedDate == selectedDate)&&(identical(other.maxNumberOfWeek, maxNumberOfWeek) || other.maxNumberOfWeek == maxNumberOfWeek)&&(identical(other.month, month) || other.month == month)&&(identical(other.year, year) || other.year == year)&&(identical(other.currentWeek, currentWeek) || other.currentWeek == currentWeek)&&const DeepCollectionEquality().equals(other._daysOfMonth, _daysOfMonth)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_daysOfWeekNames),const DeepCollectionEquality().hash(_monthsNames),today,selectedDate,maxNumberOfWeek,month,year,currentWeek,const DeepCollectionEquality().hash(_daysOfMonth),isLoading);

@override
String toString() {
  return 'CustomDatePickerState(daysOfWeekNames: $daysOfWeekNames, monthsNames: $monthsNames, today: $today, selectedDate: $selectedDate, maxNumberOfWeek: $maxNumberOfWeek, month: $month, year: $year, currentWeek: $currentWeek, daysOfMonth: $daysOfMonth, isLoading: $isLoading)';
}


}

/// @nodoc
abstract mixin class _$CustomDatePickerStateCopyWith<$Res> implements $CustomDatePickerStateCopyWith<$Res> {
  factory _$CustomDatePickerStateCopyWith(_CustomDatePickerState value, $Res Function(_CustomDatePickerState) _then) = __$CustomDatePickerStateCopyWithImpl;
@override @useResult
$Res call({
 List<String> daysOfWeekNames, List<String> monthsNames, Date today, Date selectedDate, int maxNumberOfWeek, int month, int year, int currentWeek, List<Date> daysOfMonth, bool isLoading
});




}
/// @nodoc
class __$CustomDatePickerStateCopyWithImpl<$Res>
    implements _$CustomDatePickerStateCopyWith<$Res> {
  __$CustomDatePickerStateCopyWithImpl(this._self, this._then);

  final _CustomDatePickerState _self;
  final $Res Function(_CustomDatePickerState) _then;

/// Create a copy of CustomDatePickerState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? daysOfWeekNames = null,Object? monthsNames = null,Object? today = null,Object? selectedDate = null,Object? maxNumberOfWeek = null,Object? month = null,Object? year = null,Object? currentWeek = null,Object? daysOfMonth = null,Object? isLoading = null,}) {
  return _then(_CustomDatePickerState(
daysOfWeekNames: null == daysOfWeekNames ? _self._daysOfWeekNames : daysOfWeekNames // ignore: cast_nullable_to_non_nullable
as List<String>,monthsNames: null == monthsNames ? _self._monthsNames : monthsNames // ignore: cast_nullable_to_non_nullable
as List<String>,today: null == today ? _self.today : today // ignore: cast_nullable_to_non_nullable
as Date,selectedDate: null == selectedDate ? _self.selectedDate : selectedDate // ignore: cast_nullable_to_non_nullable
as Date,maxNumberOfWeek: null == maxNumberOfWeek ? _self.maxNumberOfWeek : maxNumberOfWeek // ignore: cast_nullable_to_non_nullable
as int,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,currentWeek: null == currentWeek ? _self.currentWeek : currentWeek // ignore: cast_nullable_to_non_nullable
as int,daysOfMonth: null == daysOfMonth ? _self._daysOfMonth : daysOfMonth // ignore: cast_nullable_to_non_nullable
as List<Date>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
