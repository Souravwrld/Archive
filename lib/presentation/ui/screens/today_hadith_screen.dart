import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../application/utility/colors.dart';
import '../../state_holders/Providers/hadith_provider.dart';

class TodayHadithScreen extends StatelessWidget {
  const TodayHadithScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pop(context);
          return false;
        },
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/secondary_background.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(top: 40.h),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back),
                      color: AppColors.colorWhiteHighEmp,
                    ),
                    Text(
                      "today_hadith".tr,
                      style: TextStyle(
                        color: AppColors.colorWhiteHighEmp,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: double.maxFinite,
                height: 650.h,
                padding: EdgeInsets.all(16.h),
                margin: EdgeInsets.all(16.h),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Consumer<HadithProvider>(
                  builder: (context, hadithProvider, child){
                    return hadithProvider.randomHadithIndex == -1?
                    const Center(child: CircularProgressIndicator()) :
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          hadithProvider.allHadith![hadithProvider.randomHadithIndex].hadithArabic!,
                          maxLines: 3,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 14.sp,
                              overflow: TextOverflow.ellipsis,
                              color: Colors.white
                          ),
                        ),
                        SizedBox(height: 10.h,),
                        hadithProvider.language == 'ar' ? const SizedBox() :
                        Text(
                          hadithProvider.language == 'en'?
                          hadithProvider.allHadith![hadithProvider.randomHadithIndex].hadithEnglish! :
                          hadithProvider.language == 'ur'?
                          hadithProvider.allHadith![hadithProvider.randomHadithIndex].hadithUrdu! :
                          hadithProvider.allHadith![hadithProvider.randomHadithIndex].hadithTurkish!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.white
                          ),
                        )
                      ],
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
