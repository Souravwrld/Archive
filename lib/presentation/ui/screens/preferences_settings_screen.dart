import 'package:JazakAllah/presentation/state_holders/Providers/hadith_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:JazakAllah/data/services/locales/app_constants.dart';
import 'package:JazakAllah/presentation/state_holders/check_language_controller.dart';
import 'package:JazakAllah/presentation/state_holders/language_controller.dart';
import 'package:JazakAllah/presentation/state_holders/navigation_controller.dart';
import 'package:JazakAllah/presentation/ui/screens/onboarding_screen.dart';
import 'package:JazakAllah/presentation/ui/utility/assets_path.dart';
import 'package:JazakAllah/presentation/ui/widgets/reusable_background_image.dart';
import 'package:JazakAllah/presentation/ui/widgets/reusable_custom_appbar.dart';

import '../../state_holders/Providers/location_provider.dart';

class PreferencesSettingsScreen extends StatelessWidget {
  const PreferencesSettingsScreen({super.key});

  void _saveLanguage(String languageCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', languageCode);
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<HadithProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.black12,
      body: Stack(
        children: [
          ReusableBackgroundImage(
            bgImagePath: AssetsPath.secondaryBGSVG,
          ),
          const ReusableCustomAppbar(
            screenTitle: 'select_language',
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    Get.find<LocalizationController>().setLanguage(Locale(
                      AppConstants.languages[0].languageCode,
                      AppConstants.languages[0].countryCode,
                    ));
                    Get.find<LocalizationController>().setSelectedIndex(0);
                    _saveLanguage('en');
                    await languageProvider.getLanguage();
                    await LanguageCheckingController.setLanguage('en');
                    await NavigationController.setLanguageValue(false);
                    await NavigationController.getAppInstallValue();
                    await Provider.of<LocationProvider>(context, listen: false).getBool();
                    if (NavigationController.isFirstTimeOpening ?? true) {
                      NavigationController.setAppInstallValue(false);
                      Get.offAll(() => OnboardingScreen());
                    } else {
                      Get.back();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1D484C),
                    minimumSize: const Size(200, 65),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text(
                    'English',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                ElevatedButton(
                  onPressed: () async {
                    Get.find<LocalizationController>().setLanguage(Locale(
                      AppConstants.languages[1].languageCode,
                      AppConstants.languages[1].countryCode,
                    ));
                    Get.find<LocalizationController>().setSelectedIndex(1);
                    _saveLanguage('ar');
                    await languageProvider.getLanguage();
                    await LanguageCheckingController.setLanguage('ar');
                    await NavigationController.setLanguageValue(false);
                    await NavigationController.getAppInstallValue();
                    await Provider.of<LocationProvider>(context, listen: false).getBool();
                    if (NavigationController.isFirstTimeOpening ?? true) {
                      NavigationController.setAppInstallValue(false);
                      Get.offAll(() => OnboardingScreen());
                    } else {
                      Get.back();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1D484C),
                    minimumSize: const Size(200, 65),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text(
                    'العربية',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                ElevatedButton(
                  onPressed: () async {
                    Get.find<LocalizationController>().setLanguage(Locale(
                      AppConstants.languages[2].languageCode,
                      AppConstants.languages[2].countryCode,
                    ));
                    Get.find<LocalizationController>().setSelectedIndex(1);
                    _saveLanguage('ur');
                    await languageProvider.getLanguage();
                    await LanguageCheckingController.setLanguage('ur');
                    await NavigationController.setLanguageValue(false);
                    await NavigationController.getAppInstallValue();
                    await Provider.of<LocationProvider>(context, listen: false).getBool();
                    if (NavigationController.isFirstTimeOpening ?? true) {
                      NavigationController.setAppInstallValue(false);
                      Get.offAll(() => OnboardingScreen());
                    } else {
                      Get.back();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1D484C),
                    minimumSize: const Size(200, 65),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text(
                    "اردو",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                ElevatedButton(
                  onPressed: () async {
                    Get.find<LocalizationController>().setLanguage(Locale(
                      AppConstants.languages[3].languageCode,
                      AppConstants.languages[3].countryCode,
                    ));
                    Get.find<LocalizationController>().setSelectedIndex(1);
                    _saveLanguage('tr');
                    await languageProvider.getLanguage();
                    await LanguageCheckingController.setLanguage('tr');
                    await NavigationController.setLanguageValue(false);
                    await NavigationController.getAppInstallValue();
                    await Provider.of<LocationProvider>(context, listen: false).getBool();
                    if (NavigationController.isFirstTimeOpening ?? true) {
                      NavigationController.setAppInstallValue(false);
                      Get.offAll(() => OnboardingScreen());
                    } else {
                      Get.back();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1D484C),
                    minimumSize: const Size(200, 65),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text(
                    "Türkçe",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
