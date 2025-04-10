import 'package:dio/dio.dart';
import 'package:drip_out/authentication/data/repository/auth.dart';
import 'package:drip_out/authentication/data/source/auth_local_datasource.dart';
import 'package:drip_out/authentication/data/source/auth_remote_datasource.dart';
import 'package:drip_out/authentication/domain/use_cases/check_auth_status_usecase.dart';
import 'package:drip_out/authentication/domain/use_cases/get_user_profile_usecase.dart';
import 'package:drip_out/authentication/domain/use_cases/login_usecase.dart';
import 'package:drip_out/authentication/domain/use_cases/logout_usecase.dart';
import 'package:drip_out/authentication/domain/use_cases/refresh_token_usecase.dart';
import 'package:drip_out/authentication/domain/use_cases/signup_usecase.dart';
import 'package:drip_out/core/apis_helper/dio_client.dart';
import 'package:drip_out/core/apis_helper/dio_interceptor.dart';
import 'package:drip_out/core/storage/secure_storage_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

final GetIt sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => const FlutterSecureStorage());
  sl.registerLazySingleton(() => SecureStorageService(sl<FlutterSecureStorage>()));
  sl.registerFactoryParam<DioClient, List<InterceptorsWrapper>, void>((interceptors, _) {
    final dio = sl<Dio>();
    final storageService = sl<SecureStorageService>();
    return DioClient(dio, storageService, interceptors);
  });
  sl.registerLazySingleton(() => DioInterceptor(sl<SecureStorageService>()));
  sl.registerLazySingleton(() => AuthRemoteDatasource(sl<DioClient>(param1: sl<DioInterceptor>())));
  sl.registerLazySingleton(() => AuthLocalDatasource(sl<SecureStorageService>()));
  sl.registerLazySingleton(() => AuthRepositoryImpl(local: sl<AuthLocalDatasource>(), remote: sl<AuthRemoteDatasource>()));
  sl.registerLazySingleton(() => CheckAuthStatusUseCase(authRepositoryImpl: sl<AuthRepositoryImpl>()));
  sl.registerLazySingleton(() => GetUserProfileUseCase(authRepositoryImpl: sl<AuthRepositoryImpl>()));
  sl.registerLazySingleton(() => LoginUseCase(authRepositoryImpl: sl<AuthRepositoryImpl>()));
  sl.registerLazySingleton(() => SignUpUseCase(authRepositoryImpl: sl<AuthRepositoryImpl>()));
  sl.registerLazySingleton(() => LogoutUseCase(authRepositoryImpl: sl<AuthRepositoryImpl>()));
  sl.registerLazySingleton(() => RefreshTokenUseCase(authRepositoryImpl: sl<AuthRepositoryImpl>()));
}