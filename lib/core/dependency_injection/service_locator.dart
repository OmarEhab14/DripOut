import 'package:dio/dio.dart';
import 'package:drip_out/authentication/data/repository/auth.dart';
import 'package:drip_out/authentication/data/source/auth_local_datasource.dart';
import 'package:drip_out/authentication/data/source/auth_remote_datasource.dart';
import 'package:drip_out/authentication/domain/use_cases/check_auth_status_usecase.dart';
import 'package:drip_out/authentication/domain/use_cases/check_first_time_usecase.dart';
import 'package:drip_out/authentication/domain/use_cases/get_user_profile_usecase.dart';
import 'package:drip_out/authentication/domain/use_cases/login_usecase.dart';
import 'package:drip_out/authentication/domain/use_cases/logout_usecase.dart';
import 'package:drip_out/authentication/domain/use_cases/refresh_token_usecase.dart';
import 'package:drip_out/authentication/domain/use_cases/signup_usecase.dart';
import 'package:drip_out/core/apis_helper/dio_client.dart';
import 'package:drip_out/core/apis_helper/dio_interceptor.dart';
import 'package:drip_out/core/services/startup_service.dart';
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
  sl.registerLazySingleton(() => AuthRemoteDatasource(sl<DioClient>(param1: [sl<DioInterceptor>()])));
  sl.registerLazySingleton(() => AuthLocalDatasource(sl<SecureStorageService>()));
  sl.registerLazySingleton(() => AuthRepositoryImpl(local: sl<AuthLocalDatasource>(), remote: sl<AuthRemoteDatasource>()));
  sl.registerLazySingleton(() => CheckAuthStatusUseCase(sl<AuthRepositoryImpl>()));
  sl.registerLazySingleton(() => GetUserProfileUseCase(sl<AuthRepositoryImpl>()));
  sl.registerLazySingleton(() => LoginUseCase(sl<AuthRepositoryImpl>()));
  sl.registerLazySingleton(() => SignUpUseCase(sl<AuthRepositoryImpl>()));
  sl.registerLazySingleton(() => LogoutUseCase(sl<AuthRepositoryImpl>()));
  sl.registerLazySingleton(() => RefreshTokenUseCase(sl<AuthRepositoryImpl>()));
  sl.registerLazySingleton(() => CheckIfFirstTimeUseCase(sl<AuthRepositoryImpl>()));
  sl.registerLazySingleton(() => StartupService(checkAuthStatusUseCase: sl<CheckAuthStatusUseCase>(), checkIfFirstTimeUseCase: sl<CheckIfFirstTimeUseCase>()));
}