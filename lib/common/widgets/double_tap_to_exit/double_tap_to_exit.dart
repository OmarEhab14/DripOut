import 'package:drip_out/core/configs/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DoubleTapToExit extends StatefulWidget {
  final Widget child;
  final String? message;
  final Color? backgroundColor;

  const DoubleTapToExit({super.key, required this.child, this.message, this.backgroundColor});

  @override
  State<DoubleTapToExit> createState() => _DoubleTapToExitState();
}

class _DoubleTapToExitState extends State<DoubleTapToExit> {
  DateTime timeBackPressed = DateTime.now();
  bool canPopNow = false;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: canPopNow,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;

        final bool isExitWarning = DateTime.now().difference(timeBackPressed) >=
            const Duration(seconds: 2);
        timeBackPressed = DateTime.now();
        if (isExitWarning) {
          setState(() {
            canPopNow = false;
          });
          Fluttertoast.showToast(
              msg: widget.message ?? 'Press back again to exit',
              backgroundColor: widget.backgroundColor ?? AppColors.primaryColor);
        } else {
          setState(() {
            canPopNow = true;
          });
          SystemNavigator.pop();
        }
      },
      child: widget.child,
    );
  }
}
