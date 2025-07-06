import 'package:drip_out/authentication/data/models/signup_req_params.dart';
import 'package:drip_out/authentication/domain/use_cases/login_with_google_usecase.dart';
import 'package:drip_out/authentication/domain/use_cases/signup_usecase.dart';
import 'package:drip_out/authentication/presentation/widgets/link_text_span.dart';
import 'package:drip_out/authentication/presentation/widgets/my_text_button.dart';
import 'package:drip_out/authentication/presentation/widgets/my_textfield.dart';
import 'package:drip_out/authentication/presentation/widgets/my_separator.dart';
import 'package:drip_out/common/bloc/usecase_cubit.dart';
import 'package:drip_out/common/helpers/navigation_target.dart';
import 'package:drip_out/common/helpers/validation.dart';
import 'package:drip_out/common/widgets/button/basic_app_button.dart';
import 'package:drip_out/common/widgets/button/bloc_app_button.dart';
import 'package:drip_out/common/widgets/dialog/app_dialog_box.dart';
import 'package:drip_out/common/widgets/double_tap_to_exit/double_tap_to_exit.dart';
import 'package:drip_out/core/configs/assets/app_images.dart';
import 'package:drip_out/core/configs/assets/app_vectors.dart';
import 'package:drip_out/core/configs/constants/screen_names.dart';
import 'package:drip_out/core/configs/theme/app_colors.dart';
import 'package:drip_out/core/dependency_injection/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  // validation objects
  late final Validation _emailValidation = EmailValidation();
  late final Validation _passwordValidation = PasswordValidation();
  late final Validation _nameValidation = FullNameValidation();

  // focus nodes
  late final FocusNode _firstNameFocusNode;
  late final FocusNode _lastNameFocusNode;
  late final FocusNode _emailFocusNode;
  late final FocusNode _passwordFocusNode;

  // text editing controllers
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _firstNameFocusNode = FocusNode();
    _lastNameFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();

    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DoubleTapToExit(
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    45.verticalSpace,
                    Text(
                      'Create an account',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Text(
                      'Let\'s create your account.',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(color: AppColors.primarySwatch[500]),
                    ),
                    25.verticalSpace,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'First Name',
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                              5.verticalSpace,
                              firstNameTextField(),
                            ],
                          ),
                        ),
                        10.horizontalSpace,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Last Name',
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                              5.verticalSpace,
                              lastNameTextField(),
                            ],
                          ),
                        ),
                      ],
                    ),
                    15.verticalSpace,
                    Text(
                      'Email',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    5.verticalSpace,
                    emailTextField(),
                    15.verticalSpace,
                    Text(
                      'Password',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    5.verticalSpace,
                    passwordTextField(),
                    15.verticalSpace,
                    termsAndPolicy(),
                    15.verticalSpace,
                    BlocProvider(
                      create: (context) => UseCaseCubit(sl<SignUpUseCase>()),
                      child: BlocListener<UseCaseCubit, UseCaseState>(
                        listener: (context, state) {
                          if (state is UseCaseSuccess) {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return AppDialogBox(
                                  icon: SvgPicture.asset(
                                    AppVectors.successVector,
                                    width: 80.r,
                                  ),
                                  title: 'Verification required!',
                                  description:
                                  'A verification code has been sent to your email. Please check your inbox.',
                                  button: BasicAppButton(
                                    text: 'Continue',
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.pushNamed(context,
                                          ScreenNames.verificationCodeScreen,
                                          arguments: _emailController.text.trim());
                                    },
                                  ),
                                );
                              },
                            );
                          } else if (state is UseCaseFailure) {
                            var snackBar =
                            SnackBar(content: Text(state.errorMessage));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        },
                        child: createAccountButton(context),
                      ),
                    ),
                    10.verticalSpace,
                    const MySeparator(),
                    10.verticalSpace,
                    BlocProvider(
                      create: (context) =>
                          UseCaseCubit(sl<LoginWithGoogleUseCase>()),
                      child: BlocListener<UseCaseCubit, UseCaseState>(
                        listener: (context, state) {
                          if (state is UseCaseSuccess) {
                            Navigator.pushReplacementNamed(
                                context, ScreenNames.mainScreen);
                          } else if (state is UseCaseFailure) {
                            var snackBar =
                                SnackBar(content: Text(state.errorMessage));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        },
                        child: signUpWithGoogleButton(context),
                      ),
                    ),
                    15.verticalSpace,
                    signUpWithFacebookButton(context),
                    alreadyHaveAnAccount(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  RichText termsAndPolicy() {
    return RichText(
      text: TextSpan(
        style: Theme.of(context)
            .textTheme
            .bodyLarge
            ?.copyWith(color: Colors.black),
        children: [
          const TextSpan(
            text: 'By signing up you agree to our ',
          ),
          LinkTextSpan.build(
            text: 'Terms',
            target: NavigationTarget.url('https://google.com'),
            context: context,
          ),
          const TextSpan(text: ', '),
          LinkTextSpan.build(
            text: 'Privacy Policy',
            target: NavigationTarget.url('https://google.com'),
            context: context,
          ),
          const TextSpan(text: ', and '),
          LinkTextSpan.build(
            text: 'Cookie Use',
            target: NavigationTarget.url('https://google.com'),
            context: context,
          ),
        ],
      ),
    );
  }

  Widget firstNameTextField() {
    return MyTextField(
      controller: _firstNameController,
      focusNode: _firstNameFocusNode,
      hintText: 'First name',
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) => _nameValidation.validate(value),
    );
  }

  Widget lastNameTextField() {
    return MyTextField(
      controller: _lastNameController,
      focusNode: _lastNameFocusNode,
      hintText: 'Last name',
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) => _nameValidation.validate(value),
    );
  }

  Widget emailTextField() {
    return MyTextField(
      controller: _emailController,
      focusNode: _emailFocusNode,
      hintText: 'Enter your email address',
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) => _emailValidation.validate(value),
    );
  }

  Widget passwordTextField() {
    return MyTextField(
      controller: _passwordController,
      focusNode: _passwordFocusNode,
      hintText: 'Enter your password',
      isPasswordField: true,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) => _passwordValidation.validate(value),
    );
  }

  Widget createAccountButton(BuildContext context) {
    return Builder(builder: (context) {
      return BlocAppButton(
        text: 'Create an Account',
        backgroundColor: AppColors.primaryColor,
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            String firstName = _firstNameController.text.trim();
            String lastName = _lastNameController.text.trim();
            String email = _emailController.text.trim();
            String password = _passwordController.text.trim();
            // List<String> nameParts = fullName.trim().split(' ');
            //
            // String firstName = nameParts.isNotEmpty ? nameParts[0] : '';
            // String lastName =
            //     nameParts.length > 1 ? nameParts[nameParts.length - 1] : '';

            SignupReqParams params = SignupReqParams(
              firstName: firstName,
              lastName: lastName,
              email: email,
              password: password,
            );
            context.read<UseCaseCubit>().execute(params: params);
          }
        },
      );
    });
  }

  Widget signUpWithGoogleButton(BuildContext context) {
    return Builder(builder: (context) {
      return BlocAppButton(
        text: 'Sign Up with Google',
        onPressed: () {
          context.read<UseCaseCubit>().execute();
        },
        backgroundColor: Colors.white60,
        foregroundColor: AppColors.primaryColor,
        // prefixIcon: const FaIcon(FontAwesomeIcons.google),
        prefixIcon: Image.asset(AppImages.googleLogo, width: 42.r),
        hasBorder: true,
        prefixGap: 8.0,
      );
    });
  }

  Widget signUpWithFacebookButton(BuildContext context) {
    return Builder(builder: (context) {
      return BasicAppButton(
        text: 'Sign Up with Facebook',
        onPressed: () {},
        backgroundColor: const Color(0xFF1877F2),
        foregroundColor: Colors.white,
        prefixIcon: const FaIcon(FontAwesomeIcons.facebook),
      );
    });
  }

  Widget alreadyHaveAnAccount() {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.0.h),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Already have an account? '),
            MyTextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, ScreenNames.loginScreen);
              },
              text: 'Login',
            ),
          ],
        ),
      ),
    );
  }
}
