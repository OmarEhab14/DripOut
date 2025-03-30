import 'package:drip_out/core/configs/assets/app_vectors.dart';
import 'package:drip_out/core/configs/constants/screen_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/configs/theme/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
        const Duration(seconds: 2),
        () => Navigator.pushReplacementNamed(
            context, ScreenNames.onboardingScreen));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SizedBox.expand(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: SvgPicture.asset(
                AppVectors.splashWaves,
                width: 1.sw,
                // height: 600.h,
                fit: BoxFit.cover,
              ),
            ),
            Center(
              child: SvgPicture.asset(
                AppVectors.appLogo,
                width: 160.r,
              ),
            ),
            Positioned(
              bottom: 50.h,
              left: 0,
              right: 0,
              child: Center(
                child: SpinKitDualRing(
                  color: Colors.white,
                  size: 50.r,
                  lineWidth: 7.r,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
