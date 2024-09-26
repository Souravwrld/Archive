import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../application/utility/colors.dart';
import '../utility/assets_path.dart';
import '../widgets/reusable_background_image.dart';
import '../widgets/reusable_custom_appbar.dart';


class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ReusableBackgroundImage(
            bgImagePath: AssetsPath.secondaryBGSVG,
          ),
          const ReusableCustomAppbar(
            screenTitle: 'about_us',
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 97, left: 16, right: 16, bottom: 16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: AppColors.colorPrimaryLight,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'about_us'.tr,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        color: AppColors.colorWhiteHighEmp,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'about1'.tr,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        color: AppColors.colorWhiteMidEmp,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'about2'.tr,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        color: AppColors.colorWhiteMidEmp,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'about3'.tr,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        color: AppColors.colorWhiteMidEmp,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
