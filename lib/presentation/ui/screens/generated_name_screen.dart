import 'dart:convert';

import 'package:JazakAllah/application/utility/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../state_holders/Providers/gpt_provider.dart';
import '../utility/assets_path.dart';
import '../widgets/reusable_background_image.dart';

class GeneratedNameScreen extends StatefulWidget {
  const GeneratedNameScreen({super.key});

  @override
  State<GeneratedNameScreen> createState() => _GeneratedNameScreenState();
}

class _GeneratedNameScreenState extends State<GeneratedNameScreen> {
  String decodeUnicodeEscape(String input) {
    RegExp exp = RegExp(r'\\[uU]([0-9a-fA-F]{4})');
    return input.replaceAllMapped(exp, (match) {
      return String.fromCharCode(int.parse(match.group(1)!, radix: 16));
    });
  }

  String decodeArabic(String input) {
    return json.decode('"$input"');
  }

  @override
  Widget build(BuildContext context) {
    final gptProvider = Provider.of<GPTProvider>(context, listen: false);
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          ReusableBackgroundImage(bgImagePath: AssetsPath.secondaryBGSVG),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 50.h,),
                  appbarWidget(),
                  SizedBox(height: 20.h,),
                  Container(
                    width: double.maxFinite,
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: AppColors.colorPrimaryLight,
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Text(
                      gptProvider.reply,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                  SizedBox(height: 50.h,),
                ],
              ),
            ),
          )
        ],
      )
    );
  }

  Widget appbarWidget(){
    return Row(
      children: [
        GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_outlined,
            color: Colors.white,
            size: 22.sp,
          ),
        ),
        SizedBox(width: 10.w,),
        Text(
          "baby_name2".tr,
          style: TextStyle(
              fontSize: 18.sp,
              color: Colors.white
          ),
        )
      ],
    );
  }
}
