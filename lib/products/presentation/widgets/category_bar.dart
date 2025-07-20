import 'package:drip_out/core/configs/theme/app_colors.dart';
import 'package:drip_out/products/data/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryBar extends StatelessWidget {
  final List<CategoryModel> categories;
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
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length + 1, // +1 for the "All" item
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        separatorBuilder: (_, __) => SizedBox(width: 8.w),
        itemBuilder: (context, index) {
          if (index == 0) {
            return _buildChoiceChip(
              label: 'All',
              isSelected: selectedIndex == 0,
              onSelected: () => onCategorySelected(0),
            );
          }

          final category = categories[index - 1];
          return _buildChoiceChip(
            label: category.name,
            isSelected: selectedIndex == index,
            onSelected: () => onCategorySelected(index),
          );
        },
      ),
    );
  }

  Widget _buildChoiceChip({
    required String label,
    required bool isSelected,
    required VoidCallback onSelected,
  }) {
    return ChoiceChip(
      padding: EdgeInsets.all(10.r),
      label: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
      selected: isSelected,
      onSelected: (_) => onSelected(),
      selectedColor: AppColors.primaryColor,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.r),
        side: BorderSide(
          color: isSelected
              ? AppColors.primaryColor
              : AppColors.primarySwatch[300]!,
        ),
      ),
      showCheckmark: false,
    );
  }
}
