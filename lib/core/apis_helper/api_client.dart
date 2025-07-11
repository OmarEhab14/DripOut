import 'package:dio/dio.dart';
import 'package:drip_out/core/apis_helper/api_error_model.dart';
import 'package:drip_out/core/apis_helper/dio_client.dart';

class ApiClient extends DioClient {
  /// ToDo: Implement the rest of the methods and not the get only to use them in the rest of the app
  ApiClient({required super.dio, required super.dioInterceptors});
  @override
  Future<Response> get<T>(
      String path, {
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onReceiveProgress,
      }) async {
    try {
      final response = await dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException catch (e) {
      throw ApiErrorModel.fromDioException(e);
    }
  }
}