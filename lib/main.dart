import 'dart:developer';

import 'package:drip_out/core/configs/theme/app_theme.dart';
import 'package:drip_out/core/dependency_injection/service_locator.dart';
import 'package:drip_out/core/routes/app_router.dart';
import 'package:drip_out/core/services/startup_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  log('Flutter initialized');

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await setupServiceLocator();
  log('service locator has initialized');
  final startScreen = await sl<StartupService>().determineStartupScreen();

  log('start screen has been determined');

  runApp(MyApp(appRouter: AppRouter(), startScreen: startScreen, navigatorKey: navigatorKey,));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  final String? startScreen;
  final GlobalKey<NavigatorState>? navigatorKey;
  const MyApp({super.key, required this.appRouter, this.startScreen, this.navigatorKey});

  bool isTablet(BuildContext context) {
    final shortestSide = MediaQuery.of(context).size.shortestSide;
    return shortestSide > 600;
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize:
          isTablet(context) ? const Size(768, 1024) : const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'DripOut',
          navigatorKey: navigatorKey,
          theme: AppTheme.appTheme,
          initialRoute: startScreen,
          onGenerateRoute: appRouter.generateRoute,
          // home: child,
        );
      },
      // child: const OnboardingScreen(),
    );
  }
}
