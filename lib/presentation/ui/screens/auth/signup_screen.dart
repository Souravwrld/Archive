import 'package:JazakAllah/presentation/ui/screens/auth/signin_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../../../state_holders/auth/signup_screen_controller.dart';
import '../../utility/assets_path.dart';
import '../../utility/functions_and_methods.dart';
import '../../widgets/congrats_custom_dialogue.dart';
import '../../widgets/loading_popup.dart';
import '../../widgets/reusable_background_image.dart';
import '../../widgets/reusable_text_form_field.dart';
import '../home_screen.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key, required this.isParent}) : super(key: key);
  final bool isParent;

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController nameTEController = TextEditingController();

  final TextEditingController emailTEController = TextEditingController();

  final TextEditingController passwordTEController = TextEditingController();

  final TextEditingController confirmPasswordTEController =
      TextEditingController();

  String userAdId = '';

  void getAndSaveDeviceId() async {
    // Retrieve the OneSignal player ID
    // await OneSignal.shared.getDeviceState().then((deviceState) {
    //   setState(() {
    //     userAdId = deviceState?.userId ?? "unavailable";
    //   });
    //   print('___________________$userAdId');
    // });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAndSaveDeviceId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          ReusableBackgroundImage(bgImagePath: AssetsPath.background03SVG),
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
                        'signup_title'.tr,
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
                        'signup_subtitle'.tr,
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
                          formTitle: 'auth_name',
                          hintText: 'auth_name_hint',
                          controller: nameTEController,
                          keyboardType: TextInputType.text,
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        ReusableTextFormField(
                          formTitle: 'auth_email',
                          hintText: 'example@domain.com',
                          controller: emailTEController,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
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
                        GetBuilder<SignUpScreenController>(
                            builder: (signUpScreenController) {
                          return SizedBox(
                            height: 54.h,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                checkFormErrors(
                                    context, signUpScreenController);
                              },
                              child: Text(
                                'sign_up'.tr,
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
                          height: 20.h,
                        ),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'already_have_account'.tr,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 16.sp,
                                  color: Colors.white,
                                ),
                              ),
                              const WidgetSpan(
                                child: SizedBox(width: 5),
                              ),
                              TextSpan(
                                text: 'sign_in'.tr,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: const Color(0xFF75BFC0),
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    widget.isParent
                                        ? Get.to(() => SignInScreen(
                                              isParent: false,
                                            ))
                                        : Get.offAll(() => SignInScreen(
                                              isParent: true,
                                            ));
                                  },
                              ),
                            ],
                          ),
                        ),
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
      BuildContext context, SignUpScreenController controller) {
    if (nameTEController.text.isEmpty) {
      FunctionsAndMethods.showSnackbarErrorMessage('error_name_hint');
      return;
    }
    if (emailTEController.text.isEmpty) {
      FunctionsAndMethods.showSnackbarErrorMessage('error_email_hint');
      return;
    }
    if (!GetUtils.isEmail(emailTEController.text)) {
      FunctionsAndMethods.showSnackbarErrorMessage('error_valid_email_hint');
      return;
    }
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

    // Signup method
    signUp(controller, context);
  }

  //Account creation successful popup method
  void showCustomAlertDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CongratulationsCustomAlertDialog(
          title: 'congratulations_txt',
          message: 'successfully_account_create_msg',
          onContinuePressed: () {
            Get.offAll(() => const HomeScreen(
                  loadUserData: true,
                ));
            print('Sign Up successful');
          },
        );
      },
    );
  }

  // Signup method
  Future<void> signUp(
      SignUpScreenController controller, BuildContext context) async {
    final response = await controller.signUp(nameTEController.text.trim(),
        emailTEController.text.trim(), passwordTEController.text, userAdId);
    if (response) {
      Get.back();
      showCustomAlertDialog(context);
    } else {
      Get.back();
      FunctionsAndMethods.showSnackbarErrorMessage(controller.message);
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
}
