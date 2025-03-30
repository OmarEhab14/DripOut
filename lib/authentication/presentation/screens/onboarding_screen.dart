import 'package:drip_out/common/widgets/button/basic_app_button.dart';
import 'package:drip_out/core/configs/assets/app_images.dart';
import 'package:drip_out/core/configs/assets/app_vectors.dart';
import 'package:drip_out/core/configs/constants/screen_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: 8).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: SvgPicture.asset(
              AppVectors.onboardingWaves,
              width: 1.sw,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20.w, 50.h, 0, 0),
            width: double.infinity,
            child: Text(
              'Define yourself in your unique way.',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Image.asset(
              AppImages.onboardingImage,
              height: 0.925.sh,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.white,
              width: double.infinity,
              height: 110.h,
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Center(
                child: BasicAppButton(
                  text: 'Get Started',
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, ScreenNames.signupScreen);
                  },
                  postfixIcon: RepaintBoundary(
                    child: AnimatedBuilder(
                      animation: _animation,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(_animation.value, 0),
                          child:
                              Icon(Icons.arrow_forward_rounded, size: 25.r),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
