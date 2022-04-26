abstract class Failure implements Exception {
  final String? message;
  final StackTrace? stackTrace;

  Failure({
    this.message,
    this.stackTrace,
  });
}

class DomainError extends Failure {
  DomainError({
    String? message,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          stackTrace: stackTrace,
        );
}

class DatasourceError extends Failure {
  DatasourceError({
    String? message,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          stackTrace: stackTrace,
        );
}
