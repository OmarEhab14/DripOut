import 'dart:async';

import 'package:drip_out/common/widgets/app_bar/basic_app_bar.dart';
import 'package:drip_out/common/widgets/search_bar/app_search_bar.dart';
import 'package:drip_out/core/configs/assets/app_images.dart';
import 'package:drip_out/core/configs/theme/app_colors.dart';
import 'package:drip_out/search/presentation/widgets/suggested_product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool showSuggestions = false;
  late final TextEditingController _searchController;
  Timer? _debounce;
  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        onNotificationsPressed: () {},
        title: 'Search',
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            AppSearchBar(
              searchTextController: _searchController,
              onChanged: (value) {
                if (_debounce?.isActive ?? false) _debounce!.cancel();
                _debounce = Timer(const Duration(seconds: 2), () {
                  print("Final value: $value");
                });
                if (value.isNotEmpty) {
                  setState(() {
                    showSuggestions = true;
                  });
                } else {
                  setState(() {
                    showSuggestions = false;
                  });
                }
              },
            ),
            showSuggestions
                ? SizedBox()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Recent Searches',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(fontSize: 18.sp),
                      ),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                            overlayColor: AppColors.primarySwatch[500]),
                        child: const Text(
                          'Clear All',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: AppColors.primaryColor),
                        ),
                      ),
                    ],
                  ),
            // 10.verticalSpace,
            showSuggestions
                ?
            Expanded(
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return SuggestedProductCard(
                          onTap: () {},
                          onIconTap: () {
                            _searchController.text = 'Regular Fit Polo';
                          },
                          image: Image.asset(AppImages.tshirt),
                          title: 'Regular Fit Polo',
                          price: 1100,
                          discount: 52,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider(
                          thickness: 1.sp,
                          color: AppColors.primarySwatch[200],
                        );
                      },
                      itemCount: 5),
                )
                : Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  child: Text(
                                'Jeans',
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                                overflow: TextOverflow.ellipsis,
                              )),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.cancel_outlined,
                                    color: AppColors.primarySwatch[400]),
                                iconSize: 25.r,
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider(
                          thickness: 1.sp,
                          color: AppColors.primarySwatch[200],
                        );
                      },
                      itemCount: 5,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
