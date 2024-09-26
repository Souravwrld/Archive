import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:JazakAllah/application/utility/colors.dart';
import 'package:JazakAllah/presentation/state_holders/navigation_controller.dart';
import 'package:JazakAllah/presentation/ui/screens/auth/signin_screen.dart';
import 'package:JazakAllah/presentation/ui/screens/auth/signup_screen.dart';
import 'package:JazakAllah/presentation/ui/screens/home_screen.dart';
import 'package:JazakAllah/presentation/ui/utility/assets_path.dart';
import 'package:JazakAllah/presentation/ui/widgets/reusable_background_image.dart';

class LocationAccessScreen extends StatelessWidget {
  const LocationAccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ReusableBackgroundImage(
              bgImagePath: AssetsPath.backgroundLocationSVG),
          Positioned(
            left: 0,
            right: 0,
            bottom: 50,
            child: Center(
              child: SizedBox(
                width: 150.w,
                height: 46.h,
                child: ElevatedButton(
                  onPressed: () async {
                    // await NavigationController.getAppInstallValue();
                    // if (NavigationController.isFirstTimeOpening ?? true) {
                    //   await NavigationController.setAppInstallValue(false);
                    //   Get.offAll(() => SignUpScreen());
                    // } else {
                    //   Get.offAll(() => SignInScreen());
                    // }
                  },
                  child: Text(
                    'get_location'.tr,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.colorBlackHighEmp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
