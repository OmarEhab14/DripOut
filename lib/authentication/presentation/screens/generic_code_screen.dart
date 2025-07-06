import 'dart:async';
import 'package:drip_out/authentication/data/models/verification_req_params.dart';
import 'package:drip_out/authentication/domain/use_cases/resend_verification_code_usecase.dart';
import 'package:drip_out/authentication/domain/use_cases/verify_usecase.dart';
import 'package:drip_out/authentication/presentation/widgets/pin_input.dart';
import 'package:drip_out/common/bloc/usecase_cubit.dart';
import 'package:drip_out/common/widgets/button/bloc_app_button.dart';
import 'package:drip_out/common/widgets/button/bloc_text_button.dart';
import 'package:drip_out/core/configs/theme/app_colors.dart';
import 'package:drip_out/core/dependency_injection/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GenericVerificationScreen extends StatefulWidget {
  final String email;
  final String title;
  final String subtitle;
  final VoidCallback onVerified;

  const GenericVerificationScreen({
    super.key,
    required this.email,
    required this.title,
    required this.subtitle,
    required this.onVerified,
  });

  @override
  State<GenericVerificationScreen> createState() =>
      _GenericVerificationScreenState();
}

class _GenericVerificationScreenState extends State<GenericVerificationScreen> {
  late final TextEditingController _pinController;
  late final FocusNode _pinFocusNode;
  late final GlobalKey<FormState> _formKey;

  final verificationCubit = UseCaseCubit(sl<VerifyUseCase>());
  final resendCodeCubit = UseCaseCubit(sl<ResendVerificationCodeUseCase>());

  late final StreamController<int> _timerController;
  Timer? _timer;
  static const int _initialSeconds = 10;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _pinController = TextEditingController();
    _pinFocusNode = FocusNode();
    _timerController = StreamController<int>();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _timerController.close();
    _pinController.dispose();
    _pinFocusNode.dispose();
    verificationCubit.close();
    resendCodeCubit.close();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();

    int remainingSeconds = _initialSeconds;
    _timerController.add(remainingSeconds);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      remainingSeconds--;
      if (remainingSeconds >= 0) {
        _timerController.add(remainingSeconds);
      } else {
        timer.cancel();
      }
    });
  }

  void _resendCode(UseCaseCubit resendCubit) {
    resendCubit.execute(params: widget.email);
    _startTimer();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Verification code resent'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(1, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(backgroundColor: Colors.transparent),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.title,
                  style: Theme.of(context).textTheme.headlineMedium),
              Text(
                widget.subtitle,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppColors.primarySwatch[500],
                    ),
              ),
              20.verticalSpace,
              BlocProvider.value(
                value: verificationCubit,
                child: BlocListener<UseCaseCubit, UseCaseState>(
                  listener: (context, state) {
                    if (state is UseCaseSuccess) {
                      widget.onVerified();
                    } else if (state is UseCaseFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content:
                                Text(state.errorMessage)),
                      );
                    }
                  },
                  child: PinInput(
                    focusNode: _pinFocusNode,
                    formKey: _formKey,
                    pinController: _pinController,
                    length: 6,
                    validator: (code) {
                      if (code == null || code.isEmpty) {
                        return 'Please enter the verification code';
                      }
                      if (code.length != 6) {
                        return 'Code must be 6 digits';
                      }
                      return null;
                    },
                    onComplete: (code) {
                      final params = VerificationReqParams(
                        email: widget.email,
                        code: code ?? '',
                      );
                      verificationCubit.execute(params: params);
                    },
                  ),
                ),
              ),
              20.verticalSpace,
              StreamBuilder<int>(
                stream: _timerController.stream,
                initialData: _initialSeconds,
                builder: (context, snapshot) {
                  final remainingSeconds = snapshot.data ?? 0;
                  final canResend = remainingSeconds <= 0;

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (!canResend) ...[
                        Text('You can resend code in '),
                        Text(
                          _formatTime(remainingSeconds),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ] else ...[
                        Text('Email not received? '),
                        BlocProvider.value(
                          value: resendCodeCubit,
                          child: BlocTextButton(
                            onPressed: () {
                              _resendCode(resendCodeCubit);
                            },
                            text: 'Resend code',
                            padding: EdgeInsets.symmetric(
                                horizontal: 4, vertical: 6),
                          ),
                        ),
                      ],
                    ],
                  );
                },
              ),
              const Expanded(child: SizedBox()),
              BlocProvider.value(
                value: verificationCubit,
                child: BlocAppButton(
                  text: 'Continue',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      widget.onVerified();
                    }
                  },
                ),
              ),
              15.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
