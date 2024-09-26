import 'package:JazakAllah/presentation/ui/screens/auth/signup_screen.dart';
import 'package:JazakAllah/presentation/ui/screens/auth/verify_email_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../../../state_holders/auth/signin_screen_controller.dart';
import '../../utility/assets_path.dart';
import '../../utility/functions_and_methods.dart';
import '../../widgets/loading_popup.dart';
import '../../widgets/reusable_background_image.dart';
import '../../widgets/reusable_text_form_field.dart';
import '../home_screen.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen({Key? key, required this.isParent}) : super(key: key);
  final bool isParent;

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailTEController = TextEditingController();

  final TextEditingController passwordTEController = TextEditingController();

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
                        'sign_in_title'.tr,
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
                        'sign_in_subtitle'.tr,
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
                          height: 12.h,
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(() => VerifyEmailScreen());
                          },
                          child: Text(
                            'forgot_password'.tr,
                            style: TextStyle(
                              color: const Color(0xFF75BFC0),
                              fontSize: 16.sp,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 32.h,
                        ),
                        GetBuilder<SignInScreenController>(
                            builder: (signInScreenController) {
                          return SizedBox(
                            height: 54.h,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                checkFormErrors(
                                    context, signInScreenController);
                              },
                              child: Text(
                                'sign_in'.tr,
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
                                text: 'no_account'.tr,
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
                                text: 'resister'.tr,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: const Color(0xFF75BFC0),
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    widget.isParent
                                        ? Get.to(() => SignUpScreen(
                                              isParent: false,
                                            ))
                                        : Get.offAll(() => SignUpScreen(
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
      BuildContext context, SignInScreenController controller) {
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
    // Loading indicator method
    showLoadingDialog(context);

    // Signup method
    signIn(controller);
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
  Future<void> signIn(SignInScreenController controller) async {
    final response = await controller.signIn(
      emailTEController.text.trim(),
      passwordTEController.text,
      userAdId,
    );
    print(response);
    if (response) {
      //print('Go Home');
      Get.back();
      Get.offAll(() => const HomeScreen(
            loadUserData: true,
          ));
      //print('Home');
    } else {
      Get.back();
      FunctionsAndMethods.showSnackbarErrorMessage(controller.message);
    }
  }
}
