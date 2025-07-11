import 'package:dio/dio.dart';
import 'package:drip_out/core/apis_helper/api_constants.dart';
import 'package:drip_out/core/configs/constants/screen_names.dart';
import 'package:drip_out/core/storage/secure_storage_service.dart';
import 'package:drip_out/main.dart';

class RefreshTokenInterceptor extends InterceptorsWrapper {
  final SecureStorageService _secureStorageService;

  RefreshTokenInterceptor(this._secureStorageService);

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
    if (err.requestOptions.headers['__internalRetryFlag__'] == true) {
      return handler.next(err);
    }
    if (err.response?.statusCode == 401) {
      final tokenRefreshed = await _refreshToken();
      if (tokenRefreshed) {
        err.requestOptions.headers['__internalRetryFlag__'] = true;
        return handler.resolve(await _retry(err.requestOptions));
      } else {
        await _secureStorageService.deleteTokens();
        navigatorKey.currentState?.pushNamedAndRemoveUntil(ScreenNames.loginScreen, (route) => false);
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
            .setRefreshToken(response.data['refreshToken']);
        await _secureStorageService
            .setAccessToken(response.data['token']);

        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<Response> _retry(RequestOptions requestOptions) async {
    final accessToken = await _secureStorageService.getAccessToken();

    final retryDio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));

    requestOptions.headers['Authorization'] = 'Bearer $accessToken';

    return retryDio.fetch(requestOptions); // I was using request instead of fetch but this is a light weight approach to make the same request again, but if something wrong happened, just clone the request options and use the request method instead as a safer approach

    // like this:
    // final opts = Options(
    //   method: requestOptions.method,
    //   headers: requestOptions.headers,
    //   responseType: requestOptions.responseType,
    //   contentType: requestOptions.contentType,
    //   extra: requestOptions.extra,
    //   followRedirects: requestOptions.followRedirects,
    //   listFormat: requestOptions.listFormat,
    //   receiveDataWhenStatusError: requestOptions.receiveDataWhenStatusError,
    //   sendTimeout: requestOptions.sendTimeout,
    //   receiveTimeout: requestOptions.receiveTimeout,
    //   validateStatus: requestOptions.validateStatus,
    // );
    //
    // return retryDio.request(
    //   requestOptions.path,
    //   data: requestOptions.data,
    //   queryParameters: requestOptions.queryParameters,
    //   options: opts,
    // );
  }
}
