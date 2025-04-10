import 'package:drip_out/authentication/presentation/screens/forgot_password_screen.dart';
import 'package:drip_out/authentication/presentation/screens/onboarding_screen.dart';
import 'package:drip_out/authentication/presentation/screens/reset_password_screen.dart';
import 'package:drip_out/authentication/presentation/screens/signup_screen.dart';
import 'package:drip_out/authentication/presentation/screens/splash_screen.dart';
import 'package:drip_out/authentication/presentation/screens/verification_code_screen.dart';
import 'package:drip_out/common/bloc/button/button_cubit.dart';
import 'package:drip_out/core/configs/constants/screen_names.dart';
import 'package:drip_out/home/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../authentication/presentation/screens/login_screen.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case ScreenNames.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case ScreenNames.onboardingScreen:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case ScreenNames.signupScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => ButtonCubit(),
            child: const SignupScreen(),
          ),
        );
      case ScreenNames.loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case ScreenNames.forgotPasswordScreen:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
      case ScreenNames.verificationCodeScreen:
        final String email = settings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => VerificationCodeScreen(
                  email: email,
                ));
      case ScreenNames.resetPasswordScreen:
        return MaterialPageRoute(builder: (_) => const ResetPasswordScreen());
      case ScreenNames.homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
    }
  }
}
