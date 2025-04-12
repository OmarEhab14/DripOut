import 'package:drip_out/authentication/presentation/widgets/my_textfield.dart';
import 'package:drip_out/common/widgets/button/basic_icon_button.dart';
import 'package:drip_out/core/configs/assets/app_images.dart';
import 'package:drip_out/core/configs/assets/app_vectors.dart';
import 'package:drip_out/core/configs/theme/app_colors.dart';
import 'package:drip_out/home/presentation/widgets/sliver_category_delegate.dart';
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
  bool _showBottomNavBar = true;
  bool _showSearchBar = true;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
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
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              pinned: true,
              floating: true,
              backgroundColor: Colors.white,
              scrolledUnderElevation: 0,
              elevation: 0,
              leading: 0.horizontalSpace,
              leadingWidth: 1.w,
              title: Text(
                'Discover',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    AppVectors.notificationBell,
                    width: 30.r,
                  ),
                ),
                10.horizontalSpace,
              ],
            ),
            SliverToBoxAdapter(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                // height: _showSearchBar ? 75.h : 0,
                // height: 75.h,
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                    child: Row(
                      children: [
                        Expanded(
                          child: MyTextField(
                            hintText: 'Search for clothes...',
                            prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(vertical: 15.r),
                              child: SvgPicture.asset(
                                  AppVectors.searchIconInactive),
                            ),
                            suffixIcon: IconButton(
                                onPressed: () {},
                                icon: SvgPicture.asset(AppVectors.micIcon)),
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
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: SliverCategoryDelegate(
                categories: ['All', 'TShirts', 'Jeans', 'Shoes', 'Shirts'],
                selectedIndex: _selectedCategoryIndex,
                onCategorySelected: (index) {
                  setState(() {
                    _selectedCategoryIndex = index;
                  });
                },
              ),
            ),
          ];
        },
        body: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 5.h,
              crossAxisSpacing: 20.w,
              childAspectRatio: 0.6.w,
            ),
            padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h),
            itemCount: 20,
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(15.r),
                child: InkWell(
                  onTap: () {},
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 200.r,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(15.r),
                                child: Image.asset(
                                  AppImages.tshirt,
                                  fit: BoxFit.cover,
                                  // height: 180.h,
                                  width: double.infinity,
                                )),
                          ),
                          5.verticalSpace,
                          Text(
                            'Regular Fit Polo',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 18.sp, fontWeight: FontWeight.w600),
                          ),
                          5.verticalSpace,
                          Row(
                            children: [
                              Text(
                                '\$1100',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primarySwatch[500]),
                              ),
                              5.horizontalSpace,
                              Text('-52%', style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.red,)),
                            ],
                          )
                        ],
                      ),
                      Positioned(
                        right: 5.w,
                        top: 5.h,
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [BoxShadow(
                              color: AppColors.primarySwatch[500]!,
                              spreadRadius: 0.3,
                              blurRadius: 30,
                              offset: const Offset(0, 15)
                            )]
                          ),
                          child: BasicIconButton(
                            icon: SvgPicture.asset(AppVectors.loveIcon),
                            onPressed: () {},
                            backgroundColor: Colors.white,
                            size: 5.r,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
