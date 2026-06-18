
abstract class Failure {
  final String message;
  const Failure(this.message);
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'No internet connection']);
}

class ServerFailure extends Failure {
  final int? statusCode;
  const ServerFailure([super.message = 'Server error occurred', this.statusCode]);
}

class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Cache error occurred']);
}

class AuthFailure extends Failure {
  const AuthFailure([super.message = 'Authentication failed']);
}

class ValidationFailure extends Failure {
  const ValidationFailure([super.message = 'Validation failed']);
}

class UnknownFailure extends Failure {
  const UnknownFailure([super.message = 'An unknown error occurred']);
}


class NetworkException implements Exception {
  final String message;
  const NetworkException([this.message = 'No internet connection']);
}

class ServerException implements Exception {
  final String message;
  final int? statusCode;
  const ServerException([this.message = 'Server error', this.statusCode]);
}

class CacheException implements Exception {
  final String message;
  const CacheException([this.message = 'Cache error']);
}

class AuthException implements Exception {
  final String message;
  const AuthException([this.message = 'Authentication failed']);
}