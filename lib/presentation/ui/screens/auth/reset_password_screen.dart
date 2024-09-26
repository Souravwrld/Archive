import 'package:JazakAllah/presentation/ui/screens/auth/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../state_holders/auth/auth_controller.dart';
import '../../../state_holders/auth/reset_password_screen_controller.dart';
import '../../utility/assets_path.dart';
import '../../utility/functions_and_methods.dart';
import '../../widgets/congrats_custom_dialogue.dart';
import '../../widgets/loading_popup.dart';
import '../../widgets/reusable_background_image.dart';
import '../../widgets/reusable_custom_appbar.dart';
import '../../widgets/reusable_text_form_field.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key, required this.email, required this.otp});

  final String email, otp;

  final TextEditingController passwordTEController = TextEditingController();
  final TextEditingController confirmPasswordTEController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          ReusableBackgroundImage(bgImagePath: AssetsPath.background03SVG),
          // Custom Appbar
          const ReusableCustomAppbar(screenTitle: 'reset_password'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Column(
              children: [
                SizedBox(
                  height: 116.h,
                ),
                Center(
                  child: Column(
                    children: [
                      Text(
                        'rps_title'.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Text(
                        'rps_subtitle'.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16.sp,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 24.h,
                ),
                // Form section
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ReusableTextFormField(
                          formTitle: 'auth_password',
                          hintText: '****************',
                          controller: passwordTEController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        ReusableTextFormField(
                          formTitle: 'auth_confirm_password',
                          hintText: '****************',
                          controller: confirmPasswordTEController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                        ),
                        SizedBox(
                          height: 32.h,
                        ),
                        GetBuilder<ResetPasswordScreenController>(
                            builder: (resetPasswordScreenController) {
                          // Elevated button
                          return SizedBox(
                            height: 54.h,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                // Remove/hide keypad
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                // Checking form validation method
                                checkFormErrors(
                                    resetPasswordScreenController, context);
                              },
                              child: Text(
                                'complete_btn_txt'.tr,
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 16.sp,
                                    color: const Color(0xFF474747),
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          );
                        }),
                        SizedBox(
                          height: 50.h,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //Form error checking method
  void checkFormErrors(
      ResetPasswordScreenController controller, BuildContext context) {
    if (passwordTEController.text.isEmpty) {
      FunctionsAndMethods.showSnackbarErrorMessage('error_password_hint');
      return;
    }
    if (passwordTEController.text.length < 8) {
      FunctionsAndMethods.showSnackbarErrorMessage('error_password_hint2');
      return;
    }
    if (confirmPasswordTEController.text.isEmpty) {
      FunctionsAndMethods.showSnackbarErrorMessage(
          'error_confirm_password_hint');
      return;
    }
    if (confirmPasswordTEController.text != passwordTEController.text) {
      FunctionsAndMethods.showSnackbarErrorMessage(
          'error_confirm_password_hint2');
      return;
    }
    // Loading indicator method
    showLoadingDialog(context);

    // Reset Password method
    resetPassword(controller, context);
  }

  //Password reset successful popup method
  void showCustomAlertDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CongratulationsCustomAlertDialog(
          title: 'congratulations_txt',
          message: 'successfully_password_reset_msg',
          onContinuePressed: () async {
            print('Password Reset successful');
            // Clear token value
            await AuthController.clearTokenValue();
            // Navigate to sign in screen
            Get.offAll(() => SignInScreen(isParent: true));
          },
        );
      },
    );
  }

  // Loading indicator
  void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const LoadingPopup();
      },
    );
  }

  // Reset Password method
  Future<void> resetPassword(
      ResetPasswordScreenController controller, BuildContext context) async {
    final response =
        await controller.resetPassword(email, passwordTEController.text, otp);
    print(response);
    if (response) {
      Get.back();
      showCustomAlertDialog(context);
    } else {
      Get.back();
      FunctionsAndMethods.showSnackbarErrorMessage(controller.message);
    }
  }
}
