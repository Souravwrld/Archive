import 'package:adhan/adhan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:JazakAllah/presentation/state_holders/Providers/location_provider.dart';
import 'package:JazakAllah/presentation/state_holders/Providers/notification_provider.dart';
import 'dart:io';

import '../../../application/utility/colors.dart';

class PrayerTimeScreen extends StatefulWidget {
  const PrayerTimeScreen({Key? key})
      : super(key: key);

  @override
  State<PrayerTimeScreen> createState() => _PrayerTimeScreenState();
}

class _PrayerTimeScreenState extends State<PrayerTimeScreen> {
  bool hasPermission = false;

  Future<void> getPermission() async {
    if (await Permission.location.serviceStatus.isEnabled) {
      final status = await Permission.location.request();
      setState(() {
        hasPermission = (status == PermissionStatus.granted);
      });
    }
  }


  @override
  void initState() {
    super.initState();
  }


  String _formatPrayerTime(DateTime time) {
    return DateFormat.jm().format(time);
  }

  bool switchValue = false;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocationProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.colorPrimaryLight,
        iconTheme: const IconThemeData(color: Colors.white),
        titleSpacing: -2,// Set your desired color here
        title: Text(
          'prayer_times'.tr,
          style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: double.maxFinite,
            decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/secondary_background.png"),
                  fit: BoxFit.fill,
                )),
            child: Stack(
              children: <Widget>[
                SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 20.h),
                      Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            height: 420.h,
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
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20),
                                  child: Text(
                                    DateFormat('EEEE, d MMMM, yyyy').format(DateTime.now()),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20.0, left: 16.0, right: 16),
                                  child: Container(
                                    height: 50.h,
                                    width: 296.w,
                                    padding: const EdgeInsets.symmetric(horizontal: 12),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(color: Colors.white),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width:60.w,
                                          child: Text(
                                            'fajr'.tr,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500
                                            ),
                                          ),
                                        ),
                                        Text(
                                          provider.formatPrayerTime(provider.prayerTimes![0].fajr.subtract(const Duration(minutes: 3))),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SvgPicture.asset(
                                          "assets/images/fajr_icon.svg",
                                          height: 18.h,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 14.0, left: 16.0, right: 16),
                                  child: Container(
                                    height: 50.h,
                                    width: 296.w,
                                    padding: const EdgeInsets.symmetric(horizontal: 12),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(color: Colors.white),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 60.w,
                                          child: Text(
                                            'duhr'.tr,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          provider.formatPrayerTime(provider.prayerTimes![0].dhuhr.subtract(const Duration(minutes: 3))),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SvgPicture.asset(
                                          "assets/images/duhr_icon.svg",
                                          height: 18.h,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 14.0, left: 16.0, right: 16),
                                  child: Container(
                                    height: 50.h,
                                    width: 296.w,
                                    padding: const EdgeInsets.symmetric(horizontal: 12),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(color: Colors.white),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 60.w,
                                          child: Text(
                                            'asr'.tr,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          provider.formatPrayerTime(provider.prayerTimes![0].asr.subtract(const Duration(minutes: 3))),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SvgPicture.asset(
                                          "assets/images/asr_icon.svg",
                                          height: 18.h,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 14.0, left: 16.0, right: 16),
                                  child: Container(
                                    height: 50.h,
                                    width: 296.w,
                                    padding: const EdgeInsets.symmetric(horizontal: 12),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(color: Colors.white)
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width:60.w,
                                          child: Text(
                                            'magrib'.tr,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          provider.formatPrayerTime(provider.prayerTimes![0].maghrib.subtract(const Duration(minutes: 3))),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SvgPicture.asset(
                                          "assets/images/magrib_icon.svg",
                                          height: 18.h,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 14.0, left: 16.0, right: 16),
                                  child: Container(
                                    height: 50.h,
                                    width: 296.w,
                                    padding: const EdgeInsets.symmetric(horizontal: 12),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(color: Colors.white),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width:60.w,
                                          child: Text(
                                            'isha'.tr,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Text(
                                          provider.formatPrayerTime(provider.prayerTimes![0].isha.subtract(const Duration(minutes: 3))),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SvgPicture.asset(
                                          "assets/images/isha_icon.svg",
                                          height: 18.h,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                      SizedBox(height: 20.h),
                      Consumer<LocationProvider>(
                          builder: (context, provider, child){
                            return Container(
                              width: 328.w,
                              margin: const EdgeInsets.only(bottom: 40.0),
                              padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20),
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
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'notification'.tr,
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'fajr'.tr,
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      Switch(
                                        activeColor: Colors.white,
                                        activeTrackColor: AppColors.colorPrimary,
                                        value: provider.fajrNotification!,
                                        onChanged: (value) {
                                          provider.settingNotification('fajr');
                                        },
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'duhr'.tr,
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      Switch(
                                        activeColor: Colors.white,
                                        activeTrackColor: AppColors.colorPrimary,
                                        value: provider.dhuharNotification!,
                                        onChanged: (value) {
                                          provider.settingNotification('dhuhr');
                                        },
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'asr'.tr,
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      Switch(
                                        activeColor: Colors.white,
                                        activeTrackColor: AppColors.colorPrimary,
                                        value: provider.asrNotification!,
                                        onChanged: (value) {
                                          provider.settingNotification('asr');
                                        },
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'magrib'.tr,
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      Switch(
                                        activeColor: Colors.white,
                                        activeTrackColor: AppColors.colorPrimary,
                                        value: provider.maghribNotification!,
                                        onChanged: (value) {
                                          provider.settingNotification('maghrib');
                                        },
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'isha'.tr,
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      Switch(
                                        activeColor: Colors.white,
                                        activeTrackColor: AppColors.colorPrimary,
                                        value: provider.ishaNotification!,
                                        onChanged: (value) {
                                          provider.settingNotification('isha');
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }
                      )
                    ],
                  ),
                ),

                /*Positioned(
                          top: 0.h,
                          left: 16.w,
                          right: 16.w,
                          child: Container(
                            height: 30.h,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.only(left: 12.0, right: 12),
                                  child: Text(
                                    'prayer_times'.tr,
                                    style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          )),*/

              ],
            ),
          ),
          provider.initPosition == null?
          Container(
            height: double.maxFinite,
            decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/secondary_background.png"),
                  fit: BoxFit.fill,
                )),
            child: Center(
              child: Container(
                height: 300.h,
                width: 300.w,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 50.h,
                      color: Colors.red,
                    ),
                    SizedBox(height: 10.h),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center, // Align children along the main axis (vertically)
                      crossAxisAlignment: CrossAxisAlignment.center, // Align children along the cross axis (horizontally)
                      children: [
                        Text(
                          'unable'.tr,
                          style: const TextStyle(
                              color: Colors.black),
                        ),
                        Text(
                          'turn_on'.tr,
                          style: const TextStyle(
                              color: Colors.black),
                        ),
                        SizedBox(height: 10.h),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            'access'.tr,
                            style: const TextStyle(
                                color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SizedBox(
                        height: 50.h,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.arrow_back,
                              size: 14,
                              color: Colors.red,
                            ),
                            Text(
                              'go_back'.tr,
                              style: const TextStyle(color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ) :
          const SizedBox()
        ],
      ),
    );
  }
}
