import 'package:drip_out/authentication/data/models/signup_req_params.dart';
import 'package:drip_out/authentication/domain/use_cases/signup_usecase.dart';
import 'package:drip_out/authentication/domain/use_cases/verify_usecase.dart';
import 'package:drip_out/authentication/presentation/screens/generic_code_screen.dart';
import 'package:drip_out/common/bloc/usecase_cubit.dart';
import 'package:drip_out/core/configs/constants/screen_names.dart';
import 'package:drip_out/core/dependency_injection/service_locator.dart';
import 'package:flutter/material.dart';

class VerificationCodeScreen extends StatelessWidget {
  final String email;

  const VerificationCodeScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return GenericVerificationScreen(
      email: email,
      title: 'Enter 6 digit code',
      subtitle: 'Enter the code sent to your email ($email)',
      onVerified: () {
        Navigator.pushNamedAndRemoveUntil(
          context,
          ScreenNames.mainScreen,
              (_) => false,
        );
      },
    );
  }
}
