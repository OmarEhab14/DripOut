import 'package:drip_out/common/widgets/button/basic_icon_button.dart';
import 'package:drip_out/core/configs/assets/app_vectors.dart';
import 'package:drip_out/core/configs/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductCard extends StatelessWidget {
  final void Function() onTap;
  final Widget image;
  final String title;
  final double price;
  final double? discount;
  final String description;
  final double rate;
  final int reviews;
  final void Function() onLovePressed;

  const ProductCard(
      {super.key,
      required this.onTap,
      required this.image,
      required this.title,
      required this.description,
      required this.price,
      this.discount,
      required this.rate,
      required this.reviews,
      required this.onLovePressed});

  @override
  Widget build(BuildContext context) {
    // Get the screen size to make responsive adjustments
    final screenSize = MediaQuery.of(context).size;
    final cardWidth = (screenSize.width / 2) - 20; // 30

    // Adjust image height based on screen size
    final imageHeight = cardWidth * 1.40; // 1.12
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              // BorderRadius.vertical(top: Radius.circular(10.r)),
              BorderRadius.circular(10.r),
        ),
        // height: 400.h,
        // width: cardWidth,
        child: Stack(
          children: [
            Column(
              // image + info
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  // image
                  height: imageHeight,
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(10.r)),
                    child: image,
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
                        Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 16.3.sp, fontWeight: FontWeight.w700),
                        ),
                        Text(
                          description,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.w400),
                        ),
                        3.verticalSpace,
                        Row(
                          children: [
                            if (discount == null)
                              Text(
                                '\$$price',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primarySwatch[700]),
                              )
                            else ...[
                              Text(
                                '\$${price - (price * (discount! / 100))}',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primarySwatch[700]),
                              ),
                              3.horizontalSpace,
                              Text(
                                '$price',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.primarySwatch[500],
                                    decoration: TextDecoration.lineThrough),
                              ),
                              5.horizontalSpace,
                              Text(
                                '-${discount!.toInt()}%',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                // 10.verticalSpace,
              ],
            ),
            Positioned(
              right: 5.w,
              top: 5.h,
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(20),
                      spreadRadius: 0,
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: BasicIconButton(
                  icon: SvgPicture.asset(AppVectors.loveIcon),
                  onPressed: onLovePressed,
                  backgroundColor: Colors.white,
                  size: 5.r,
                ),
              ),
            ),
            if (rate != 0)
              Positioned(
                left: 0,
                top: imageHeight - 25.h - 5.h,
                child: Container(
                  width: cardWidth * 0.32,
                  height: 25.h,
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          AppVectors.star,
                          width: 15.r,
                        ),
                        1.horizontalSpace,
                        Text(
                          '${rate.toStringAsFixed(1)}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.w600),
                        ),
                        1.horizontalSpace,
                        Text(
                          '($reviews)',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 13.sp, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
