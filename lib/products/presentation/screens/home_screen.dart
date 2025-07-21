import 'dart:developer';

import 'package:drip_out/common/widgets/button/basic_icon_button.dart';
import 'package:drip_out/common/widgets/search_bar/app_search_bar.dart';
import 'package:drip_out/core/configs/assets/app_images.dart';
import 'package:drip_out/core/configs/assets/app_vectors.dart';
import 'package:drip_out/core/configs/theme/app_colors.dart';
import 'package:drip_out/common/widgets/app_bar/basic_app_bar.dart';
import 'package:drip_out/core/dependency_injection/service_locator.dart';
import 'package:drip_out/products/data/models/product_model.dart';
import 'package:drip_out/products/domain/usecases/get_categories_usecase.dart';
import 'package:drip_out/products/domain/usecases/get_products_usecase.dart';
import 'package:drip_out/products/presentation/bloc/categories_bloc/categories_cubit.dart';
import 'package:drip_out/products/presentation/bloc/paginated_products_bloc/paginated_products_cubit.dart';
import 'package:drip_out/products/presentation/widgets/category_bar.dart';
import 'package:drip_out/products/presentation/widgets/filter_bottom_sheet.dart';
import 'package:drip_out/products/presentation/widgets/product_card.dart';
import 'package:drip_out/products/presentation/widgets/shimmered_category_bar.dart';
import 'package:drip_out/products/presentation/widgets/shimmered_product_card.dart';
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

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _scrollController.addListener(() {
      context
          .read<PaginatedProductsCubit>()
          .saveScrollOffset(_scrollController.offset);
    });
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

  void _restoreScrollPosition() {
    final cubit = context.read<PaginatedProductsCubit>();
    final savedOffset = cubit.getScrollOffset(_selectedCategoryIndex);

    if (savedOffset > 0 && _scrollController.hasClients) {
      _scrollController.jumpTo(savedOffset);
    }
  }

  void _showFilterBottomSheet(BuildContext context, double minPrice, double maxPrice, List<String> sizes) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return FilterBottomSheet(context: context, minPrice: minPrice, maxPrice: maxPrice, sizes: sizes,);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final dynamicAspectRatio = (screenWidth / 2 - 50) / (screenHeight * 0.32);
    return Scaffold(
      backgroundColor: Colors.grey[200],
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
                    BlocBuilder<PaginatedProductsCubit, PaginatedProductsState>(
                      builder: (context, state) {
                        late double minPrice;
                        late double maxPrice;
                        late List<String> sizes;
                        bool success = false;
                        if (state is PaginatedProductsLoaded) {
                          minPrice = state.minPrice;
                          maxPrice = state.maxPrice;
                          sizes = state.sizes;
                          success = true;
                        }
                        return BasicIconButton(
                          icon: SvgPicture.asset(AppVectors.filterIcon),
                          onPressed: () {
                            if (success) {
                              _showFilterBottomSheet(context, minPrice, maxPrice, sizes);
                            } else {
                              showModalBottomSheet(
                                context: context,
                                backgroundColor: Colors.white,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                                ),
                                builder: (BuildContext context) {
                                    return Center(child: Text('Something went wrong'),);
                                  },
                              );
                            }
                          },
                          backgroundColor: AppColors.primaryColor,
                          foregroundColor: Colors.white,
                          size: 60.r,
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
          BlocProvider(
            create: (context) =>
                CategoriesCubit(sl<GetCategoriesUseCase>())..loadCategories(),
            child: BlocBuilder<CategoriesCubit, CategoriesState>(
              builder: (context, state) {
                if (state is CategoriesSuccess) {
                  return CategoryBar(
                    categories: state.categoriesResponse.categories,
                    selectedIndex: _selectedCategoryIndex,
                    onCategorySelected: (index) {
                      setState(() {
                        _selectedCategoryIndex = index;
                      });
                      log('selected category index: $_selectedCategoryIndex');
                      context
                          .read<PaginatedProductsCubit>()
                          .reloadCachedProducts(_selectedCategoryIndex);
                    },
                  );
                }
                return ShimmeredCategoryBar();
              },
            ),
          ),
          Expanded(
            child: BlocConsumer<PaginatedProductsCubit, PaginatedProductsState>(
              listener: (context, state) {
                if (state is PaginatedProductsLoaded &&
                    state.products.isNotEmpty) {
                  _restoreScrollPosition();
                }
              },
              builder: (context, state) {
                if (state is PaginatedProductsLoading &&
                    state.oldProducts.isEmpty) {
                  return _buildShimmeredProductsGridView(dynamicAspectRatio);
                }

                final cubit = context.read<PaginatedProductsCubit>();

                List<ProductModel> products = [];
                bool isLoadingMore = false;
                bool loadingMoreDataError = false;

                if (state is PaginatedProductsLoading) {
                  products = state.oldProducts;
                  isLoadingMore = true;
                } else if (state is PaginatedProductsLoaded) {
                  products = state.products;
                } else if (state is PaginatedProductsError &&
                    products.isEmpty) {
                  return _buildProductsErrorMessage(state.error.message, cubit);
                } else if (state is PaginatedProductsError) {
                  loadingMoreDataError = true;
                }

                return RefreshIndicator(
                  color: AppColors.primaryColor,
                  backgroundColor: Colors.white,
                  onRefresh: () {
                    return Future.delayed(Duration(seconds: 2), () {
                      cubit.refresh();
                    });
                  },
                  child: CustomScrollView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    controller: _scrollController,
                    slivers: [
                      SliverPadding(
                        padding: EdgeInsets.only(
                          left: 10.w,
                          right: 10.w,
                          top: 5.h,
                        ),
                        sliver: SliverGrid(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 5.h,
                            crossAxisSpacing: 5.w,
                            childAspectRatio: dynamicAspectRatio,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              cubit.checkIfNeedMoreData(index);
                              return ProductCard(
                                onTap: () {},
                                image: products[index].image == null
                                    ? Image.asset(
                                        AppImages.shirt,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                      )
                                    : Image.network(
                                        products[index].image!,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Image.asset(
                                            AppImages.productPlaceholder,
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                          );
                                        },
                                      ),
                                title: products[index].title,
                                description: products[index].description,
                                price: products[index].price,
                                rate: products[index].rate,
                                reviews: products[index].reviews,
                                onLovePressed: () {},
                                discount: products[index].discount == 0
                                    ? null
                                    : products[index].discount,
                              );
                            },
                            childCount: products.length,
                          ),
                        ),
                      ),
                      if (isLoadingMore)
                        SliverToBoxAdapter(
                          child: Container(
                            padding: EdgeInsets.all(20.h),
                            alignment: Alignment.center,
                            child: CircularProgressIndicator(
                              color: AppColors.primaryColor,
                              strokeWidth: 2.0.r,
                              strokeCap: StrokeCap.round,
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmeredProductsGridView(double dynamicAspectRatio) {
    return GridView.builder(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 5.h,
        crossAxisSpacing: 5.w,
        childAspectRatio: dynamicAspectRatio,
      ),
      padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 5.h),
      itemCount: 6,
      itemBuilder: (context, index) {
        return ShimmeredProductCard();
      },
    );
  }

  Widget _buildProductsErrorMessage(
      String message, PaginatedProductsCubit cubit) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Error: ${message}',
              style: const TextStyle(color: Colors.red),
            ),
            IconButton(
                onPressed: () {
                  cubit.loadPage();
                },
                icon: Icon(Icons.refresh)),
          ],
        ),
      ),
    );
  }
}
