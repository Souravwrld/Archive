import 'package:JazakAllah/presentation/ui/screens/auth/verify_otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../state_holders/auth/verify_email_screen_controller.dart';
import '../../utility/assets_path.dart';
import '../../utility/functions_and_methods.dart';
import '../../widgets/loading_popup.dart';
import '../../widgets/reusable_background_image.dart';
import '../../widgets/reusable_custom_appbar.dart';
import '../../widgets/reusable_text_form_field.dart';


class VerifyEmailScreen extends StatelessWidget {
  VerifyEmailScreen({super.key});

  final TextEditingController emailTEController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          ReusableBackgroundImage(bgImagePath: AssetsPath.background03SVG),
          // Custom Appbar
          const ReusableCustomAppbar(
            screenTitle: 'forgot_password2',
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ReusableTextFormField(
                    formTitle: 'auth_email',
                    hintText: 'example@domain.com',
                    controller: emailTEController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(
                    height: 32.h,
                  ),
                  GetBuilder<VerifyEmailScreenController>(
                      builder: (forgotPasswordScreenController) {
                    // Elevated button
                    return SizedBox(
                      height: 54.h,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Keyboard hiding
                          FocusScope.of(context).requestFocus(FocusNode());
                          // Form error checking method
                          checkFormErrors(
                              forgotPasswordScreenController, context);
                        },
                        child: Text(
                          'reset_password'.tr,
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
          )
        ],
      ),
    );
  }

  //Form error checking method
  void checkFormErrors(
      VerifyEmailScreenController controller, BuildContext context) {
    if (emailTEController.text.isEmpty) {
      FunctionsAndMethods.showSnackbarErrorMessage('error_email_hint');
      return;
    }
    if (!GetUtils.isEmail(emailTEController.text)) {
      FunctionsAndMethods.showSnackbarErrorMessage('error_valid_email_hint');
      return;
    }
    // Loading indicator method
    showLoadingDialog(context);
    // Forgot password method
    verifyEmail(controller);
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
  Future<void> verifyEmail(VerifyEmailScreenController controller) async {
    final response =
        await controller.verifyEmail(emailTEController.text.trim());
    print(response);
    if (response) {
      Get.back();
      print('Password reset successful');
      // Navigate to reset otp screen
      Get.to(() => VerifyOtpScreen(email: emailTEController.text.trim()));
    } else {
      Get.back();
      FunctionsAndMethods.showSnackbarErrorMessage(controller.message);
    }
  }
}
