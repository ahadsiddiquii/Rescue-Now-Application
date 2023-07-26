// Dart imports:
import 'dart:async';
import 'dart:io';

class CustomExceptionHandler {
  CustomExceptionHandler._();
  static const String _error500 =
      'There is some problem in the connection. Please check back later';

  static const String _socketExceptionError =
      'Please check your internet connection';
  static const String _typeExceptionError =
      'Something went wrong. Please try again.';

  static String handleException(Object exception) {
    if (exception is SocketException ||
        exception is TimeoutException ||
        exception is FormatException) {
      return _socketExceptionError;
    } else {
      if (exception is TypeError) {
        return _typeExceptionError;
      }
      return exception.toString();
    }
  }

  static String getError500() {
    return _error500;
  }
}
