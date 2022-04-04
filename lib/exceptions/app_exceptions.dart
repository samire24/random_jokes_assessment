import 'package:intl/intl.dart';

class AppException implements Exception {
  final String? message;
  final String? prefix;

  AppException(this.message, this.prefix);

  String toString() {
    return '$prefix${toBeginningOfSentenceCase(message)}';
  }
}

class FetchDataException extends AppException {
  FetchDataException(message) : super(message, 'Error During Communication: ');
}

class BadRequestException extends AppException {
  BadRequestException(message) : super(message, 'Bad Request: ');
}

class UnauthorisedException extends AppException {
  UnauthorisedException(message) : super(message, 'Unauthorised: ');
}

class ApiException extends AppException {
  ApiException(message) : super(message, '');
}

