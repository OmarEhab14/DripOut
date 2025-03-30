import 'package:drip_out/core/configs/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MySeparator extends StatelessWidget {
  const MySeparator({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            thickness: 0.8.sp,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Text(
            "Or",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: AppColors.primarySwatch[500],
            ),
          ),
        ),
        Expanded(
          child: Divider(
            thickness: 0.8.sp,
          ),
        ),
      ],
    );
  }
}
