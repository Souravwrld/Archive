import 'package:get/get.dart';

import '../../presentation/state_holders/auth/reset_password_screen_controller.dart';
import '../../presentation/state_holders/auth/signin_screen_controller.dart';
import '../../presentation/state_holders/auth/signup_screen_controller.dart';
import '../../presentation/state_holders/auth/verify_email_screen_controller.dart';
import '../../presentation/state_holders/auth/verify_otp_screen_controller.dart';
import '../../presentation/state_holders/azkar_category_data_list_controller.dart';
import '../../presentation/state_holders/category_list_controller.dart';
import '../../presentation/state_holders/dua_category_data_list_controller.dart';
import '../../presentation/state_holders/edit_profile_screen_controller.dart';
import '../../presentation/state_holders/event_prayer_category_data_list_controller.dart';
import '../../presentation/state_holders/full_surah_details_controller.dart';
import '../../presentation/state_holders/hadith_category_data_list_controller.dart';
import '../../presentation/state_holders/onboarding_screen_controller.dart';
import '../../presentation/state_holders/splash_screen_controller.dart';

class StateHolderBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashScreenController());
    Get.put(OnboardingScreenController());
    Get.put(SignUpScreenController());
    Get.put(SignInScreenController());
    Get.put(VerifyEmailScreenController());
    Get.put(OtpVerificationController());
    Get.put(ResetPasswordScreenController());
    Get.put(CategoryListController());
    Get.put(HadithCategoryDataListController());
    Get.put(DuaCategoryDataListController());
    Get.put(AzkarCategoryDataListController());
    Get.put(EventPrayerCategoryDataListController());
    Get.put(FullSurahDetailsController());
    Get.put(EditProfileScreenController());
  }
}
