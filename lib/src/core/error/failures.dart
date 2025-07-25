abstract class Failure {
  final String message;
  final StackTrace? stackTrace;

  const Failure(this.message, [this.stackTrace]);
}

class ServerFailure extends Failure {
  const ServerFailure(String message, [StackTrace? stackTrace])
    : super(message, stackTrace);
}

class CacheFailure extends Failure {
  const CacheFailure(String message, [StackTrace? stackTrace])
    : super(message, stackTrace);
}

class ConnectionFailure extends Failure {
  const ConnectionFailure([StackTrace? stackTrace])
    : super("İnternet bağlantısı yok.", stackTrace);
}
