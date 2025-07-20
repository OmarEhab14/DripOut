import 'package:drip_out/common/widgets/button/basic_icon_button.dart';
import 'package:drip_out/core/configs/assets/app_vectors.dart';
import 'package:drip_out/core/configs/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';

class ShimmeredProductCard extends StatelessWidget {

  const ShimmeredProductCard(
      {super.key,});

  @override
  Widget build(BuildContext context) {
    // Get the screen size to make responsive adjustments
    final screenSize = MediaQuery.of(context).size;
    final cardWidth = (screenSize.width / 2) - 20; // 30

    // Adjust image height based on screen size
    final imageHeight = cardWidth * 1.40; // 1.12
    return Shimmer.fromColors(
      baseColor: Colors.black.withAlpha(80),
      highlightColor: Colors.grey[300]!,
      child: Container(
        decoration: BoxDecoration(
          // color: Colors.white,
          borderRadius:
          // BorderRadius.vertical(top: Radius.circular(10.r)),
          BorderRadius.circular(10.r),
        ),
        // height: 400.h,
        // width: cardWidth,
        child: Column(
          // image + info
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              // image
              height: imageHeight,
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(60),
                borderRadius: BorderRadius.vertical(top: Radius.circular(10.r)),
              ),
            ),
            // 5.verticalSpace,
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Column(
                  // info
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 12.h,
                      width: cardWidth * 0.75,
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(60),
                        borderRadius: BorderRadius.circular(10.h)
                      ),
                    ),
                    5.verticalSpace,
                    Container(
                      height: 12.h,
                      width: cardWidth,
                      decoration: BoxDecoration(
                          color: Colors.black.withAlpha(60),
                          borderRadius: BorderRadius.circular(10.h)
                      ),
                    ),
                    3.verticalSpace,
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 12.h,
                            decoration: BoxDecoration(
                                color: Colors.black.withAlpha(60),
                                borderRadius: BorderRadius.circular(10.h)
                            ),
                          ),
                        ),
                        5.horizontalSpace,
                        Expanded(
                          child: Container(
                            height: 12.h,
                            decoration: BoxDecoration(
                                color: Colors.black.withAlpha(60),
                                borderRadius: BorderRadius.circular(10.h)
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
