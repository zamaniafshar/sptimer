import 'dart:async';
import 'package:bloc/bloc.dart';

base class StreamableCubit<State> extends Cubit<State> {
  StreamableCubit(super.initialState);

  final _completer = Completer<void>();
  final _disposables = <FutureOr<void> Function()>[];

  Future<void> get future => _completer.future;

  @override
  Future<void> close() async {
    for (final disposable in _disposables) {
      disposable.call();
    }
    _disposables.clear();
    if (!_completer.isCompleted) _completer.complete();
    super.close();
  }

  Future<void> onEach<T>(
    Stream<T> stream, {
    required void Function(T data) onData,
    void Function(Object error, StackTrace stackTrace)? onError,
  }) {
    final completer = Completer<void>();
    final subscription = stream.listen(
      onData,
      onDone: completer.complete,
      onError: onError ?? completer.completeError,
      cancelOnError: onError == null,
    );
    _disposables.add(subscription.cancel);
    return Future.any([future, completer.future]).whenComplete(() {
      subscription.cancel();
      _disposables.remove(subscription.cancel);
    });
  }

  Future<void> forEach<T>(
    Stream<T> stream, {
    required State Function(T data) onData,
    State Function(Object error, StackTrace stackTrace)? onError,
  }) {
    return onEach<T>(
      stream,
      onData: (data) => emit(onData(data)),
      onError: onError != null
          ? (Object error, StackTrace stackTrace) {
              emit(onError(error, stackTrace));
            }
          : null,
    );
  }
}
