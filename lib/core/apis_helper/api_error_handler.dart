import 'package:dio/dio.dart';

class ApiErrorHandler {
  static String getErrorMessage(DioException e) {
    if (e.response != null) {
      switch (e.response?.statusCode) {
        case 400:
          return 'Bad request. Please check your input.';
        case 401:
          return 'Invalid credentials or session expired. Please log in again.';
        case 403:
          return 'Forbidden. You don’t have permission.';
        case 404:
          return 'Resource not found.';
        case 500:
          return 'Server error. Please try again later.';
        default:
          return 'Something went wrong: ${e.message}';
      }
    } else {
      return 'No internet connection, or server unreachable';
    }
  }
}