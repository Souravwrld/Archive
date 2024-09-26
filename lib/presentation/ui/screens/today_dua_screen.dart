import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../application/utility/colors.dart';
import '../../state_holders/Providers/hadith_provider.dart';

class TodayDuaScreen extends StatelessWidget {
  const TodayDuaScreen({super.key});

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
                      "today_dua".tr,
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
                    builder: (context, duaProvider, child){
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          duaProvider.randomDuaIndex == -1?
                          const Center(child: CircularProgressIndicator()) :
                          Column(
                            children: [
                              Text(
                                duaProvider.allDua![duaProvider.randomDuaIndex].duaArabic!,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    //overflow: TextOverflow.ellipsis,
                                    color: Colors.white
                                ),
                              ),
                              SizedBox(height: 16.h,),
                              Text(
                                duaProvider.language == 'ar'?
                                '' :
                                duaProvider.language == 'en'?
                                duaProvider.allDua![duaProvider.randomDuaIndex].duaEnglish! :
                                duaProvider.language == 'ur'?
                                duaProvider.allDua![duaProvider.randomDuaIndex].duaUrdu! :
                                duaProvider.allDua![duaProvider.randomDuaIndex].duaTurkish!,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    //overflow: TextOverflow.ellipsis,
                                    color: Colors.white
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    }
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}