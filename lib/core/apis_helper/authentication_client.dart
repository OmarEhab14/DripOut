import 'package:dio/dio.dart';
import 'package:drip_out/core/apis_helper/api_error_model.dart';
import 'package:drip_out/core/apis_helper/api_result.dart';
import 'package:drip_out/core/apis_helper/dio_client.dart';

class AuthenticationClient extends DioClient {

  AuthenticationClient({required super.dio, required super.dioInterceptors});
  @override
  Future<ApiResult<T>> get<T>(
      String path, {
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onReceiveProgress,
        required T Function(dynamic) converter,
      }) async {
    try {
      final response = await dio.get(
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
  // @override
  // Future<ApiResult<T>> post<T>(
  //     String path, {
  //       dynamic data,
  //       Map<String, dynamic>? queryParameters,
  //       Options? options,
  //       CancelToken? cancelToken,
  //       ProgressCallback? onSendProgress,
  //       ProgressCallback? onReceiveProgress,
  //       required T Function(dynamic) converter,
  //     }) async {
  //   try {
  //     final response = await dio.post(
  //       path,
  //       data: data,
  //       queryParameters: queryParameters,
  //       options: options,
  //       cancelToken: cancelToken,
  //       onSendProgress: onSendProgress,
  //       onReceiveProgress: onReceiveProgress,
  //     );
  //     return Success(converter(response.data));
  //   } on DioException catch (e) {
  //     return Failure(ApiErrorModel.fromDioException(e));
  //   }
  // }
}