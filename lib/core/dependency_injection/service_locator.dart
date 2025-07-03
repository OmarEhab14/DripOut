import 'package:dio/dio.dart';
import 'package:drip_out/authentication/data/helpers/google_sign_in_service_impl.dart';
import 'package:drip_out/authentication/data/repository/auth.dart';
import 'package:drip_out/authentication/data/source/auth_local_datasource.dart';
import 'package:drip_out/authentication/data/source/auth_remote_datasource.dart';
import 'package:drip_out/authentication/domain/services/google_sign_in_service.dart';
import 'package:drip_out/authentication/domain/use_cases/check_auth_status_usecase.dart';
import 'package:drip_out/authentication/domain/use_cases/check_first_time_usecase.dart';
import 'package:drip_out/authentication/domain/use_cases/login_usecase.dart';
import 'package:drip_out/authentication/domain/use_cases/login_with_google_usecase.dart';
import 'package:drip_out/authentication/domain/use_cases/logout_usecase.dart';
import 'package:drip_out/authentication/domain/use_cases/refresh_token_usecase.dart';
import 'package:drip_out/authentication/domain/use_cases/signup_usecase.dart';
import 'package:drip_out/core/apis_helper/authentication_client.dart';
import 'package:drip_out/core/apis_helper/dio_interceptor.dart';
import 'package:drip_out/core/services/startup_service.dart';
import 'package:drip_out/core/storage/secure_storage_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

final GetIt sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  //dio
  sl.registerLazySingleton(() => Dio());
  //secure storage
  sl.registerLazySingleton(() => const FlutterSecureStorage());
  //secure storage service
  sl.registerLazySingleton(() => SecureStorageService(sl<FlutterSecureStorage>()));
  //authentication client
  sl.registerFactoryParam<AuthenticationClient, List<InterceptorsWrapper>, void>((interceptors, _) {
    final dio = sl<Dio>();
    // final storageService = sl<SecureStorageService>();
    return AuthenticationClient(dio: dio, dioInterceptors: interceptors);
  });
  
  // google authentication service
  sl.registerLazySingleton(() => GoogleSignInServiceImpl());
  
  // dio interceptor
  sl.registerLazySingleton(() => RefreshTokenInterceptor(sl<SecureStorageService>()));

  //data sources
  sl.registerLazySingleton(() => AuthRemoteDatasource(sl<AuthenticationClient>(param1: [sl<RefreshTokenInterceptor>()]), sl<GoogleSignInServiceImpl>()));
  sl.registerLazySingleton(() => AuthLocalDatasource(sl<SecureStorageService>()));
  sl.registerLazySingleton(() => AuthRepositoryImpl(local: sl<AuthLocalDatasource>(), remote: sl<AuthRemoteDatasource>()));
  sl.registerLazySingleton(() => CheckAuthStatusUseCase(sl<AuthRepositoryImpl>()));
  sl.registerLazySingleton(() => LoginUseCase(sl<AuthRepositoryImpl>()));
  sl.registerLazySingleton(() => SignUpUseCase(sl<AuthRepositoryImpl>()));
  sl.registerLazySingleton(() => LoginWithGoogleUseCase(sl<AuthRepositoryImpl>()));
  sl.registerLazySingleton(() => LogoutUseCase(sl<AuthRepositoryImpl>()));
  sl.registerLazySingleton(() => RefreshTokenUseCase(sl<AuthRepositoryImpl>()));
  sl.registerLazySingleton(() => CheckIfFirstTimeUseCase(sl<AuthRepositoryImpl>()));
  sl.registerLazySingleton(() => StartupService(checkAuthStatusUseCase: sl<CheckAuthStatusUseCase>(), checkIfFirstTimeUseCase: sl<CheckIfFirstTimeUseCase>()));
}