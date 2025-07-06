import 'package:drip_out/authentication/presentation/widgets/my_textfield.dart';
import 'package:drip_out/common/helpers/validation.dart';
import 'package:drip_out/common/widgets/button/basic_app_button.dart';
import 'package:drip_out/core/configs/constants/screen_names.dart';
import 'package:drip_out/core/configs/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  final Validation _emailValidation = EmailValidation();

  late final TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Forgot password',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(
                'Enter your email for the verification process.',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(color: AppColors.primarySwatch[500]),
              ),
              Text(
                'We will send 4 digits code to your email.',
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
              const Expanded(child: SizedBox()),
              BasicAppButton(
                text: 'Send Code',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    String email = _emailController.text.trim();
                    Navigator.pushNamed(context, ScreenNames.resetPasswordCodeScreen, arguments:  email);
                  }
                },
              ),
              15.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
