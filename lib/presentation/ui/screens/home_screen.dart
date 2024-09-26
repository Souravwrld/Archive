import 'dart:convert';
import 'package:JazakAllah/presentation/state_holders/Providers/hadith_provider.dart';
import 'package:JazakAllah/presentation/state_holders/Providers/link_provider.dart';
import 'package:JazakAllah/presentation/ui/screens/islamic_baby_name_screen.dart';
import 'package:JazakAllah/presentation/ui/screens/makka_live_screen.dart';
import 'package:JazakAllah/presentation/ui/screens/preference_screen.dart';
import 'package:JazakAllah/presentation/ui/screens/today_dua_screen.dart';
import 'package:JazakAllah/presentation/ui/screens/today_hadith_screen.dart';
import 'package:JazakAllah/presentation/ui/screens/wallpapers/all_wallpers_screen.dart';
import 'package:JazakAllah/presentation/ui/screens/zakat_calculator.dart';
import 'package:JazakAllah/presentation/ui/widgets/loading_popup.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:JazakAllah/application/utility/colors.dart';
import 'package:JazakAllah/presentation/state_holders/auth/auth_controller.dart';
import 'package:JazakAllah/presentation/ui/screens/about_us_screen.dart';
import 'package:JazakAllah/presentation/ui/screens/auth/signin_screen.dart';
import 'package:JazakAllah/presentation/ui/screens/chat_screen.dart';
import 'package:JazakAllah/presentation/ui/screens/prayer_time_screen.dart';
import 'package:JazakAllah/presentation/ui/screens/preferences_settings_screen.dart';
import 'package:JazakAllah/presentation/ui/screens/privacy_policy_screen.dart';
import 'package:JazakAllah/presentation/ui/screens/Qibla/qibla_compass_screen.dart';
import 'package:JazakAllah/presentation/ui/screens/reusable_category_list_screen.dart';
import 'package:JazakAllah/presentation/ui/screens/reusable_counter_summery_screen.dart';
import 'package:JazakAllah/presentation/ui/screens/reusable_tasbih_counter_screen.dart';
import 'package:JazakAllah/presentation/ui/screens/subscription_and_donation_screen.dart';
import 'package:JazakAllah/presentation/ui/screens/edit_profile_screen.dart';
import 'package:JazakAllah/presentation/ui/utility/assets_path.dart';

import '../../../demo.dart';
import '../../Bar Graph/bar_graph.dart';
import '../../state_holders/Providers/counter_provider.dart';
import '../../state_holders/Providers/location_provider.dart';
import '../../state_holders/Providers/note_provider.dart';
import '../../state_holders/Providers/user_provider.dart';
import '../utility/functions_and_methods.dart';
import '../widgets/congrats_custom_dialogue.dart';
import 'islamic_calender.dart';
import 'mosque_loaction_screen.dart';

class HomeScreen extends StatefulWidget {
  final bool loadUserData;
  const HomeScreen({super.key, required this.loadUserData});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //This method id for getting zikir list from json based on app language
    readJson();
    //Method for getting location and update prayer time
    loadData();
  }

  Future<void> loadData() async{
    Provider.of<UserProvider>(context, listen: false).fetchLoggedInUserData(widget.loadUserData);
    Provider.of<HadithProvider>(context, listen: false).getLanguage();
    Provider.of<LocationProvider>(context, listen: false).getLocation();
    Provider.of<LinkProvider>(context, listen: false).fetchData();

  }



  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocationProvider>(context, listen: false);
    return Consumer<UserProvider>(
        builder: (context, userProvider, child){
          return Stack(
            children: [
              Scaffold(
                backgroundColor: AppColors.backgroundColor,
                body: ColorfulSafeArea(
                  color: AppColors.colorGradient1Start,
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.colorGradient1Start,
                          AppColors.colorGradientX
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Column(
                      children: [
                        appBar(),
                        Expanded(
                          child: ListView(
                            children: [
                              slider(),
                              SizedBox(height: 4.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: _buildPageIndicator(),
                              ),
                              SizedBox(height: 16.h),
                              Container(
                                padding: const EdgeInsets.all(16.0),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    homeMenuWidget(),
                                    SizedBox(height: 20.h),
                                    homePrayerTimeWidget(),
                                    SizedBox(height: 20.h),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "today_hadith".tr,
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ],
                                    ),
                                    randomHadithWidget(),
                                    SizedBox(height: 8.h),
                                    randomDuaWidget(),
                                    SizedBox(height: 20.h),
                                    nameBannerWidget()
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                bottomNavigationBar: Container(
                  height: 70.h,
                  width: double.infinity,
                  color: AppColors.colorWhiteHighEmp,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: SvgPicture.asset(
                          AssetsPath.homeIconSVG,
                          height: 50.h,
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Get.to(() => const CompassScreen());
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                AssetsPath.compassIconSVG,
                                height: 20.h,
                              ),
                              Text(
                                'qibla_compass2'.tr,
                                style: TextStyle(fontSize: 10.sp),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Get.to(() => const ChatScreen());
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                AssetsPath.chatIconSVG,
                                height: 20.h,
                              ),
                              Text(
                                "chat".tr,
                                style: TextStyle(fontSize: 10.sp),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            showBottomSheetMethod(context);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                AssetsPath.menuIconSVG,
                                height: 20.h,
                              ),
                              Text(
                                'menu'.tr,
                                style: TextStyle(fontSize: 10.sp),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              userProvider.userDataLoading?
              Scaffold(
                    backgroundColor: Colors.black.withOpacity(0.4),
                    body: const LoadingPopup(),
                  ) : const SizedBox(),
            ],
          );
    });
  }

  void showBottomSheetMethod(BuildContext context) {
    final provider = Provider.of<UserProvider>(context, listen: false);
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      constraints: BoxConstraints.expand(width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height - 150),
      builder: (BuildContext context) {
        return IntrinsicHeight(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.colorGradient2Start,
                  AppColors.colorGradient2End,
                ],
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  SizedBox(height: 12.h),
                  Container(
                    height: 6.h,
                    width: 57.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white38),
                  ),
                  SizedBox(height: 10.h),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // ---- Al-Quran Screen Screen ---- //
                              GestureDetector(
                                onTap: () {
                                  getCategories('dua-categories', 'AL-QURAN');
                                },
                                child: Container(
                                  height: 110.h,
                                  width: 102.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: Colors.white),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        AssetsPath.alQuranIconPNG,
                                        height: 32.h,
                                        width: 32.w,
                                      ),
                                      SizedBox(height: 8.h),
                                      Text(
                                        'alquran'.tr,
                                        style: TextStyle(
                                            color: AppColors.colorBlackHighEmp,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              // ---- Hadith Screen ---- //
                              GestureDetector(
                                onTap: () {
                                  getCategories('hadith-categories', 'HADITH');
                                },
                                child: Container(
                                  height: 110.h,
                                  width: 102.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: Colors.white),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        AssetsPath.hadithIconPNG,
                                        height: 32.h,
                                        width: 32.w,
                                      ),
                                      SizedBox(height: 8.h),
                                      Text(
                                        'hadith'.tr,
                                        style: TextStyle(
                                            color: AppColors.colorBlackHighEmp,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              // ---- Donation Screen ---- //
                              GestureDetector(
                                onTap: () async{
                                  provider.userData!.thumbnailUrl == 'Null'?
                                  showCustomAlertDialog(context) :
                                  Get.to(() =>
                                  const SubscriptionAndDonationScreen());
                                },
                                child: Container(
                                  height: 110.h,
                                  width: 102.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: Colors.white),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        AssetsPath.donationIconPNG,
                                        height: 32.h,
                                        width: 32.w,
                                      ),
                                      SizedBox(height: 8.h),
                                      Text(
                                        'donation2'.tr,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: AppColors.colorBlackHighEmp,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // ----Islamic Ai Screen ---- //
                              GestureDetector(
                                onTap: () {
                                  Get.back();
                                  Get.to(() => const ChatScreen());
                                },
                                child: Container(
                                  height: 110.h,
                                  width: 102.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: Colors.white),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        AssetsPath.IslamicAiIconPNG,
                                        height: 32.h,
                                        width: 32.w,
                                      ),
                                      SizedBox(height: 8.h),
                                      Text(
                                        'islamic_ai'.tr,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: AppColors.colorBlackHighEmp,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              // ---- Prayer time Screen ---- //
                              GestureDetector(
                                onTap: () {
                                  Get.back();
                                  Get.to(() => const PrayerTimeScreen());
                                },
                                child: Container(
                                  height: 110.h,
                                  width: 102.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: Colors.white),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        AssetsPath.adhanIconPNG,
                                        height: 32.h,
                                        width: 32.w,
                                      ),
                                      SizedBox(height: 8.h),
                                      Text(
                                        'prayer_time'.tr,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: AppColors.colorBlackHighEmp,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              // ---- Qibla Screen ---- //
                              GestureDetector(
                                onTap: () {
                                  Get.back();
                                  Get.to(() => const CompassScreen());
                                },
                                child: Container(
                                  height: 110.h,
                                  width: 102.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: Colors.white),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        AssetsPath.qiblaCompusIconPNG,
                                        height: 32.h,
                                        width: 32.w,
                                      ),
                                      SizedBox(height: 8.h),
                                      Text(
                                        'qibla_compass'.tr,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            height: 0.9,
                                            color: AppColors.colorBlackHighEmp,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // ---- Zakat calculator Screen ---- //
                              GestureDetector(
                                onTap: () {
                                  Get.back();
                                  Get.to(() => const ZakatCalculator());
                                },
                                child: Container(
                                  height: 110.h,
                                  width: 102.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: Colors.white),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        AssetsPath.zakatIconPNG,
                                        height: 32.h,
                                        width: 32.w,
                                      ),
                                      SizedBox(height: 8.h),
                                      Text(
                                        'jakat_calculator'.tr,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          height: 0.9,
                                            color: AppColors.colorBlackHighEmp,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              // ---- Baby Name Screen ---- //
                              GestureDetector(
                                onTap: () {
                                  Get.back();
                                  Get.to(() => const IslamicBabyNameScreen());
                                },
                                child: Container(
                                  height: 110.h,
                                  width: 102.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: Colors.white),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        AssetsPath.BabyNameIconPNG,
                                        height: 32.h,
                                        width: 32.w,
                                      ),
                                      SizedBox(height: 8.h),
                                      Text(
                                        'baby_name'.tr,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            height: 0.9,
                                            color: AppColors.colorBlackHighEmp,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              // ---- Baby Name Screen ---- //
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => MakkahLiveScreen()));
                                },
                                child: Container(
                                  height: 110.h,
                                  width: 102.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: Colors.white),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        AssetsPath.makkaIconPNG,
                                        height: 32.h,
                                        width: 32.w,
                                      ),
                                      SizedBox(height: 8.h),
                                      Text(
                                        'makka_live'.tr,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: AppColors.colorBlackHighEmp,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // ---- Azkar Screen ---- //
                              GestureDetector(
                                onTap: () {
                                  getCategories('azkar-categories', 'AZKAR');
                                },
                                child: Container(
                                  height: 110.h,
                                  width: 102.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: Colors.white),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        AssetsPath.azkarIconPNG,
                                        height: 32.h,
                                        width: 32.w,
                                      ),
                                      SizedBox(height: 8.h),
                                      Text(
                                        'azkar'.tr,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: AppColors.colorBlackHighEmp,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              // ---- Islamic calender Screen ---- //
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => HijriDatePickerDialog(
                                    initialDate: HijriCalendar.now(),  // Set the initial date within the range 1455 to 1555
                                    firstDate: HijriCalendar.addMonth(1356, 1),
                                    lastDate: HijriCalendar.addMonth(1499, 1), // Set the last date to one year from now or adjust as needed
                                    initialDatePickerMode: DatePickerMode.day,
                                  )));
                                },
                                child: Container(
                                  height: 110.h,
                                  width: 102.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: Colors.white),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        AssetsPath.calenderIconPNG,
                                        height: 32.h,
                                        width: 32.w,
                                      ),
                                      SizedBox(height: 8.h),
                                      Text(
                                        'islamic_calender'.tr,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            height: 0.9,
                                            color: AppColors.colorBlackHighEmp,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              // ---- Azkar Screen ---- //
                              GestureDetector(
                                onTap: () {
                                  Get.back();
                                  Get.to(() => const MosqueLocationScreen());
                                },
                                child: Container(
                                  height: 110.h,
                                  width: 102.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: Colors.white),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        AssetsPath.mosqueIconPNG,
                                        height: 32.h,
                                        width: 32.w,
                                      ),
                                      SizedBox(height: 8.h),
                                      Text(
                                        'mosque_location'.tr,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            height: 0.9,
                                            color: AppColors.colorBlackHighEmp,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // ---- Preferences Screen ---- //
                              InkWell(
                                onTap: () {
                                  Get.back();
                                  Get.to(() => const PreferenceScreen());
                                },
                                child: Container(
                                  height: 110.h,
                                  width: 102.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: Colors.white),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        AssetsPath.preferencesIconPNG,
                                        height: 32.h,
                                        width: 32.w,
                                      ),
                                      SizedBox(height: 8.h),
                                      Text(
                                        'preference'.tr,
                                        style: TextStyle(
                                            color: AppColors.colorBlackHighEmp,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              // ---- Edit Profile Screen ---- //
                              InkWell(
                                onTap: () async{
                                  Get.back();
                                  provider.userData!.thumbnailUrl == 'Null'?
                                  showCustomAlertDialog(context) : Get.to(() => EditProfileScreen());
                                },
                                child: Container(
                                  height: 110.h,
                                  width: 102.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: Colors.white),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        AssetsPath.accountIconPNG,
                                        height: 32.h,
                                        width: 32.w,
                                      ),
                                      SizedBox(height: 8.h),
                                      Text(
                                        textAlign: TextAlign.center,
                                        'edit_profile'.tr,
                                        style: TextStyle(
                                            height: 0.9,
                                            color: AppColors.colorBlackHighEmp,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              // ---- Logout Screen ---- //
                              provider.userDataLoading || provider.userData!.thumbnailUrl == 'Null'?
                              InkWell(
                                onTap: () async {
                                  Get.offAll(SignInScreen(isParent: true));
                                },
                                child: Container(
                                  height: 110.h,
                                  width: 102.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: Colors.white),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                          Icons.login,
                                        size: 28.h,
                                        color: AppColors.colorPrimary,
                                      ),
                                      SizedBox(height: 8.h),
                                      Text(
                                        'sign_in'.tr,
                                        style: TextStyle(
                                            color: AppColors.colorBlackHighEmp,
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w600),
                                      )
                                    ],
                                  ),
                                ),
                              ) :  InkWell(
                                onTap: () async {
                                  // Clear token value
                                  await AuthController.clearTokenValue();
                                  // Navigate to sign in screen
                                  Get.offAll(
                                          () => SignInScreen(isParent: true));
                                },
                                child: Container(
                                  height: 110.h,
                                  width: 102.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: Colors.white),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        AssetsPath.logoutIconPNG,
                                        height: 32.h,
                                        width: 32.w,
                                      ),
                                      SizedBox(height: 8.h),
                                      Text(
                                        'logout'.tr,
                                        style: TextStyle(
                                            color: AppColors.colorBlackHighEmp,
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w600),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Get category method
  getCategories(String categoryName, String cateSign) {
    if (cateSign == 'HADITH') {
      Get.back();
      Get.to(() => ReusableCategoryListScreen(
            categoryTitle: 'hadith',
            iconPath: AssetsPath.hadithIconSVG,
            categoryName: categoryName,
            cateSign: cateSign,
          ));
    } else {
      if (cateSign == 'DUA') {
        Get.back();
        Get.to(() => ReusableCategoryListScreen(
              categoryTitle: 'dua',
              iconPath: AssetsPath.duaIconSVG,
              categoryName: categoryName,
              cateSign: cateSign,
            ));
      } else {
        if (cateSign == 'AL-QURAN') {
          Get.back();
          Get.to(() => ReusableCategoryListScreen(
                categoryTitle: 'alquran',
                iconPath: AssetsPath.quranIconSVG,
                categoryName: categoryName,
                cateSign: cateSign,
              ));
        } else {
          if (cateSign == 'AZKAR') {
            Get.back();
            Get.to(() => ReusableCategoryListScreen(
                  categoryTitle: 'azkar',
                  iconPath: AssetsPath.duaIconSVG,
                  categoryName: categoryName,
                  cateSign: cateSign,
                ));
          } else {
            if (cateSign == 'EVENT-PRAYERS') {
              Get.back();
              Get.to(() => ReusableCategoryListScreen(
                    categoryTitle: 'event_prayers',
                    iconPath: AssetsPath.duaIconSVG,
                    categoryName: categoryName,
                    cateSign: cateSign,
                  ));
            }
          }
        }
      }
    }
  }

  //Fetch Zikir from json
  List _zikir = [];
  Future<void> readJson() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? language = prefs.getString('language');
    print(language);
    String jsonAssetPath = 'assets/locales/zikir_ar.json';
    if (language == 'en') {
      jsonAssetPath = 'assets/locales/zikir_en.json';
    } else if (language == 'ar') {
      jsonAssetPath = 'assets/locales/zikir_ar.json';
    }

    final String response = await rootBundle.loadString(jsonAssetPath);
    final data = await json.decode(response);
    setState(() {
      _zikir = data['data'];
    });
  }

  //Home screen appBar widget
  Widget appBar() {
    return Padding(
        padding: const EdgeInsets.only(
            left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
        child: Consumer<UserProvider>(
          builder: (context, userProvider, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    userProvider.userDataLoading
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(100.0),
                            child: Image.asset(
                              "assets/images/avater.png",
                              height: 46.h,
                            ),
                          )
                        : userProvider.userData!.thumbnailUrl == 'Null' || userProvider.userData!.thumbnailUrl!.isEmpty
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(100.0),
                                child: Image.asset(
                                  "assets/images/avater.png",
                                  height: 46.h,
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(100.0),
                                child: Container(
                                  height: 46.h,
                                  width: 46.h,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: Colors.white),
                                  child: Image.network(
                                    userProvider.userData!.thumbnailUrl!,
                                    fit: BoxFit.cover,
                                    height: 46.h,
                                    width: 46.h,
                                  ),
                                ),
                              ),
                    SizedBox(width: 12.w),
                    InkWell(
                      onTap: (){
                        print("jgjufhfu");
                        Get.to(PlatformCheckPage());
                      },
                      child: SizedBox(
                        width: 150.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'assalamu_alaikum'.tr,
                              style: TextStyle(
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.orange,
                                  height: 0.9),
                            ),
                            Text(
                              userProvider.userDataLoading
                                  ? "........"
                                  : userProvider.userData!.fullName!,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w300,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ));
  }

  //CarouselSlider Widget
  Widget slider(){
    return CarouselSlider(
      items: [
        Container(
          height: 50.h,
          width: double.infinity,
          margin: const EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: Colors.transparent,
            image: const DecorationImage(
              image: AssetImage("assets/images/banner_one.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'b_one_header'.tr,
                  style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.colorBlackMidEmp,
                      height: 3
                  ),
                ),
                Text(
                  'b_one_title'.tr,
                  style: GoogleFonts.caprasimo(
                    textStyle: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        height: 0.9
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: (){
                        Get.to(() => const ReusableTasbihCounterScreen(data: '',));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColors.colorPrimary
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
                            child: Text(
                              'b_one_btn'.tr,
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        Container(
          height: 50.h,
          margin: const EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: Colors.transparent,
            image: const DecorationImage(
              image: AssetImage("assets/images/banner_two.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'b_two_header'.tr,
                  style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 3
                  ),
                ),
                Text(
                  'b_two_title'.tr,
                  style: GoogleFonts.caprasimo(
                    textStyle: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 0.9
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: (){
                        getCategories('dua-categories', 'AL-QURAN');
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColors.indicatorColor
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
                            child: Text(
                              'b_two_btn'.tr,
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        Container(
          height: 50.h,
          margin: const EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: Colors.transparent,
            image: const DecorationImage(
              image: AssetImage("assets/images/banner_three.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'b_three_header'.tr,
                  style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 3
                  ),
                ),
                Text(
                  'b_three_title'.tr,
                  style: GoogleFonts.caprasimo(
                    textStyle: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 0.9
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: (){
                        Get.to(() => const AllWallPapersScreen());
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColors.indicatorColor
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
                            child: Text(
                              'b_three_btn'.tr,
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ],
      options: CarouselOptions(
          height: 150.0,
          enlargeCenterPage: true,
          autoPlay: true,
          aspectRatio: 16 / 9,
          autoPlayCurve: Curves.fastOutSlowIn,
          enableInfiniteScroll: true,
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          viewportFraction: 0.95,
          onPageChanged: (index, reason){
            setState(() {
              _currentPage = index;
            });
          }
      ),
    );
  }

  int _currentPage = 0;
  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < 3; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      margin: const EdgeInsets.symmetric(horizontal: 2.0),
      height: 7.0,
      width: isActive ? 18.0 : 8.0,
      decoration: BoxDecoration(
        color: isActive ? AppColors.colorGradient5End : Colors.grey,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  //Home screen counter summery bar graph
  Widget summeryWidget(){
    return Stack(
      children: [
        Container(
          height: 220.h,
          width: 200.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: AppColors.shadowColor,
                spreadRadius: -2.0,
                blurRadius: 4,
                offset: Offset(0, 1), // changes position of shadow
              ),
            ],
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: InkWell(
                onTap: () {
                  Get.to(const SummaryScreen());
                },
                child: Container(
                  height: 180.h,
                  width: 200.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    gradient: const LinearGradient(
                      colors: [
                        AppColors.colorGradient2Start,
                        AppColors.colorGradient2End
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'weekly_counter'.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'last_week'.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.colorAlert,
                          fontSize: 12.sp,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      FutureBuilder<List<int>>(
                        future: ZikirProvider().getLast7DaysTotalCounts(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final last7DaysTotalCounts = snapshot.data!;
                            //final weeklySummary = last7DaysTotalCounts?.map((count) => count.toDouble()).toList();
                            return SizedBox(
                                height: 80.h,
                                width: 187.w,
                                child: BarGraph(
                                  weeklySummary: last7DaysTotalCounts
                                      .map((count) => count != null
                                          ? (count > 1000
                                              ? 1000.0
                                              : count.toDouble())
                                          : 0.0)
                                      .toList(),
                                ));
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text('Error: ${snapshot.error}'),
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 8.h),
            Align(
              alignment: Alignment.bottomCenter,
              child: InkWell(
                onTap: () {
                  Get.to(const ReusableTasbihCounterScreen(data: ''));
                },
                child: Row(
                  children: [
                    Text('counter'.tr,
                        style: TextStyle(
                            fontSize: 16.sp, color: AppColors.colorPrimary)),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Icon(
                        Icons.arrow_circle_right,
                        size: 24.sp,
                        color: AppColors.colorPrimary,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  //Home screen zikir list
  Widget zikirListWidget(){
    return Container(
      height: 220.h,
      width: 120.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [
            AppColors.colorGradient2Start,
            AppColors.colorGradient2End
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowColor,
            spreadRadius: 0,
            blurRadius: 4,
            offset: Offset(
                0, 2), // changes position of shadow
          ),
        ],
      ),
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: _zikir.length,
        itemBuilder:
            (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              Get.to(ReusableTasbihCounterScreen(data: _zikir[index]["phrase"]));
            },
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 12.0, right: 12.0),
              child: Container(
                height: 75.h,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                        width: 1.0,
                        color: Colors.grey),
                  ),
                ),
                child: Column(
                  mainAxisAlignment:
                  MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '#${index + 1}',
                      style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight:
                          FontWeight.w700,
                          color:
                          AppColors.colorAlert),
                    ),
                    Text(
                      _zikir[index]["phrase"],
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.sp),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  //Home screen menu list
  Widget homeMenuWidget(){
    final provider = Provider.of<UserProvider>(context, listen: false);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // ---- Tasbih Screen ---- //
            GestureDetector(
              onTap: () {
                Get.to(() => const ReusableTasbihCounterScreen(data: '',));
              },
              child: Container(
                height: 110.h,
                width: 102.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.shadowColor,
                      spreadRadius: -2.0,
                      blurRadius: 4,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AssetsPath.tasbihCounterIconPNG,
                      height: 32.h,
                      width: 32.w,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'tasbih'.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColors.colorBlackHighEmp,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
            ),
            // ---- Hadith Screen ---- //
            GestureDetector(
              onTap: () {
                getCategories('hadith-categories', 'HADITH');
              },
              child: Container(
                height: 110.h,
                width: 102.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.shadowColor,
                      spreadRadius: -2.0,
                      blurRadius: 4,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AssetsPath.hadithIconPNG,
                      height: 32.h,
                      width: 32.w,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'hadith'.tr,
                      style: TextStyle(
                          color: AppColors.colorBlackHighEmp,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
            ),
            // ---- Dua Screen ---- //
            GestureDetector(
              onTap: () {
                getCategories('dua-categories', 'DUA');
              },
              child: Container(
                height: 110.h,
                width: 102.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.shadowColor,
                      spreadRadius: -2.0,
                      blurRadius: 4,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AssetsPath.duaIconPNG,
                      height: 32.h,
                      width: 32.w,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'dua'.tr,
                      style: TextStyle(
                          color: AppColors.colorBlackHighEmp,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // ---- Al-Quran Screen Screen ---- //
            GestureDetector(
              onTap: () {
                getCategories('dua-categories', 'AL-QURAN');
              },
              child: Container(
                height: 110.h,
                width: 102.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.shadowColor,
                      spreadRadius: -2.0,
                      blurRadius: 4,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AssetsPath.alQuranIconPNG,
                      height: 32.h,
                      width: 32.w,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'alquran'.tr,
                      style: TextStyle(
                          color: AppColors.colorBlackHighEmp,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
            ),
            // ---- Wallpaper Screen ---- //
            GestureDetector(
              onTap: () {
                Get.to(() => const AllWallPapersScreen());
              },
              child: Container(
                height: 110.h,
                width: 102.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.shadowColor,
                      spreadRadius: -2.0,
                      blurRadius: 4,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AssetsPath.wallpaperIconPNG,
                      height: 32.h,
                      width: 32.w,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'wallpaper'.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColors.colorBlackHighEmp,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
            ),
            // ---- Donation Screen ---- //
            GestureDetector(
              onTap: () async{
                provider.userData!.thumbnailUrl == 'Null'?
                showCustomAlertDialog(context)
                    :
                Get.to(() =>
                const SubscriptionAndDonationScreen());
              },
              child: Container(
                height: 110.h,
                width: 102.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.shadowColor,
                      spreadRadius: -2.0,
                      blurRadius: 4,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AssetsPath.donationIconPNG,
                      height: 32.h,
                      width: 32.w,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'donation2'.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColors.colorBlackHighEmp,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  //Home screen prayer time widget
  Widget homePrayerTimeWidget(){
    return Consumer<LocationProvider>(
        builder: (context, provider, child){
          return Stack(
            children: [
              Container(
                height: 370.h,
                width: 328.w,
                decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.circular(24),
                  color: AppColors.colorGradient4Start,
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.shadowColor,
                      spreadRadius: -2.0,
                      blurRadius: 4,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            height: 290.h,
                            width: 328.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              gradient: const LinearGradient(
                                colors: [
                                  AppColors.colorGradient2Start,
                                  AppColors.colorGradient2End
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: AppColors.shadowColor,
                                  spreadRadius: -2.0,
                                  blurRadius: 4,
                                  offset: Offset(0, 1), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 70.h,
                                      width: 50.w,
                                      child: Image.asset(
                                        "assets/images/lamp01.png",
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(top: 12.0,left: 8.0,right: 8.0),
                                      child: Container(
                                        height: 40.h,
                                        width: 200.w,
                                        constraints: BoxConstraints(maxWidth: 350.w),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(50),
                                            color: AppColors.colorPrimaryDarker
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(top: 2.0,right: 5.0),
                                              child: Icon(
                                                Icons.location_on,
                                                color: AppColors.colorPrimaryLighter,
                                                size: 16.sp,
                                              ),
                                            ),
                                            provider.locationName == ''?
                                            SizedBox(
                                              width: 150,
                                              child: Center(
                                                child: Text(
                                                  'loading.....',
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: AppColors.colorPrimaryLighter,
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 14.sp
                                                  ),
                                                ),
                                              ),
                                            ):
                                            SizedBox(
                                              width: 150,
                                              child: Text(
                                                provider.locationName,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: AppColors.colorPrimaryLighter,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14.sp
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 60.h,
                                      width: 40.w,
                                      child: Image.asset(
                                        "assets/images/lamp01.png",
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: Text(
                                    'prayer_time'.tr,
                                    style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white
                                    ),
                                  ),
                                ),
                                Text(
                                  DateFormat(
                                      'd\'${provider.getDaySuffix(DateTime.now().day)}\' MMMM y')
                                      .format(DateTime.now()),
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      color: AppColors.colorAlert
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: 120.h,
                                        width: 60.w,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.white),
                                            borderRadius: BorderRadius.circular(16),
                                            color: Colors.transparent
                                        ),
                                        child: Column(
                                          children: [
                                            if (provider.prayerTimes!.isNotEmpty)
                                              Padding(
                                                padding: const EdgeInsets.only(top: 8.0, left: 12.0, right: 12.0, bottom: 0.0),
                                                child: Text(
                                                  provider.formatPrayerTime(provider.prayerTimes![0].fajr),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14.sp
                                                  ),
                                                ),
                                              ),
                                            SizedBox(height: 4.h),
                                            SvgPicture.asset(
                                              "assets/images/fajr_icon.svg",
                                              height: 18.h,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(4.0),
                                              child: Text(
                                                'fajr'.tr,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w600
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 120.h,
                                        width: 60.w,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.white),
                                            borderRadius: BorderRadius.circular(16),
                                            color: Colors.transparent
                                        ),
                                        child: Column(
                                          children: [
                                            if (provider.prayerTimes!.isNotEmpty)
                                              Padding(
                                                padding: const EdgeInsets.only(top: 8.0, left: 12.0, right: 12.0, bottom: 0.0),
                                                child: Text(
                                                  provider.formatPrayerTime(provider.prayerTimes![0].dhuhr),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14.sp
                                                  ),
                                                ),
                                              ),
                                            SizedBox(height: 4.h),
                                            SvgPicture.asset(
                                              "assets/images/duhr_icon.svg",
                                              height: 18.h,
                                            ),
                                            Padding(
                                              padding:
                                              const EdgeInsets.all(4.0),
                                              child: Text(
                                                'duhr'.tr,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w600
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 120.h,
                                        width: 60.w,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.white),
                                            borderRadius:
                                            BorderRadius.circular(16),
                                            color: Colors.transparent
                                        ),
                                        child: Column(
                                          children: [
                                            if (provider.prayerTimes!.isNotEmpty)
                                              Padding(
                                                padding: const EdgeInsets.only(top: 8.0, left: 12.0, right: 12.0, bottom: 0.0),
                                                child: Text(
                                                  provider.formatPrayerTime(provider.prayerTimes![0].asr),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14.sp
                                                  ),
                                                ),
                                              ),
                                            SizedBox(height: 4.h),
                                            SvgPicture.asset(
                                              "assets/images/asr_icon.svg",
                                              height: 18.h,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(4.0),
                                              child: Text(
                                                'asr'.tr,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w600
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 120.h,
                                        width: 60.w,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.white),
                                            borderRadius: BorderRadius.circular(10),
                                            color: Colors.transparent
                                        ),
                                        child: Column(
                                          children: [
                                            if (provider.prayerTimes!.isNotEmpty)
                                              Padding(
                                                padding: const EdgeInsets.only(top: 8.0, left: 12.0, right: 12.0, bottom: 0.0),
                                                child: Text(
                                                  provider.formatPrayerTime(provider.prayerTimes![0].maghrib),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color:
                                                      Colors.white,
                                                      fontSize: 14.sp
                                                  ),
                                                ),
                                              ),
                                            SizedBox(height: 4.h),
                                            SvgPicture.asset(
                                              "assets/images/magrib_icon.svg",
                                              height: 18.h,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(4.0),
                                              child: Text(
                                                'magrib'.tr,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w600
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 120.h,
                                        width: 60.w,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.white),
                                            borderRadius: BorderRadius.circular(10),
                                            color: Colors.transparent
                                        ),
                                        child: Column(
                                          children: [
                                            if (provider.prayerTimes!.isNotEmpty)
                                              Padding(
                                                padding: const EdgeInsets.only(top: 8.0, left: 12.0, right: 12.0, bottom: 0.0),
                                                child: Text(
                                                  provider.formatPrayerTime(provider.prayerTimes![0].isha),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14.sp
                                                  ),
                                                ),
                                              ),
                                            SizedBox(height: 4.h),
                                            SvgPicture.asset(
                                              "assets/images/isha_icon.svg",
                                              height: 18.h,
                                            ),
                                            Padding(
                                              padding:
                                              const EdgeInsets.all(
                                                  4.0),
                                              child: Text(
                                                'isha'.tr,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w600
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/images/asr_icon.svg",
                          height: 28.h,
                        ),
                        if (provider.prayerTimes!.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'sun_set'.tr,
                                  style: const TextStyle(
                                      color: AppColors.colorAlert
                                  ),
                                ),
                                Text(
                                  provider.formatPrayerTime(provider.prayerTimes![0].maghrib),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.sp
                                  ),
                                )
                              ],
                            ),
                          ),
                        SizedBox(width: 30.h),
                        SvgPicture.asset(
                          "assets/images/fajr_icon.svg",
                          height: 28.h,
                        ),
                        if (provider.prayerTimes!.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'sun_rise'.tr,
                                  style: const TextStyle(
                                      color: AppColors.colorAlert),
                                ),
                                Text(
                                  provider.formatPrayerTime(provider.prayerTimes![0].fajr.subtract(const Duration(minutes: 3))),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.sp
                                  ),
                                )
                              ],
                            ),
                          ),
                      ],
                    )
                  ],
                ),
              ),
              provider.initPosition == null? Center(
                  child: Container(
                    margin: EdgeInsets.all(16.w),
                    height: 330.h,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'unable'.tr,
                            style: const TextStyle(
                                color: Colors.white),
                          ),
                          Text(
                              'turn_on_device_location'.tr,
                            style: const TextStyle(
                                color: Colors.white,
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              Provider.of<LocationProvider>(context, listen: false).getLocation();
                            },
                              child: Container(
                                height: 100,
                                width: 100,
                                padding: EdgeInsets.only(top: 30),
                                //color: Colors.white,
                                child: Icon(
                                    Icons.refresh,
                                  color: Colors.white,
                                ),
                              )
                          )
                        ],
                      ),
                    ),
                  ),
              ) : SizedBox(),
            ],
          );
        }
    );
  }

  //Random Hadith Widget
  Widget randomHadithWidget(){
    return Consumer<HadithProvider>(
      builder: (context, hadithProvider, child){
        return InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => const TodayHadithScreen()));
          },
          child: Container(
            height: 210.h,
            width: double.infinity,
            margin: const EdgeInsets.only(top: 10.0),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: AssetImage(
                    AssetsPath.hadithBackgroundPNG
                ),
                fit: BoxFit.fill,
              ),
            ),
            child: hadithProvider.randomHadithIndex == -1?
            const Center(child: Text("")) :
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  hadithProvider.allHadith![hadithProvider.randomHadithIndex].hadithArabic!,
                  maxLines: 3,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16.sp,
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
                  maxLines: 3,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14.sp,
                      overflow: TextOverflow.ellipsis,
                      color: Colors.white
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  //Random Dua Widget
  Widget randomDuaWidget(){
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => const TodayDuaScreen()));
      },
      child: Consumer<HadithProvider>(
          builder: (context, duaProvider, child){
            return Container(
              height: 240.h,
              width: double.infinity,
              margin: const EdgeInsets.only(top: 10.0),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: AssetImage(
                      AssetsPath.duaBackgroundPNG
                  ),
                  fit: BoxFit.fill,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 50.h,),
                  Text(
                    "today_dua".tr,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp
                    ),
                  ),
                  SizedBox(height: 20.h,),
                  duaProvider.randomDuaIndex == -1?
                  const Center(child: Text("")) :
                  Text(
                    duaProvider.language == 'ar'?
                    duaProvider.allDua![duaProvider.randomDuaIndex].duaArabic! :
                    duaProvider.language == 'en'?
                    duaProvider.allDua![duaProvider.randomDuaIndex].duaEnglish! :
                    duaProvider.language == 'ur'?
                    duaProvider.allDua![duaProvider.randomDuaIndex].duaUrdu! :
                    duaProvider.allDua![duaProvider.randomDuaIndex].duaTurkish!,
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    style: TextStyle(
                        fontSize: 14.sp,
                        overflow: TextOverflow.ellipsis,
                        color: Colors.white
                    ),
                  ),
                ],
              ),
            );
          }
      ),
    );
  }

  //Name generating banner widget
  Widget nameBannerWidget(){
    return Container(
      height: 160.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: Colors.transparent,
        image: const DecorationImage(
          image: AssetImage("assets/images/name_banner.png"),
          fit: BoxFit.fill,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'name_header'.tr,
              style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  height: 3
              ),
            ),
            Text(
              'name_title'.tr,
              style: GoogleFonts.caprasimo(
                textStyle: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 0.9
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    Get.to(() => const IslamicBabyNameScreen());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(20),
                        color: AppColors.colorAlert),
                    child: Center(
                      child: Padding(
                        padding:
                        const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 8.0),
                        child: Text(
                          'name_btn'.tr,
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.white,
                              fontWeight:
                              FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  //Account creation successful popup method
  void showCustomAlertDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return SignInRequiredDialog(
          title: 'sign_in_required'.tr,
          message: 'please_sign_in_first'.tr,
          onContinuePressed: () {
            Get.offAll(() => SignInScreen(isParent: true));
            print('Sign Up successful');
          },
        );
      },
    );
  }

}
