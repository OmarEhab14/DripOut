import 'package:drip_out/core/configs/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SuggestedProductCard extends StatelessWidget {
  final void Function() onTap;
  final void Function() onIconTap;
  final Widget image;
  final String title;
  final double price;
  final double? discount;

  const SuggestedProductCard(
      {super.key,
      required this.onTap,
      required this.image,
      required this.title,
      required this.price,
      this.discount,
      required this.onIconTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 90.h,
        child: Row(
          children: [
            SizedBox(
              height: 70.h,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.r),
                child: image,
              ),
            ),
            10.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                          ? Text(
                              '-$discount%',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.red,
                              ),
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(onPressed: onIconTap, icon: const Icon(Icons.north_east))
          ],
        ),
      ),
    );
  }
}
