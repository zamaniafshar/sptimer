// ignore_for_file: sort_constructors_first

import 'package:sptimer/common/error/errors.dart';

final class DatabaseError extends AppError {
  DatabaseError(super.message);

  factory DatabaseError.fromError(Object? e) {
    return e is DatabaseError ? e : DatabaseError(e.toString());
  }
}
