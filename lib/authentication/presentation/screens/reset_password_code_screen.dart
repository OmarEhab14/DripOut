import 'package:drip_out/authentication/domain/use_cases/verify_usecase.dart';
import 'package:drip_out/authentication/presentation/screens/generic_code_screen.dart';
import 'package:drip_out/common/bloc/usecase_cubit.dart';
import 'package:drip_out/core/configs/constants/screen_names.dart';
import 'package:drip_out/core/dependency_injection/service_locator.dart';
import 'package:flutter/material.dart';

class ResetPasswordCodeScreen extends StatelessWidget {
  final String email;

  const ResetPasswordCodeScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    /// ToDo: should use the ResetCodeVerifyUseCase but it's not created yet...
    final verificationCubit = UseCaseCubit(sl<VerifyUseCase>());
    return GenericVerificationScreen(
      email: email,
      title: 'Reset your password',
      subtitle: 'Enter the code sent to your email ($email) to reset your password',
      onVerified: () {
        Navigator.pushReplacementNamed(
          context,
          ScreenNames.resetPasswordScreen,
        );
      },
    );
  }
}
