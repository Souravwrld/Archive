import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:JazakAllah/application/utility/colors.dart';

class ReusableTextFormField extends StatelessWidget {
  const ReusableTextFormField({
    Key? key,
    required this.formTitle,
    required this.hintText,
    required this.controller,
    required this.keyboardType,
    this.obscureText = false,
    this.readOnly = false,
  }) : super(key: key);

  final String formTitle;
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText, readOnly;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          formTitle.tr,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16.sp,
            color: AppColors.colorWhiteHighEmp,
          ),
        ),
        SizedBox(
          height: 6.h,
        ),
        SizedBox(
          height: 55.h,
          child: TextFormField(
            readOnly: readOnly,
            controller: controller,
            keyboardType: keyboardType,
            obscureText: obscureText,
            decoration: InputDecoration(
              contentPadding:
              const EdgeInsets.only(right: 16, left: 16),
              filled: true,
              fillColor: AppColors.colorWhiteHighEmp,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide.none,
              ),
              hintText: hintText.tr,
            ),
          ),
        ),
      ],
    );
  }
}


class ReusableTextFormField2 extends StatelessWidget {
  const ReusableTextFormField2({
    Key? key,
    required this.formTitle,
    required this.hintText,
    required this.controller,
    required this.keyboardType,
    this.obscureText = false,
    this.readOnly = false,
  }) : super(key: key);

  final String formTitle;
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText, readOnly;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          formTitle.tr,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12.sp,
            color: AppColors.colorWhiteHighEmp,
          ),
        ),
        SizedBox(
          height: 6.h,
        ),
        SizedBox(
          height: 55.h,
          child: TextFormField(
            readOnly: readOnly,
            controller: controller,
            keyboardType: keyboardType,
            obscureText: obscureText,
            decoration: InputDecoration(
              contentPadding:
              const EdgeInsets.only(right: 16, left: 16),
              filled: true,
              fillColor: AppColors.colorWhiteHighEmp,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide.none,
              ),
              hintText: hintText.tr,
            ),
          ),
        ),
      ],
    );
  }
}