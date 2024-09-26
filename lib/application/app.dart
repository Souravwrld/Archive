import 'package:JazakAllah/application/utility/state_holder_binder.dart';
import 'package:JazakAllah/application/utility/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../data/services/locales/app_constants.dart';
import '../data/services/locales/messages.dart';
import '../presentation/state_holders/language_controller.dart';
import '../presentation/ui/screens/splash_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class JazakAllah extends StatelessWidget {
  const JazakAllah({super.key, required this.languages});

  final Map<String, Map<String, String>> languages;

  @override
  Widget build(BuildContext context) {
    // Lock the orientation to portrait mode
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ScreenUtilInit(
        designSize: const Size(360, 800),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return GetBuilder<LocalizationController>(
              builder: (localizationController) {
            return GetMaterialApp(
              localizationsDelegates: [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              supportedLocales: [
                const Locale('en', 'USA'),
                const Locale('ar', 'SA'),
              ],
              debugShowCheckedModeBanner: false,
              title: 'JazakAllah',
              theme: ThemeManager.getAppTheme(),
              locale: localizationController.locale,
              translations: Messages(languages: languages),
              fallbackLocale: Locale(
                AppConstants.languages[0].languageCode,
                AppConstants.languages[0].countryCode,
              ),
              initialBinding: StateHolderBinder(),
              home: const SplashScreen(),
            );
          });
        });
  }
}
