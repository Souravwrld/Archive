import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:JazakAllah/application/utility/colors.dart';
import 'package:provider/provider.dart';

import '../../state_holders/Providers/location_provider.dart';

class AzkarDetailsCard extends StatelessWidget {
  const AzkarDetailsCard({
    super.key,
    required this.azkarEnglish,
    required this.azkarArabic,
    required this.azkarTurkish,
    required this.azkarUrdu,
  });

  final String azkarEnglish;
  final String azkarArabic;
  final String azkarTurkish;
  final String azkarUrdu;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocationProvider>(context, listen:  false);
    return Card(
      color: const Color(0xFF336B6C),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          children: [
            Text(
              azkarArabic,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.colorWhiteHighEmp,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            provider.isArabic? SizedBox():
            provider.isEnglish? Text(
              azkarEnglish,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.colorWhiteHighEmp,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ): provider.isUrdu? Text(
              azkarUrdu,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.colorWhiteHighEmp,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ):
            Text(
              azkarTurkish,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.colorWhiteHighEmp,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
