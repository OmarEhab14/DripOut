import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

class AppTheme {
  static final appTheme = ThemeData(
    primaryColor: AppColors.primaryColor,
    // primarySwatch: AppColors.primarySwatch,
    fontFamily: 'General Sans',
    scaffoldBackgroundColor: AppColors.primarySwatch[0],
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
        // padding:
        // EdgeInsets.symmetric(vertical: 15.h, horizontal: 25.w),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: const TextStyle(
        fontSize: 17,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.r),
        borderSide: BorderSide(
          color: AppColors.primarySwatch[400]!,
        ),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      focusColor: AppColors.primaryColor,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(
          color: AppColors.primarySwatch[700]!,
          width: 2,
        ),
      ),
    ),
    textTheme: TextTheme(
      headlineLarge: TextStyle(
        fontSize: 55.sp,
        fontWeight: FontWeight.w800,
        height: 0.75.h,
      ),
      headlineMedium: TextStyle(
        fontWeight: FontWeight.w800,
        fontSize: 28.5.sp,
      ),
      headlineSmall: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
      ),
      bodyLarge: TextStyle(
        fontSize: 13.sp,
        fontWeight: FontWeight.w400,
        // height: 1.5,
      ),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppColors.primaryColor,
      selectionColor: AppColors.primarySwatch[400],
      selectionHandleColor: AppColors.primaryColor,
    ),
  );
}
