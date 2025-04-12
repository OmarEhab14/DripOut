import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BasicIconButton extends StatelessWidget {
  final Widget icon;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? size;
  final void Function() onPressed;
  const BasicIconButton({super.key, required this.icon, this.backgroundColor, this.foregroundColor, this.size, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: icon,
      style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          fixedSize: size == null ? null : Size(size!, size!)),
    );
  }
}
