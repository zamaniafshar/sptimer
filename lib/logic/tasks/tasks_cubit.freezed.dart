// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tasks_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TasksState implements DiagnosticableTreeMixin {

 bool get isLoading; ListModel get tasks; ListModel get remainingTasks; ListModel get completedTasks;
/// Create a copy of TasksState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TasksStateCopyWith<TasksState> get copyWith => _$TasksStateCopyWithImpl<TasksState>(this as TasksState, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'TasksState'))
    ..add(DiagnosticsProperty('isLoading', isLoading))..add(DiagnosticsProperty('tasks', tasks))..add(DiagnosticsProperty('remainingTasks', remainingTasks))..add(DiagnosticsProperty('completedTasks', completedTasks));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TasksState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.tasks, tasks) || other.tasks == tasks)&&(identical(other.remainingTasks, remainingTasks) || other.remainingTasks == remainingTasks)&&(identical(other.completedTasks, completedTasks) || other.completedTasks == completedTasks));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,tasks,remainingTasks,completedTasks);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'TasksState(isLoading: $isLoading, tasks: $tasks, remainingTasks: $remainingTasks, completedTasks: $completedTasks)';
}


}

/// @nodoc
abstract mixin class $TasksStateCopyWith<$Res>  {
  factory $TasksStateCopyWith(TasksState value, $Res Function(TasksState) _then) = _$TasksStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, ListModel tasks, ListModel remainingTasks, ListModel completedTasks
});


$ListModelCopyWith<$Res> get tasks;$ListModelCopyWith<$Res> get remainingTasks;$ListModelCopyWith<$Res> get completedTasks;

}
/// @nodoc
class _$TasksStateCopyWithImpl<$Res>
    implements $TasksStateCopyWith<$Res> {
  _$TasksStateCopyWithImpl(this._self, this._then);

  final TasksState _self;
  final $Res Function(TasksState) _then;

/// Create a copy of TasksState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? tasks = null,Object? remainingTasks = null,Object? completedTasks = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,tasks: null == tasks ? _self.tasks : tasks // ignore: cast_nullable_to_non_nullable
as ListModel,remainingTasks: null == remainingTasks ? _self.remainingTasks : remainingTasks // ignore: cast_nullable_to_non_nullable
as ListModel,completedTasks: null == completedTasks ? _self.completedTasks : completedTasks // ignore: cast_nullable_to_non_nullable
as ListModel,
  ));
}
/// Create a copy of TasksState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ListModelCopyWith<$Res> get tasks {
  
  return $ListModelCopyWith<$Res>(_self.tasks, (value) {
    return _then(_self.copyWith(tasks: value));
  });
}/// Create a copy of TasksState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ListModelCopyWith<$Res> get remainingTasks {
  
  return $ListModelCopyWith<$Res>(_self.remainingTasks, (value) {
    return _then(_self.copyWith(remainingTasks: value));
  });
}/// Create a copy of TasksState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ListModelCopyWith<$Res> get completedTasks {
  
  return $ListModelCopyWith<$Res>(_self.completedTasks, (value) {
    return _then(_self.copyWith(completedTasks: value));
  });
}
}



/// @nodoc


class _TasksState extends TasksState with DiagnosticableTreeMixin {
  const _TasksState({required this.isLoading, required this.tasks, required this.remainingTasks, required this.completedTasks}): super._();
  

@override final  bool isLoading;
@override final  ListModel tasks;
@override final  ListModel remainingTasks;
@override final  ListModel completedTasks;

/// Create a copy of TasksState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TasksStateCopyWith<_TasksState> get copyWith => __$TasksStateCopyWithImpl<_TasksState>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'TasksState'))
    ..add(DiagnosticsProperty('isLoading', isLoading))..add(DiagnosticsProperty('tasks', tasks))..add(DiagnosticsProperty('remainingTasks', remainingTasks))..add(DiagnosticsProperty('completedTasks', completedTasks));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TasksState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.tasks, tasks) || other.tasks == tasks)&&(identical(other.remainingTasks, remainingTasks) || other.remainingTasks == remainingTasks)&&(identical(other.completedTasks, completedTasks) || other.completedTasks == completedTasks));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,tasks,remainingTasks,completedTasks);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'TasksState(isLoading: $isLoading, tasks: $tasks, remainingTasks: $remainingTasks, completedTasks: $completedTasks)';
}


}

/// @nodoc
abstract mixin class _$TasksStateCopyWith<$Res> implements $TasksStateCopyWith<$Res> {
  factory _$TasksStateCopyWith(_TasksState value, $Res Function(_TasksState) _then) = __$TasksStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, ListModel tasks, ListModel remainingTasks, ListModel completedTasks
});


@override $ListModelCopyWith<$Res> get tasks;@override $ListModelCopyWith<$Res> get remainingTasks;@override $ListModelCopyWith<$Res> get completedTasks;

}
/// @nodoc
class __$TasksStateCopyWithImpl<$Res>
    implements _$TasksStateCopyWith<$Res> {
  __$TasksStateCopyWithImpl(this._self, this._then);

  final _TasksState _self;
  final $Res Function(_TasksState) _then;

/// Create a copy of TasksState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? tasks = null,Object? remainingTasks = null,Object? completedTasks = null,}) {
  return _then(_TasksState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,tasks: null == tasks ? _self.tasks : tasks // ignore: cast_nullable_to_non_nullable
as ListModel,remainingTasks: null == remainingTasks ? _self.remainingTasks : remainingTasks // ignore: cast_nullable_to_non_nullable
as ListModel,completedTasks: null == completedTasks ? _self.completedTasks : completedTasks // ignore: cast_nullable_to_non_nullable
as ListModel,
  ));
}

/// Create a copy of TasksState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ListModelCopyWith<$Res> get tasks {
  
  return $ListModelCopyWith<$Res>(_self.tasks, (value) {
    return _then(_self.copyWith(tasks: value));
  });
}/// Create a copy of TasksState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ListModelCopyWith<$Res> get remainingTasks {
  
  return $ListModelCopyWith<$Res>(_self.remainingTasks, (value) {
    return _then(_self.copyWith(remainingTasks: value));
  });
}/// Create a copy of TasksState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ListModelCopyWith<$Res> get completedTasks {
  
  return $ListModelCopyWith<$Res>(_self.completedTasks, (value) {
    return _then(_self.copyWith(completedTasks: value));
  });
}
}

/// @nodoc
mixin _$ListModel implements DiagnosticableTreeMixin {

 GlobalKey<AnimatedListState> get listKey; RemovedItemBuilder<Task> get removedItemBuilder; List<Task> get items;
/// Create a copy of ListModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ListModelCopyWith<ListModel> get copyWith => _$ListModelCopyWithImpl<ListModel>(this as ListModel, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ListModel'))
    ..add(DiagnosticsProperty('listKey', listKey))..add(DiagnosticsProperty('removedItemBuilder', removedItemBuilder))..add(DiagnosticsProperty('items', items));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ListModel&&(identical(other.listKey, listKey) || other.listKey == listKey)&&(identical(other.removedItemBuilder, removedItemBuilder) || other.removedItemBuilder == removedItemBuilder)&&const DeepCollectionEquality().equals(other.items, items));
}


@override
int get hashCode => Object.hash(runtimeType,listKey,removedItemBuilder,const DeepCollectionEquality().hash(items));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ListModel(listKey: $listKey, removedItemBuilder: $removedItemBuilder, items: $items)';
}


}

/// @nodoc
abstract mixin class $ListModelCopyWith<$Res>  {
  factory $ListModelCopyWith(ListModel value, $Res Function(ListModel) _then) = _$ListModelCopyWithImpl;
@useResult
$Res call({
 GlobalKey<AnimatedListState> listKey, RemovedItemBuilder<Task> removedItemBuilder, List<Task> items
});




}
/// @nodoc
class _$ListModelCopyWithImpl<$Res>
    implements $ListModelCopyWith<$Res> {
  _$ListModelCopyWithImpl(this._self, this._then);

  final ListModel _self;
  final $Res Function(ListModel) _then;

/// Create a copy of ListModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? listKey = null,Object? removedItemBuilder = null,Object? items = null,}) {
  return _then(_self.copyWith(
listKey: null == listKey ? _self.listKey : listKey // ignore: cast_nullable_to_non_nullable
as GlobalKey<AnimatedListState>,removedItemBuilder: null == removedItemBuilder ? _self.removedItemBuilder : removedItemBuilder // ignore: cast_nullable_to_non_nullable
as RemovedItemBuilder<Task>,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<Task>,
  ));
}

}



/// @nodoc


class _ListModel extends ListModel with DiagnosticableTreeMixin {
  const _ListModel({required this.listKey, required this.removedItemBuilder, required final  List<Task> items}): _items = items,super._();
  

@override final  GlobalKey<AnimatedListState> listKey;
@override final  RemovedItemBuilder<Task> removedItemBuilder;
 final  List<Task> _items;
@override List<Task> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of ListModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ListModelCopyWith<_ListModel> get copyWith => __$ListModelCopyWithImpl<_ListModel>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ListModel'))
    ..add(DiagnosticsProperty('listKey', listKey))..add(DiagnosticsProperty('removedItemBuilder', removedItemBuilder))..add(DiagnosticsProperty('items', items));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ListModel&&(identical(other.listKey, listKey) || other.listKey == listKey)&&(identical(other.removedItemBuilder, removedItemBuilder) || other.removedItemBuilder == removedItemBuilder)&&const DeepCollectionEquality().equals(other._items, _items));
}


@override
int get hashCode => Object.hash(runtimeType,listKey,removedItemBuilder,const DeepCollectionEquality().hash(_items));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ListModel(listKey: $listKey, removedItemBuilder: $removedItemBuilder, items: $items)';
}


}

/// @nodoc
abstract mixin class _$ListModelCopyWith<$Res> implements $ListModelCopyWith<$Res> {
  factory _$ListModelCopyWith(_ListModel value, $Res Function(_ListModel) _then) = __$ListModelCopyWithImpl;
@override @useResult
$Res call({
 GlobalKey<AnimatedListState> listKey, RemovedItemBuilder<Task> removedItemBuilder, List<Task> items
});




}
/// @nodoc
class __$ListModelCopyWithImpl<$Res>
    implements _$ListModelCopyWith<$Res> {
  __$ListModelCopyWithImpl(this._self, this._then);

  final _ListModel _self;
  final $Res Function(_ListModel) _then;

/// Create a copy of ListModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? listKey = null,Object? removedItemBuilder = null,Object? items = null,}) {
  return _then(_ListModel(
listKey: null == listKey ? _self.listKey : listKey // ignore: cast_nullable_to_non_nullable
as GlobalKey<AnimatedListState>,removedItemBuilder: null == removedItemBuilder ? _self.removedItemBuilder : removedItemBuilder // ignore: cast_nullable_to_non_nullable
as RemovedItemBuilder<Task>,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<Task>,
  ));
}


}

// dart format on
