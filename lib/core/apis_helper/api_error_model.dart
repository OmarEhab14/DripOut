import 'package:dio/dio.dart';
import 'package:drip_out/core/apis_helper/api_error_handler.dart';

class ApiErrorModel {
  final String message;
  final int? statusCode;
  final String? details;

  ApiErrorModel({
    required this.message,
    this.statusCode,
    this.details,
  });

  factory ApiErrorModel.fromDioException(DioException e) {
    return ApiErrorModel(
        message: ApiErrorHandler.getErrorMessage(e),
        statusCode: e.response?.statusCode,
        details: e.message);
  }
}
