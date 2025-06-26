class AppError {
  factory AppError.fromUnknown(Object? e) {
    if (e is AppError) return e;

    return AppError(e.toString());
  }

  AppError([this.message]);

  final String? message;

  @override
  String toString() {
    try {
      return '$runtimeType: $message';
    } catch (e) {
      return 'AppError: $message';
    }
  }
}
