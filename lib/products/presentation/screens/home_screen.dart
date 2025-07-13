import 'package:drip_out/common/widgets/button/basic_icon_button.dart';
import 'package:drip_out/common/widgets/search_bar/app_search_bar.dart';
import 'package:drip_out/core/configs/assets/app_images.dart';
import 'package:drip_out/core/configs/assets/app_vectors.dart';
import 'package:drip_out/core/configs/theme/app_colors.dart';
import 'package:drip_out/common/widgets/app_bar/basic_app_bar.dart';
import 'package:drip_out/core/dependency_injection/service_locator.dart';
import 'package:drip_out/products/data/models/product_model.dart';
import 'package:drip_out/products/domain/usecases/get_products_usecase.dart';
import 'package:drip_out/products/presentation/bloc/paginated_products_cubit.dart';
import 'package:drip_out/products/presentation/widgets/category_bar.dart';
import 'package:drip_out/products/presentation/widgets/filter_bottom_sheet.dart';
import 'package:drip_out/products/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return FilterBottomSheet();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final dynamicAspectRatio = (screenWidth / 2 - 30) / (screenHeight * 0.32);
    return Scaffold(
      body: Column(
        children: [
          BasicAppBar(onNotificationsPressed: () {}, title: 'Discover'),
          AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
            height: _showSearchBar ? 75.h : 0,
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                color: Colors.white,
                child: Row(
                  children: [
                    const Expanded(
                      child: AppSearchBar(),
                    ),
                    8.horizontalSpace,
                    BasicIconButton(
                      icon: SvgPicture.asset(AppVectors.filterIcon),
                      onPressed: () {
                        _showFilterBottomSheet(context);
                      },
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
            child: BlocProvider(
              create: (context) =>
                  PaginatedProductsCubit(sl<GetProductsUseCase>())..loadPage(),
              child:
                  BlocBuilder<PaginatedProductsCubit, PaginatedProductsState>(
                builder: (context, state) {
                  if (state is PaginatedProductsLoading &&
                      state.oldProducts.isEmpty) {
                    return Center(child: const CircularProgressIndicator());
                  }

                  final cubit = context.read<PaginatedProductsCubit>();

                  List<ProductModel> products = [];
                  bool isLoadingMore = false;

                  if (state is PaginatedProductsLoading) {
                    products = state.oldProducts;
                    isLoadingMore = true;
                  } else if (state is PaginatedProductsLoaded) {
                    products = state.products;
                  } else if (state is PaginatedProductsError) {
                    return Center(
                      child: Text(
                        'Error: ${state.error.message}',
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }

                  return Stack(
                    children: [
                      GridView.builder(
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        controller: _scrollController,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 5.h,
                          crossAxisSpacing: 20.w,
                          childAspectRatio: dynamicAspectRatio,
                        ),
                        padding:
                            EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          cubit.checkIfNeedMoreData(index);
                          return ProductCard(
                            onTap: () {},
                            image: products[index].images.isEmpty
                                ? Image.asset(
                                    AppImages.tshirt,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  )
                                : Image.network(
                                    products[index].images[0]!,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ),
                            title: products[index].title,
                            price: products[index].price,
                            onLovePressed: () {},
                            discount: products[index].discount == 0 ? null : products[index].discount,
                          );
                        },
                      ),
                      if (isLoadingMore)
                        Positioned(
                          bottom: 16,
                          left: 0,
                          right: 0,
                          child: Center(child: CircularProgressIndicator()),
                        ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
