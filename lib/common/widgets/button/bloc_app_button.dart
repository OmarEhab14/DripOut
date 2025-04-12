import 'package:drip_out/common/bloc/button/button_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../core/configs/theme/app_colors.dart';

class BlocAppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Widget? prefixIcon;
  final Widget? postfixIcon;
  final double? width;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool hasBorder;
  final double prefixGap;
  final double postfixGap;

  const BlocAppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.prefixIcon,
    this.postfixIcon,
    this.width,
    this.backgroundColor,
    this.foregroundColor,
    this.hasBorder = false,
    this.prefixGap = 15.0,
    this.postfixGap = 10.0,
  });

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<ButtonCubit, ButtonState>(
      builder: (context, state) {
        if (state is ButtonLoading) {
          return _loading();
        }
        return _initial();
      },
    );
  }

  Widget _initial() {
    return SizedBox(
      width: width ?? double.infinity,
      height: 60.r,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            side: hasBorder
                ? BorderSide(
              color: AppColors.primarySwatch[300]!,
              width: 1.sp,
            )
                : null),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (prefixIcon != null) ...[
              prefixIcon!,
              prefixGap.horizontalSpace,
            ],
            Text(text),
            if (postfixIcon != null) ...[
              postfixGap.horizontalSpace,
              postfixIcon!,
            ],
          ],
        ),
      ),
    );
  }

  Widget _loading() {
    return SizedBox(
      width: width ?? double.infinity,
      height: 60.r,
      child: ElevatedButton(
          onPressed: null,
          style: ElevatedButton.styleFrom(
              backgroundColor: backgroundColor,
              foregroundColor: foregroundColor,
              disabledBackgroundColor: backgroundColor,
              disabledForegroundColor: foregroundColor,
              side: hasBorder
                  ? BorderSide(
                color: AppColors.primarySwatch[300]!,
                width: 1.sp,
              )
                  : null),
          child: Center(
            child: SpinKitPulse(
              color: backgroundColor == Colors.white60
                  ? AppColors.primaryColor
                  : Colors.white,
            ),
          )),
    );
  }
}
