import 'package:drip_out/common/widgets/button/basic_app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppDialogBox extends StatelessWidget {
  final Widget icon;
  final String title;
  final String description;
  final BasicAppButton button;
  const AppDialogBox({super.key, required this.icon, required this.title, required this.description, required this.button});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.sp),
      ),
      backgroundColor: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(22.sp),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon,
            16.verticalSpace,
            Text(
              title,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            8.verticalSpace,
            Text(
              description,
              style: const TextStyle(
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            20.verticalSpace,
            button,
          ],
        ),
      ),
    );
  }
}
