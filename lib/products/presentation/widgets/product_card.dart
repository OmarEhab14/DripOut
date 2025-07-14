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
  final void Function() onLovePressed;

  const ProductCard(
      {super.key,
      required this.onTap,
      required this.image,
      required this.title,
      required this.price,
      this.discount,
      required this.onLovePressed});

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
        child: InkWell(
          onTap: onTap,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: imageHeight,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.r),
                      child: image,
                    ),
                  ),
                  5.verticalSpace,
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:
                        TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
                  ),
                  5.verticalSpace,
                  Row(
                    children: [
                      Text(
                        '\$$price',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppColors.primarySwatch[500]),
                      ),
                      5.horizontalSpace,
                      discount != null
                          ? Text('-$discount%',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.red,
                              ))
                          : const SizedBox.shrink(),
                    ],
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
                          color: AppColors.primarySwatch[500]!,
                          spreadRadius: 0.3,
                          blurRadius: 30,
                          offset: const Offset(0, 15))
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
            ],
          ),
        ),
      ),
    );
  }
}
