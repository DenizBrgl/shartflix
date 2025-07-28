abstract class AppException implements Exception {
  final String message;
  AppException(this.message);
}

class ServerException extends AppException {
  ServerException(String message) : super(message);
}

class UnauthorizedException extends AppException {
  UnauthorizedException(String message) : super(message);
}

class NetworkException extends AppException {
  NetworkException() : super("İnternet bağlantısı yok.");
}

class UnknownException extends AppException {
  UnknownException(String message) : super(message);
}
