import 'package:drip_out/common/widgets/button/basic_icon_button.dart';
import 'package:drip_out/core/configs/assets/app_vectors.dart';
import 'package:drip_out/core/configs/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ShimmeredProductCard extends StatelessWidget {
  const ShimmeredProductCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Get the screen size to make responsive adjustments
    final screenSize = MediaQuery.of(context).size;
    final cardWidth = (screenSize.width / 2) - 30;

    // Adjust image height based on screen size
    final imageHeight = cardWidth * 1.12;
    return SizedBox(
      height: 350.h,
      width: cardWidth,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: imageHeight,
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(40),
                borderRadius: BorderRadius.circular(15.r),
              ),
            ),
            5.verticalSpace,
            Container(
              width: cardWidth * 0.75,
              height: 12.h,
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(40),
                borderRadius: BorderRadius.circular(15.r),
              ),
            ),
            5.verticalSpace,
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 10.h,
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(40),
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                  ),
                ),
                5.horizontalSpace,
                Expanded(
                  child: Container(
                    height: 10.h,
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(40),
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                  ),
                ),
              ],
            ),
            5.verticalSpace,
            Container(
              height: 10.h,
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(60),
                borderRadius: BorderRadius.circular(15.r),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
