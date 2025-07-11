import 'package:dio/dio.dart';
import 'package:drip_out/core/apis_helper/api_constants.dart';
import 'package:drip_out/core/apis_helper/api_result.dart';

abstract class DioClient {
  final Dio dio;
  final List<InterceptorsWrapper> dioInterceptors;

  DioClient({required this.dio, required this.dioInterceptors}) {
    dio.options.baseUrl = ApiConstants.baseUrl;
    dio.options.connectTimeout = const Duration(seconds: 15);
    dio.options.receiveTimeout = const Duration(seconds: 15);
    dio.options.responseType = ResponseType.json;
    dio.interceptors.addAll(dioInterceptors);
  }

  Future<Response> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) {
    throw UnsupportedError("Get not implemented for this client");
  }

  Future<ApiResult<T>> post<T>(
      String path, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
        required T Function(dynamic) converter,
      }) {
    throw UnsupportedError("Post not implemented for this client");
  }

  Future<ApiResult<T>> put<T>(
      String path, {
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onReceiveProgress,
        required T Function(dynamic) converter,
      }) {
    throw UnsupportedError("Put not implemented for this client");
  }

  Future<ApiResult<T>> delete<T>(
      String path, {
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onReceiveProgress,
        required T Function(dynamic) converter,
      }) {
    throw UnsupportedError("Delete not implemented for this client");
  }
}
