import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:JazakAllah/application/utility/colors.dart';

class SurahDetailsCard extends StatelessWidget {
  const SurahDetailsCard({
    super.key,
    required this.surahEnglish,
    required this.surahArabic,
  });

  final String surahEnglish;
  final String surahArabic;

  @override
  Widget build(BuildContext context) {
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
              surahArabic,
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
            Text(
              surahEnglish,
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
