import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../application/utility/colors.dart';

class QiblahScreen extends StatefulWidget {
  const QiblahScreen({Key? key}) : super(key: key);

  @override
  State<QiblahScreen> createState() => _QiblahScreenState();
}

Animation<double>? animation;
AnimationController? _animationController;
double begin = 0.0;

class _QiblahScreenState extends State<QiblahScreen> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    animation = Tween(begin: 0.0, end: 0.0).animate(_animationController!);
    super.initState();
  }

  @override
  void dispose() {
    // Dispose of the AnimationController
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                  padding: const EdgeInsets.only(top: 14),
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
                        "qibla_compass2".tr,
                        style: TextStyle(
                          color: AppColors.colorWhiteHighEmp,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 100.h),
                StreamBuilder(
                  stream: FlutterQiblah.qiblahStream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                        alignment: Alignment.center,
                        child: const CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      );
                    } else if (snapshot.hasData) {
                      // Check if snapshot has data
                      final qiblahDirection = snapshot.data;
                      animation = Tween(
                        begin: begin,
                        end: (qiblahDirection!.qiblah * (pi / 180) * -1),
                      ).animate(_animationController!);

                      begin = (qiblahDirection.qiblah * (pi / 180) * -1);

                      if (!_animationController!.isAnimating) {
                        _animationController?.forward(from: 0);
                      }

                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              ("rotate".tr),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                              ),
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              "${qiblahDirection.direction.toInt()}°",
                              style: TextStyle(
                                color: AppColors.colorButtonGradientEnd,
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 24.h),
                            SizedBox(
                              height: 280.h,
                              child: AnimatedBuilder(
                                animation: animation!,
                                builder: (context, child) => Transform.rotate(
                                  angle: animation!.value,
                                  child: Image.asset('assets/images/compass2.png'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      // Handle no data scenario
                      return const Center(
                        child: Text(
                          'Unable to get Qiblah direction',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
