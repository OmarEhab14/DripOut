import 'package:drip_out/authentication/presentation/widgets/link_text_span.dart';
import 'package:drip_out/authentication/presentation/widgets/my_separator.dart';
import 'package:drip_out/authentication/presentation/widgets/my_textfield.dart';
import 'package:drip_out/common/helpers/navigation_target.dart';
import 'package:drip_out/common/helpers/validation.dart';
import 'package:drip_out/common/widgets/button/basic_app_button.dart';
import 'package:drip_out/core/configs/assets/app_images.dart';
import 'package:drip_out/core/configs/constants/screen_names.dart';
import 'package:drip_out/core/configs/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final Validation _emailValidation = EmailValidation();

  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    60.verticalSpace,
                    Text(
                      'Login to your account',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Text(
                      'It\'s great to see you again.',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(color: AppColors.primarySwatch[500]),
                    ),
                    25.verticalSpace,
                    Text(
                      'Email',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    5.verticalSpace,
                    MyTextField(
                      controller: _emailController,
                      // focusNode: _emailFocusNode,
                      hintText: 'Enter your email address',
                      keyboardType: TextInputType.emailAddress,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) => _emailValidation.validate(value),
                    ),
                    15.verticalSpace,
                    Text(
                      'Password',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    5.verticalSpace,
                    MyTextField(
                      controller: _passwordController,
                      // focusNode: _passwordFocusNode,
                      hintText: 'Enter your password',
                      isPasswordField: true,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      // validator: (value) => _passwordValidation.validate(value),
                    ),
                    15.verticalSpace,
                    RichText(
                      text: TextSpan(
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: Colors.black),
                        children: [
                          const TextSpan(
                            text: 'Forgot your password? ',
                          ),
                          LinkTextSpan.build(
                            text: 'Reset your password',
                            target: NavigationTarget.screen(
                                ScreenNames.forgotPasswordScreen),
                            context: context,
                          )
                        ],
                      ),
                    ),
                    25.verticalSpace,
                    BasicAppButton(
                      text: 'Login',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          String email = _emailController.text.trim();
                          String password = _passwordController.text.trim();
                          Navigator.pushNamedAndRemoveUntil(context, ScreenNames.mainScreen, (route) => false,);
                        }
                      },
                    ),
                    25.verticalSpace,
                    const MySeparator(),
                    25.verticalSpace,
                    BasicAppButton(
                      text: 'Login with Google',
                      onPressed: () {},
                      backgroundColor: Colors.white60,
                      foregroundColor: AppColors.primaryColor,
                      // prefixIcon: const FaIcon(FontAwesomeIcons.google),
                      prefixIcon:
                          Image.asset(AppImages.googleLogo, width: 42.r),
                      hasBorder: true,
                      prefixGap: 8.0,
                    ),
                    15.verticalSpace,
                    BasicAppButton(
                      text: 'Login with Facebook',
                      onPressed: () {},
                      backgroundColor: const Color(0xFF1877F2),
                      foregroundColor: Colors.white,
                      prefixIcon: const FaIcon(FontAwesomeIcons.facebook),
                    ),
                  ],
                ),
              ),
            ),
            80.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0.h),
              child: RichText(
                text: TextSpan(
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: Colors.black),
                  children: [
                    const TextSpan(
                      text: 'Don\'t have an account? ',
                    ),
                    LinkTextSpan.build(
                      text: 'Join',
                      target: NavigationTarget.screen(ScreenNames.signupScreen),
                      context: context,
                      isPushReplacement: true,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
