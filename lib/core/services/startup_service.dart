import 'package:drip_out/authentication/domain/use_cases/check_auth_status_usecase.dart';
import 'package:drip_out/authentication/domain/use_cases/check_first_time_usecase.dart';
import 'package:drip_out/core/configs/constants/screen_names.dart';

class StartupService {
  final CheckAuthStatusUseCase checkAuthStatusUseCase;
  final CheckIfFirstTimeUseCase checkIfFirstTimeUseCase;

  StartupService(
      {required this.checkAuthStatusUseCase,
      required this.checkIfFirstTimeUseCase});

  Future<String> determineStartupScreen() async {
    bool isFirstTime = await checkIfFirstTimeUseCase.call();
    if (isFirstTime) {
      return ScreenNames.onboardingScreen;
    } else {
      bool isAuthenticated = await checkAuthStatusUseCase.call();
      if (isAuthenticated) {
        return ScreenNames.mainScreen;
      }
      return ScreenNames.signupScreen;
    }
  }
}
