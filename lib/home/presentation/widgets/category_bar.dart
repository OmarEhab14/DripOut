import 'package:drip_out/core/configs/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryBar extends StatelessWidget {
  final List<String> categories;
  final int selectedIndex;
  final Function(int) onCategorySelected;

  const CategoryBar({
    super.key,
    required this.categories,
    required this.selectedIndex,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(
              left: index == 0 ? 20.w : 8,
              right: index == categories.length - 1 ? 20.w : 0,
            ),
            child: InkWell(
              onTap: () => onCategorySelected(index),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: selectedIndex == index
                      ? AppColors.primaryColor
                      : Colors.white,
                  borderRadius: BorderRadius.circular(15.r),
                  border: Border.all(
                    color: selectedIndex == index
                        ? AppColors.primaryColor
                        : AppColors.primarySwatch[300]!,
                  ),
                ),
                child: Text(
                  categories[index],
                  style: TextStyle(
                    color: selectedIndex == index ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
