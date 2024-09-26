import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../application/utility/colors.dart';
import '../../Bar Graph/bar_graph.dart';
import '../../state_holders/Providers/counter_provider.dart';

class SummaryScreen extends StatefulWidget {
  const SummaryScreen({Key? key}) : super(key: key);

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  final PageController _pageController = PageController(initialPage: 1);


  List<String> leftNumbers = ['1000', '800', '600', '400', '200', '0'];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        SvgPicture.asset(
          'assets/images/background02.svg',
          // Replace with your image asset path
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
        Column(
          children: [
            SizedBox(height: 120.h),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                child: Container(
                  height: 340.h,
                  width: double.infinity,
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            DateFormat('yyyy/MM/dd')
                                .format(DateTime.now()),
                            style: const TextStyle(
                                fontSize: 14.0, color: Colors.white),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Icon(
                              Icons.linear_scale,
                              color: Colors.white,
                              size: 10,
                            ),
                          ),
                          Text(
                            DateFormat('yyyy/MM/dd')
                                .format(DateTime.now()),
                            style: const TextStyle(
                                fontSize: 14.0, color: Colors.white),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 130.h,
                            width: 40.w,
                            child: ListView.builder(
                                padding: EdgeInsets.zero,
                                physics:
                                    const NeverScrollableScrollPhysics(),
                                itemCount: leftNumbers.length,
                                itemBuilder:
                                    (BuildContext context, int index) {
                                  return SizedBox(
                                      height: 22.h,
                                      child: Text(
                                        leftNumbers[index],
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.sp),
                                      ));
                                }),
                          ),
                          FutureBuilder<List<int>>(
                            future: ZikirProvider()
                                .getLast7DaysTotalCounts(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                final last7DaysTotalCounts =
                                    snapshot.data!;
                                //final weeklySummary = last7DaysTotalCounts?.map((count) => count.toDouble()).toList();
                                return SizedBox(
                                    height: 130.h,
                                    width: 200.w,
                                    child: BarGraph(
                                      weeklySummary:
                                          last7DaysTotalCounts
                                              .map((count) => count !=
                                                      null
                                                  ? (count > 1000
                                                      ? 1000.0
                                                      : count
                                                          .toDouble())
                                                  : 0.0)
                                              .toList(),
                                    ));
                              } else if (snapshot.hasError) {
                                return Center(
                                  child:
                                      Text('Error: ${snapshot.error}'),
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
                      SizedBox(height: 30.h),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 12.0, right: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.all(4.0),
                                      child: Icon(
                                        Icons.access_time,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      'total_count'.tr,
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                                FutureBuilder<int>(
                                  future: Provider.of<ZikirProvider>(
                                          context)
                                      .getTotalCountLast7Days(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const CircularProgressIndicator();
                                    } else {
                                      int totalCount =
                                          snapshot.data ?? 0;
                                      return Text(
                                        totalCount.toString(),
                                        style: TextStyle(
                                            fontSize: 36.sp,
                                            color: AppColors.colorAlert,
                                            fontWeight:
                                                FontWeight.bold),
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                            SizedBox(width: 40.w),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.all(4.0),
                                      child: Icon(
                                        Icons.access_time,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      'daily_count'.tr,
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                                FutureBuilder<int>(
                                  future: Provider.of<ZikirProvider>(
                                          context)
                                      .getTotalCountLast7Days(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const CircularProgressIndicator();
                                    } else {
                                      int totalCount =
                                          snapshot.data ?? 0;
                                      return Text(
                                        (totalCount / 7)
                                            .toInt()
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 36.sp,
                                            color: AppColors.colorAlert,
                                            fontWeight:
                                                FontWeight.bold),
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Positioned(
            top: 45.h,
            left: 16.w,
            right: 16.w,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  padding: const EdgeInsets.only(left: 12.0, right: 12),
                  child: Text(
                    'counter_summery'.tr,
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
              ],
            )),
      ],
    ));
  }
}
