import 'package:drip_out/core/configs/theme/app_theme.dart';
import 'package:drip_out/core/dependency_injection/service_locator.dart';
import 'package:drip_out/core/routes/app_router.dart';
import 'package:drip_out/core/services/startup_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await setupServiceLocator();
  final startScreen = await sl<StartupService>().determineStartupScreen();

  runApp(MyApp(appRouter: AppRouter(), startScreen: startScreen,));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  final String? startScreen;
  const MyApp({super.key, required this.appRouter, this.startScreen});

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
