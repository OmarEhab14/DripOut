import 'package:drip_out/account/presentation/screens/account_screen.dart';
import 'package:drip_out/cart/presentation/screens/cart_screen.dart';
import 'package:drip_out/core/configs/assets/app_vectors.dart';
import 'package:drip_out/core/configs/theme/app_colors.dart';
import 'package:drip_out/home/presentation/screens/home_screen.dart';
import 'package:drip_out/saved/presentation/screens/saved_screen.dart';
import 'package:drip_out/search/presentation/screens/search_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
      HomeScreen(
        onBottomNavVisibilityChanged: (shouldShow) {
          setState(() {
            _showBottomNavBar = shouldShow;
          });
        },
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
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;

        final bool isExitWarning = DateTime.now().difference(timeBackPressed) >=
            const Duration(seconds: 2);
        timeBackPressed = DateTime.now();
        if (isExitWarning) {
          Fluttertoast.showToast(msg: "Press back again to exit");
        } else {
          Navigator.of(context).pop(result);
        }
      },
      child: Scaffold(
        body: IndexedStack(
          index: currentIndex,
          children: screens,
        ),
        bottomNavigationBar: AnimatedSize(
          duration: const Duration(milliseconds: 300),
          // height: _showBottomNavBar ? 60.h : 0,
          // height: 60.h,
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
