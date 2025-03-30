import 'package:drip_out/authentication/presentation/widgets/my_textfield.dart';
import 'package:drip_out/authentication/presentation/widgets/pin_input.dart';
import 'package:drip_out/common/widgets/button/basic_app_button.dart';
import 'package:drip_out/core/configs/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VerificationCodeScreen extends StatefulWidget {
  const VerificationCodeScreen({super.key, required this.email});

  final String email;

  @override
  State<VerificationCodeScreen> createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  late final TextEditingController _pinController;
  late final FocusNode _pinFocusNode;
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _pinController = TextEditingController();
    _pinFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _pinController.dispose();
    _pinFocusNode.dispose();
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter 4 digit code',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              'Enter 4 digit code that you received on your email(${widget.email}).',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(color: AppColors.primarySwatch[500]),
            ),
            20.verticalSpace,
            Center(child: PinInput(focusNode: _pinFocusNode,formKey: _formKey,pinController: _pinController,)),
            20.verticalSpace,
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Email not received? '),
                Text(
                  'Resend code',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                    decorationThickness: 1.7,
                  ),
                )
              ],
            ),
            const Expanded(child: SizedBox()),
            BasicAppButton(
              text: 'Continue',
              onPressed: () {
                _formKey.currentState!.validate();
              },
            ),
            15.verticalSpace,
          ],
        ),
      ),
    );
  }
}
