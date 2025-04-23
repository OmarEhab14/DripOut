import 'package:dio/dio.dart';
import 'package:drip_out/account/data/repository/user_repo_impl.dart';
import 'package:drip_out/account/data/source/account_remote_datasource.dart';
import 'package:drip_out/account/domain/usecases/get_user_usecase.dart';
import 'package:drip_out/account/presentation/bloc/user_cubit.dart';
import 'package:drip_out/authentication/domain/use_cases/logout_usecase.dart';
import 'package:drip_out/common/bloc/button/button_cubit.dart';
import 'package:drip_out/common/widgets/button/bloc_app_button.dart';
import 'package:drip_out/core/apis_helper/dio_client.dart';
import 'package:drip_out/core/apis_helper/dio_interceptor.dart';
import 'package:drip_out/core/configs/constants/screen_names.dart';
import 'package:drip_out/core/dependency_injection/service_locator.dart';
import 'package:drip_out/core/storage/secure_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            BlocProvider(
              create: (context) => ButtonCubit(sl<LogoutUseCase>()),
              child: BlocListener<ButtonCubit, ButtonState>(
                listener: (context, state) {
                  if (state is ButtonSuccess) {
                    Navigator.pushReplacementNamed(
                        context, ScreenNames.loginScreen);
                  } else if (state is ButtonFailure) {
                    var snackBar = SnackBar(content: Text(state.errorMessage));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                child: Builder(builder: (context) {
                  return BlocAppButton(
                    text: 'Logout',
                    onPressed: () {
                      context.read<ButtonCubit>().execute();
                    },
                    backgroundColor: Colors.red,
                  );
                }),
              ),
            ),
            const SizedBox(height: 16),

            BlocProvider(
              create: (context) => UserCubit(
                GetUserUseCase(
                  UserRepoImpl(
                    AccountRemoteDataSource(
                      DioClient(
                        Dio(),
                        SecureStorageService(FlutterSecureStorage()),
                        [DioInterceptor(SecureStorageService(FlutterSecureStorage()))],
                      ),
                    ),
                  ),
                ),
              ),
              child: Builder(
                builder: (context) {
                  return Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          context.read<UserCubit>().execute();
                        },
                        child: const Text("Load User Data"),
                      ),
                      const SizedBox(height: 16),
                      BlocBuilder<UserCubit, UserState>(
                        builder: (context, state) {
                          if (state is UserLoading) {
                            return const CircularProgressIndicator();
                          } else if (state is UserSuccess) {
                            return Text('message: ${state.message}');
                          } else if (state is UserFailure) {
                            return Text('failed: ${state.message}');
                          } else {
                            return const Text('Press the button to load user data');
                          }
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
