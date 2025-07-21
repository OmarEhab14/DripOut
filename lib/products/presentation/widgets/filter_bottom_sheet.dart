import 'package:drip_out/common/widgets/button/basic_app_button.dart';
import 'package:drip_out/core/configs/theme/app_colors.dart';
import 'package:drip_out/products/data/models/get_products_params.dart';
import 'package:drip_out/products/presentation/bloc/paginated_products_bloc/paginated_products_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterBottomSheet extends StatefulWidget {
  final double minPrice;
  final double maxPrice;
  final List<String> sizes;
  final BuildContext context;

  const FilterBottomSheet({super.key, required this.context , required this.minPrice, required this.maxPrice, required this.sizes});
  @override
  _FilterBottomSheetState createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  String _selectedSort = 'Relevance';
  late RangeValues _priceRange;
  var sortOptions = ['Relevance', 'Price:Low-High', 'Price:High-Low'];
  late List<String> sizes;
  late String dropDownValue;

  @override
  void initState() {
    super.initState();
    _priceRange = RangeValues(widget.minPrice, widget.maxPrice);
    sizes = ['All', ...widget.sizes];
    dropDownValue = sizes.first;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric( vertical: 20.h),
      // height: 430.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: bottomSheetHandle()),
          bottomSheetTitle(),
          bottomSheetDivider(),
          sortByTitle(),
          sortByListView(),
          bottomSheetDivider(),
          priceTitle(),
          priceRangeSlider(),
          bottomSheetDivider(),
          sizeSelector(),
          const Expanded(child: SizedBox()),
          applyFiltersButton(),
        ],
      ),
    );
  }

  Widget bottomSheetHandle(){
    return Container(
      width: 80.w,
      height: 5.h,
      decoration: BoxDecoration(
        color: Colors.grey[400],
        borderRadius: BorderRadius.circular(10.r),
      ),
    );
  }

  Widget bottomSheetTitle() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Filters",
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(fontSize: 25.sp),
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Widget bottomSheetDivider() {
    return Divider(
      thickness: 1.5.sp,
      indent: 20.w,
      endIndent: 20.w,
      color: AppColors.primarySwatch[300],
    );
  }

  Widget sortByTitle() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Text("Sort By",
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(fontSize: 20.sp)),
    );
  }

  Widget sortByListView() {
    return SizedBox(
      height: 60.h,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        scrollDirection: Axis.horizontal,
        itemCount: sortOptions.length,
        separatorBuilder: (context, index) => 10.horizontalSpace,
        itemBuilder: (context, index) {
          final label = sortOptions[index];
          final isSelected = _selectedSort == label;
          return ChoiceChip(
            label: Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey[700],
              ),
            ),
            selected: isSelected,
            onSelected: (_) {
              setState(() {
                _selectedSort = label;
              });
            },
            selectedColor: AppColors.primaryColor,
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
              side: BorderSide(
                color: isSelected ? AppColors.primaryColor : Colors.grey,
                width: 1,
              ),
            ),
            showCheckmark: false, // Removes the check icon
          );
        },
      ),
    );
  }

  Widget priceTitle() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Price",
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(fontSize: 20.sp)),
          Text(
            '\$${_priceRange.start.round()} - \$${_priceRange.end.round()}',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(color: AppColors.primarySwatch[500]),
          )
        ],
      ),
    );
  }

  Widget priceRangeSlider() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: RangeSlider(
        activeColor: AppColors.primaryColor,
        inactiveColor: AppColors.primarySwatch[300],
        values: _priceRange,
        min: widget.minPrice,
        max: widget.maxPrice,
        divisions: 50,
        labels: RangeLabels(
          "\$${_priceRange.start.round()}",
          "\$${_priceRange.end.round()}",
        ),
        onChanged: (RangeValues values) {
          setState(() {
            _priceRange = values;
          });
        },
      ),
    );
  }

  Widget sizeSelector() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Size',
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(fontSize: 20.sp),
          ),
          DropdownButton(
              value: dropDownValue,
              icon: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: AppColors.primarySwatch[500],
              ),
              underline: const SizedBox.shrink(),
              dropdownColor: Colors.white,
              items: sizes
                  .map((size) => DropdownMenuItem(
                value: size,
                child: Text(
                  size,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(
                      color: AppColors.primarySwatch[500]),
                ),
              ))
                  .toList(),
              onChanged: (String? newSize) {
                setState(() {
                  dropDownValue = newSize!;
                });
              }),
        ],
      ),
    );
  }

  Widget applyFiltersButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: BasicAppButton(
          text: 'Apply Filters',
          onPressed: () {
            Navigator.of(context).pop();
            double minPrice = _priceRange.start;
            double maxPrice = _priceRange.end;
            String size = dropDownValue;
            GetProductsParams params = GetProductsParams(minPrice: minPrice, maxPrice: maxPrice, size: size);
            widget.context.read<PaginatedProductsCubit>().loadPage(params: params, reset: true);
          }),
    );
  }
}
