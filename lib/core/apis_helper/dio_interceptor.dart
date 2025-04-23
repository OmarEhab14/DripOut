import 'package:dio/dio.dart';
import 'package:drip_out/core/apis_helper/api_constants.dart';
import 'package:drip_out/core/storage/secure_storage_service.dart';

class DioInterceptor extends InterceptorsWrapper {
  final SecureStorageService _secureStorageService;

  DioInterceptor(this._secureStorageService);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await _secureStorageService.getAccessToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      if (await _refreshToken()) {
        return handler.resolve(await _retry(err.requestOptions));
      } else {
        await _secureStorageService.deleteTokens();
      }
    }
    return handler.next(err);
  }

  Future<bool> _refreshToken() async {
    try {
      final refreshToken = await _secureStorageService.getRefreshToken();
      if (refreshToken == null) {
        return false;
      }
      final refreshDio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));
      final response = await refreshDio.post(
        ApiConstants.refreshTokenEndpoint,
        data: {'refreshToken': refreshToken},
      );
      if (response.statusCode == 200 && response.data != null) {
        await _secureStorageService
            .setAccessToken(response.data['refreshToken']);
        await _secureStorageService
            .setRefreshToken(response.data['refreshToken']);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final accessToken = await _secureStorageService.getAccessToken();

    final retryDio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));

    final newHeaders = Map<String, dynamic>.from(requestOptions.headers);
    newHeaders['Authorization'] = 'Bearer $accessToken';

    final options = Options(
      method: requestOptions.method,
      headers: newHeaders,
      contentType: requestOptions.contentType,
      responseType: requestOptions.responseType,
      validateStatus: requestOptions.validateStatus,
      sendTimeout: requestOptions.sendTimeout,
      receiveTimeout: requestOptions.receiveTimeout,
    );

    return retryDio.request(
      requestOptions.path,
      data: requestOptions.data,
      options: options,
      queryParameters: requestOptions.queryParameters,
    );
  }

}
