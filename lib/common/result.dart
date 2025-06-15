import 'dart:async';

final class Result<T, E extends Object> {
  Result.success(T value)
      : _value = value,
        _error = null,
        _isSuccess = true;

  Result.failure(E error)
      : _value = null,
        _error = error,
        _isSuccess = false;

  static Future<Result<T, E>> tryCatch<T, E extends Object>(FutureOr<T> Function() f) async {
    try {
      final value = await f();
      return Result.success(value);
    } on E catch (e) {
      return Result.failure(e);
    }
  }

  final T? _value;
  final E? _error;
  final bool _isSuccess;

  T get value => _value!;
  T? get valueOrNull => _value;
  E get error => _error!;
  E? get errorOrNull => _error;
  bool get isSuccess => _isSuccess;
  bool get isFailure => !_isSuccess;

  R when<R>({
    required R Function(T value) onSuccess,
    required R Function(E error) onFailure,
  }) {
    if (_isSuccess) {
      return onSuccess(value);
    } else {
      return onFailure(error);
    }
  }
}
