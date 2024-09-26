import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:JazakAllah/application/utility/colors.dart';
import 'package:provider/provider.dart';

import '../../state_holders/Providers/location_provider.dart';

class CategoryDataDetailsCard extends StatelessWidget {
  const CategoryDataDetailsCard({
    super.key,
    this.authorName,
    required this.amolEnglish,
    required this.amolArabic,
    required this.amolTurkish,
    required this.amolUrdu,
    required this.title,
  });

  final String? authorName;
  final String amolEnglish;
  final String amolArabic;
  final String amolTurkish;
  final String amolUrdu;
  final String title;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocationProvider>(context, listen:  false);
    return Card(
      color: AppColors.colorPrimaryLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.colorWhiteHighEmp,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            authorName != null
                ? Text(
                    authorName!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.colorPrimaryLighter,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                : const SizedBox(
                    height: 0,
                  ),
            const SizedBox(
              height: 16,
            ),
            Container(
              color: Colors.white,
              height: 0.5,
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              amolArabic,
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
              amolEnglish,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.colorWhiteHighEmp,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ): provider.isUrdu? Text(
              amolUrdu,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.colorWhiteHighEmp,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ):
            Text(
              amolTurkish,
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
