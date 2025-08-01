import 'package:drip_out/account/presentation/screens/account_screen.dart';
import 'package:drip_out/cart/presentation/screens/cart_screen.dart';
import 'package:drip_out/common/widgets/double_tap_to_exit/double_tap_to_exit.dart';
import 'package:drip_out/core/configs/assets/app_vectors.dart';
import 'package:drip_out/core/configs/theme/app_colors.dart';
import 'package:drip_out/core/dependency_injection/service_locator.dart';
import 'package:drip_out/products/domain/usecases/get_products_usecase.dart';
import 'package:drip_out/products/presentation/bloc/paginated_products_bloc/paginated_products_cubit.dart';
import 'package:drip_out/products/presentation/screens/home_screen.dart';
import 'package:drip_out/saved/presentation/screens/saved_screen.dart';
import 'package:drip_out/search/presentation/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainScreen extends StatefulWidget {
  final int initialIndex;

  const MainScreen({super.key, this.initialIndex = 0});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int currentIndex;
  bool _showBottomNavBar = true;
  late final List<Widget> screens;
  late final ScrollController _scrollController;
  DateTime timeBackPressed = DateTime.now();
  bool canPopNow = false;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
    _scrollController = ScrollController();
    screens = [
      BlocProvider(
        create: (context) => PaginatedProductsCubit(sl<GetProductsUseCase>())..loadCategoryProducts(0),
        child: HomeScreen(
          onBottomNavVisibilityChanged: (shouldShow) {
            setState(() {
              _showBottomNavBar = shouldShow;
            });
          },
        ),
      ),
      SearchScreen(),
      SavedScreen(),
      CartScreen(),
      AccountScreen(),
    ];
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DoubleTapToExit(
      child: Scaffold(
        body: IndexedStack(
          index: currentIndex,
          children: screens,
        ),
        bottomNavigationBar: AnimatedSize(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
          child: _showBottomNavBar
              ? BottomNavigationBar(
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            currentIndex: currentIndex,
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: AppColors.primaryColor,
            unselectedItemColor: Colors.grey,
            selectedLabelStyle:
            const TextStyle(fontWeight: FontWeight.w600),
            unselectedLabelStyle:
            const TextStyle(fontWeight: FontWeight.w600),
            items: [
              BottomNavigationBarItem(
                  icon: currentIndex == 0
                      ? SvgPicture.asset(AppVectors.homeIcon)
                      : SvgPicture.asset(AppVectors.homeIconInactive),
                  label: 'Home'),
              BottomNavigationBarItem(
                  icon: currentIndex == 1
                      ? SvgPicture.asset(AppVectors.searchIcon)
                      : SvgPicture.asset(AppVectors.searchIconInactive),
                  label: 'Search'),
              BottomNavigationBarItem(
                  icon: currentIndex == 2
                      ? SvgPicture.asset(AppVectors.loveIcon)
                      : SvgPicture.asset(AppVectors.loveIconInactive),
                  label: 'Saved'),
              BottomNavigationBarItem(
                  icon: currentIndex == 3
                      ? SvgPicture.asset(AppVectors.cartIcon)
                      : SvgPicture.asset(AppVectors.cartIconInactive),
                  label: 'Cart'),
              BottomNavigationBarItem(
                  icon: currentIndex == 4
                      ? SvgPicture.asset(AppVectors.accountIcon)
                      : SvgPicture.asset(AppVectors.accountIconInactive),
                  label: 'Account'),
            ],
          )
              : const SizedBox.shrink(),
        ),
      ),
    );
  }
}
