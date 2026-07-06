/// Result pattern used across repositories (see docs/02_ARCHITECTURE.md §2.3).
///
/// Repositories never throw — they return `Result<T, Failure>`.
sealed class Result<T, E> {
  const Result();

  const factory Result.ok(T value) = Ok<T, E>;
  const factory Result.error(E error) = Error<T, E>;

  bool get isOk => this is Ok<T, E>;
  bool get isError => this is Error<T, E>;

  T? get valueOrNull => switch (this) {
        Ok(:final value) => value,
        Error() => null,
      };

  E? get errorOrNull => switch (this) {
        Ok() => null,
        Error(:final error) => error,
      };

  R when<R>({
    required R Function(T value) ok,
    required R Function(E error) error,
  }) =>
      switch (this) {
        Ok(:final value) => ok(value),
        Error(error: final e) => error(e),
      };

  Result<R, E> map<R>(R Function(T value) transform) => switch (this) {
        Ok(:final value) => Result.ok(transform(value)),
        Error(:final error) => Result.error(error),
      };
}

final class Ok<T, E> extends Result<T, E> {
  const Ok(this.value);
  final T value;
}

final class Error<T, E> extends Result<T, E> {
  const Error(this.error);
  final E error;
}

/// Base class for all domain failures.
sealed class Failure {
  const Failure(this.message);
  final String message;

  @override
  String toString() => '$runtimeType: $message';
}

class DatabaseFailure extends Failure {
  const DatabaseFailure(super.message);
}

class AIFailure extends Failure {
  const AIFailure(super.message);
}

class FileFailure extends Failure {
  const FileFailure(super.message);
}
