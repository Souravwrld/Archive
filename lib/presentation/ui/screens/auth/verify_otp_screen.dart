import 'package:JazakAllah/presentation/ui/screens/auth/reset_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../application/utility/colors.dart';
import '../../../state_holders/auth/verify_otp_screen_controller.dart';
import '../../utility/assets_path.dart';
import '../../utility/functions_and_methods.dart';
import '../../widgets/loading_popup.dart';
import '../../widgets/reusable_background_image.dart';
import '../../widgets/reusable_custom_appbar.dart';


class VerifyOtpScreen extends StatelessWidget {
  VerifyOtpScreen({super.key, required this.email});

  final String email;

  final TextEditingController otpTEController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          ReusableBackgroundImage(bgImagePath: AssetsPath.background03SVG),
          // Custom Appbar
          const ReusableCustomAppbar(screenTitle: 'verify_otp'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'otp_field_title'.tr,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    // Pin code design section
                    PinCodeTextField(
                      appContext: context,
                      length: 4,
                      obscureText: false,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                        selectedFillColor: AppColors.colorPrimaryLighter,
                        borderWidth: 0,
                        activeBorderWidth: 0,
                        selectedBorderWidth: 0,
                        inactiveColor: Colors.white,
                        inactiveFillColor: Colors.white,
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(8),
                        fieldHeight: 52.h,
                        fieldWidth: 50.80.w,
                        activeFillColor: Colors.white,
                      ),
                      animationDuration: Duration(milliseconds: 300),
                      enableActiveFill: true,
                      controller: otpTEController,
                      onCompleted: (v) {
                        print("Completed = $v");
                      },
                      onChanged: (value) {},
                      beforeTextPaste: (text) {
                        print("Allowing to paste $text");
                        return true;
                      },
                    ),
                    SizedBox(
                      height: 32.h,
                    ),
                    GetBuilder<OtpVerificationController>(
                        builder: (otpVerificationController) {
                      // Elevated button
                      return SizedBox(
                        height: 54.h,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            checkFormErrors(otpVerificationController, context);
                            print(otpTEController.text.toString());
                          },
                          child: Text(
                            'continue_btn_txt'.tr,
                            style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                color: Color(0xFF474747),
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  //Form error checking method
  void checkFormErrors(
      OtpVerificationController controller, BuildContext context) {
    if (otpTEController.text.length == 4) {
      // Loading indicator method
      showLoadingDialog(context);
      // Forgot password method
      verifyOTP(controller);
    } else {
      FunctionsAndMethods.showSnackbarErrorMessage('incomplete_otp');
    }
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

  // Signup method
  Future<void> verifyOTP(OtpVerificationController controller) async {
    final response =
        await controller.verifyOtp(email, otpTEController.text.trim());
    print(response);
    if (response) {
      Get.back();
      // Navigate to reset password screen
      Get.to(() => ResetPasswordScreen(
            email: email,
            otp: otpTEController.text.trim(),
          ));
    } else {
      Get.back();
      FunctionsAndMethods.showSnackbarErrorMessage(controller.message);
    }
  }
}
