import 'package:drip_out/authentication/presentation/widgets/my_textfield.dart';
import 'package:drip_out/common/helpers/validation.dart';
import 'package:drip_out/common/widgets/button/basic_app_button.dart';
import 'package:drip_out/common/widgets/dialog/app_dialog_box.dart';
import 'package:drip_out/core/configs/assets/app_vectors.dart';
import 'package:drip_out/core/configs/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final Validation _passwordValidation = PasswordValidation();
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
                'Reset Password',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(
                'Set the new password for your account so you can login and access all the features.',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(color: AppColors.primarySwatch[500]),
              ),
              25.verticalSpace,
              Text(
                'Password',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              5.verticalSpace,
              MyTextField(
                isPasswordField: true,
                controller: _passwordController,
                hintText: 'Enter new password',
                keyboardType: TextInputType.text,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => _passwordValidation.validate(value),
              ),
              15.verticalSpace,
              Text(
                'Confirm Password',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              5.verticalSpace,
              MyTextField(
                isPasswordField: true,
                controller: _confirmPasswordController,
                hintText: 'Confirm password',
                keyboardType: TextInputType.text,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  final validation = _passwordValidation.validate(value);
                  if (validation != null) {
                    return validation;
                  } else if (value != _passwordController.text) {
                    return 'Not matched!';
                  }
                  return null;
                },
              ),
              const Expanded(child: SizedBox()),
              BasicAppButton(
                text: 'Continue',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _showSuccessDialog(context);
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

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AppDialogBox(
          icon: SvgPicture.asset(
            AppVectors.successVector,
            width: 80.r,
          ),
          title: 'Password Changed!',
          description:
              'You can now use your new password to login to your account.',
          button: BasicAppButton(
            text: 'Login',
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }
}
