import 'package:JazakAllah/presentation/ui/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:JazakAllah/presentation/state_holders/Providers/location_provider.dart';
import 'package:JazakAllah/presentation/state_holders/navigation_controller.dart';
import 'package:JazakAllah/presentation/state_holders/onboarding_screen_controller.dart';
import 'package:JazakAllah/presentation/ui/screens/auth/signup_screen.dart';
import 'package:JazakAllah/presentation/ui/utility/assets_path.dart';
import 'package:JazakAllah/presentation/ui/widgets/onboarding_screen_widgets.dart';

class OnboardingScreen extends StatefulWidget {
  OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<LocationProvider>(context, listen: false).setBool();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<OnboardingScreenController>(
          builder: (onboardingScreenController) {
        return PageView(
          controller: _pageController,
          onPageChanged: (int page) {
            print(page);
            onboardingScreenController.updatePageIndex(page);
          },
          children: <Widget>[
            OnboardingScreenWidgets(
              currentPage: onboardingScreenController.currentPageIndex,
              totalPages: 3,
              textTitle: 'onboarding_text1',
              textDescription: 'onboarding_text2',
              onTap: () {
                changeOnboarding(onboardingScreenController);
              },
              bgPath: AssetsPath.onboarding01BgSVG,
              bgContentImagePath: AssetsPath.onboardingBGContent01SVG,
            ),
            OnboardingScreenWidgets(
              currentPage: onboardingScreenController.currentPageIndex,
              totalPages: 3,
              textTitle: 'onboarding_text3',
              textDescription: 'onboarding_text4',
              onTap: () {
                changeOnboarding(onboardingScreenController);
              },
              bgPath: AssetsPath.onboarding02BgSVG,
              bgContentImagePath: AssetsPath.onboardingBGContent02SVG,
            ),
            OnboardingScreenWidgets(
              currentPage: onboardingScreenController.currentPageIndex,
              totalPages: 3,
              textTitle: 'onboarding_text5',
              textDescription: 'onboarding_text6',
              onTap: () {
                changeOnboarding(onboardingScreenController);
              },
              bgPath: AssetsPath.onboarding03BgSVG,
              bgContentImagePath: AssetsPath.onboardingBGContent03SVG,
            ),
          ],
        );
      }),
    );
  }

  Future<void> changeOnboarding(OnboardingScreenController controller) async {
    if (controller.currentPageIndex == 2) {
      await NavigationController.setOnboardingValue(false);
      Get.offAll(() => HomeScreen(loadUserData: false,));
    } else {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    }
  }
}
