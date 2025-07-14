import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShimmeredCategoryBar extends StatelessWidget {

  const ShimmeredCategoryBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Shimmer.fromColors(
        baseColor: Colors.black.withAlpha(80),
        highlightColor: Colors.grey[300]!,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          separatorBuilder: (_, __) => SizedBox(width: 8.w),
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.all(10.r),
              width: 80.w,
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(60),
                borderRadius: BorderRadius.circular(15.r)
              ),
            );
          },
        ),
      ),
    );
  }
}
