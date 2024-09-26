import 'package:get/get.dart';
import '../../demo.dart';
import '../ui/screens/auth/signin_screen.dart';
import '../ui/screens/home_screen.dart';
import '../ui/screens/makka_live_screen.dart';
import '../ui/screens/onboarding_screen.dart';
import '../ui/screens/preferences_settings_screen.dart';
import 'auth/auth_controller.dart';
import 'navigation_controller.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    goToNextScreen();
  }

  //Method for navigate next screen
  Future<void> goToNextScreen() async {
    await AuthController.getAccessToken();
    await AuthController.getExpireDateAndTime();
    await NavigationController.getOnboardingValue();
    await NavigationController.getLanguageValue();
    await Future.delayed(const Duration(seconds: 2));
    if (NavigationController.isLanguageSelectionComplete ?? true) {
      Get.offAll(() => const PreferencesSettingsScreen());
    } else {
      if (NavigationController.isOnboardingComplete ?? true) {
        Get.offAll(() => OnboardingScreen());
      } else {
        if(AuthController.isLoggedIn){
          Get.offAll(() => const HomeScreen(loadUserData: true,));
        } else{
          Get.offAll(() => const HomeScreen(loadUserData: false,));
        }
      }
    }
  }
}
