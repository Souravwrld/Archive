import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:JazakAllah/application/utility/colors.dart';

class ReusableCustomAppbar extends StatelessWidget {
  const ReusableCustomAppbar({
    Key? key,
    required this.screenTitle,
  }) : super(key: key);

  final String screenTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 34,
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: AppColors.colorWhiteHighEmp,
            ),
          ),
          Text(
            screenTitle.tr,
            style: TextStyle(
              color: AppColors.colorWhiteHighEmp,
              fontSize: 16.sp,
              fontFamily: 'Barlow',
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
