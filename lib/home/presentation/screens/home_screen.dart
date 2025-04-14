import 'package:drip_out/authentication/presentation/widgets/my_textfield.dart';
import 'package:drip_out/common/widgets/button/basic_icon_button.dart';
import 'package:drip_out/core/configs/assets/app_images.dart';
import 'package:drip_out/core/configs/assets/app_vectors.dart';
import 'package:drip_out/core/configs/theme/app_colors.dart';
import 'package:drip_out/home/presentation/widgets/category_bar.dart';
import 'package:drip_out/common/widgets/app_bar/basic_app_bar.dart';
import 'package:drip_out/home/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  final Function(bool) onBottomNavVisibilityChanged;

  const HomeScreen({super.key, required this.onBottomNavVisibilityChanged});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedCategoryIndex = 0;
  late final ScrollController _scrollController;
  bool _showSearchBar = true;
  List<String> categories = ['All', 'TShirts', 'Jeans', 'Shoes', 'Shirts'];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  _scrollListener() {
    final direction = _scrollController.position.userScrollDirection;
    if (direction == ScrollDirection.reverse) {
      if (_showSearchBar) {
        setState(() {
          _showSearchBar = false;
          widget.onBottomNavVisibilityChanged(false);
        });
      }
    } else if (direction == ScrollDirection.forward) {
      if (!_showSearchBar) {
        setState(() {
          _showSearchBar = true;
          widget.onBottomNavVisibilityChanged(true);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          BasicAppBar(onNotificationsPressed: () {}, title: 'Discover'),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: _showSearchBar ? 75.h : 0,
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                color: Colors.white,
                child: Row(
                  children: [
                    Expanded(
                      child: MyTextField(
                        hintText: 'Search for clothes...',
                        prefixIcon: Padding(
                          padding: EdgeInsets.symmetric(vertical: 15.r),
                          child:
                              SvgPicture.asset(AppVectors.searchIconInactive),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset(AppVectors.micIcon),
                        ),
                      ),
                    ),
                    8.horizontalSpace,
                    BasicIconButton(
                      icon: SvgPicture.asset(AppVectors.filterIcon),
                      onPressed: () {},
                      backgroundColor: AppColors.primaryColor,
                      foregroundColor: Colors.white,
                      size: 60.r,
                    )
                  ],
                ),
              ),
            ),
          ),
          CategoryBar(
              categories: categories,
              selectedIndex: _selectedCategoryIndex,
              onCategorySelected: (index) {
                setState(() {
                  _selectedCategoryIndex = index;
                });
              }),
          Expanded(
            child: GridView.builder(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              controller: _scrollController,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 5.h,
                crossAxisSpacing: 20.w,
                childAspectRatio: 0.6.w,
              ),
              padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h),
              itemCount: 20,
              itemBuilder: (context, index) {
                return ProductCard(
                  onTap: () {},
                  image: Image.asset(
                    AppImages.tshirt,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                  title: 'Polo Regular Fit',
                  price: 1100,
                  onLovePressed: () {},
                  discount: 52,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
