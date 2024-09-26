import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:JazakAllah/application/utility/colors.dart';

class FunctionsAndMethods {
  FunctionsAndMethods._();

  static void showSnackbarErrorMessage(String message) {
    Get.rawSnackbar(
      messageText: Text(
        message.tr,
        style: const TextStyle(
          color: AppColors.colorPrimary,
          fontSize: 16.0,
        ),
      ),
      margin: EdgeInsets.zero,
      borderRadius: 0,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.white, // White background color
    );
  }
}



