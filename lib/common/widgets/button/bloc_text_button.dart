import 'package:drip_out/common/bloc/usecase_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class BlocTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final EdgeInsetsGeometry? padding;

  const BlocTextButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UseCaseCubit, UseCaseState>(
      builder: (context, state) {
        if (state is UseCaseLoading) {
          return _loading();
        }
        return _initial();
      },
    );
  }

  Widget _initial() {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: padding ?? EdgeInsets.zero,
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          decoration: TextDecoration.underline,
          decorationThickness: 1.7,
        ),
      ),
    );
  }

  Widget _loading() {
    return TextButton(
      onPressed: null,
      style: TextButton.styleFrom(
        padding: padding ?? EdgeInsets.zero,
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: SizedBox(
        width: 16.r,
        height: 16.r,
        child: SpinKitPulse(
          color: Colors.black,
          size: 16.r,
        ),
      ),
    );
  }
}