import 'package:dio/dio.dart';
import 'package:drip_out/core/apis_helper/api_constants.dart';
import 'package:drip_out/core/apis_helper/api_error_model.dart';
import 'package:drip_out/core/apis_helper/api_result.dart';
import 'package:drip_out/core/apis_helper/dio_interceptor.dart';
import 'package:drip_out/core/storage/secure_storage_service.dart';

class DioClient {
  final Dio _dio;
  final SecureStorageService _secureStorageService;
  final List<InterceptorsWrapper> _dioInterceptors;
  DioClient(this._dio, this._secureStorageService, this._dioInterceptors) {
    _dio.options.baseUrl = ApiConstants.baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 15);
    _dio.options.receiveTimeout = const Duration(seconds: 15);
    _dio.options.responseType = ResponseType.json;
    _dio.interceptors.addAll(_dioInterceptors);
  }
  Future<ApiResult<T>> get<T>(
      String path, {
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onReceiveProgress,
        required T Function(dynamic) converter,
      }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return Success(converter(response.data));
    } on DioException catch (e) {
      return Failure(ApiErrorModel.fromDioException(e));
    }
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
      }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return Success(converter(response.data));
    } on DioException catch (e) {
      return Failure(ApiErrorModel.fromDioException(e));
    }
  }
}