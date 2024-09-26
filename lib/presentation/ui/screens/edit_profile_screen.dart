import 'dart:io';
import 'package:JazakAllah/presentation/state_holders/Providers/user_provider.dart';
import 'package:JazakAllah/presentation/state_holders/auth/user_data_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:JazakAllah/presentation/state_holders/edit_profile_screen_controller.dart';
import 'package:JazakAllah/presentation/ui/utility/assets_path.dart';
import 'package:JazakAllah/presentation/ui/utility/functions_and_methods.dart';
import 'package:JazakAllah/presentation/ui/widgets/loading_popup.dart';
import 'package:JazakAllah/presentation/ui/widgets/reusable_background_image.dart';
import 'package:JazakAllah/presentation/ui/widgets/reusable_custom_appbar.dart';
import 'package:JazakAllah/presentation/ui/widgets/reusable_text_form_field.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../application/utility/colors.dart';
import '../../../data/utility/urls.dart';
import 'auth/signup_screen.dart';
import 'package:http/http.dart' as http;

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController nameTEController = TextEditingController();

  final TextEditingController emailTEController = TextEditingController();

  final TextEditingController passwordTEController = TextEditingController();

  final TextEditingController confirmPasswordTEController =
      TextEditingController();
  String userName = '';
  String userMail = '';
  String userId = '';

  @override
  void initState() {
    // Load/Fetch user data
    loadUserData();
    super.initState();
  }

  String selectedImagePath = '';
  File? imageFile;

  selectImageFromGallery() async {
    XFile? file = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 10,
    );
    if (file != null) {
      return file.path;
    } else {
      return '';
    }
  }

  // Load/Fetch user data method
  Future<void> loadUserData() async {
    //Access userNme on shared pref
    await UserDataController.getUserName();
    //Access userMail on shared pref
    await UserDataController.getUserMail();
    //Access userId on shared pref
    await UserDataController.getUserId();
    // Set and update user data value
    setState(() {
      userName = UserDataController.userName ?? '';
      userMail = UserDataController.userMail ?? '';
      userId = UserDataController.userId ?? '';
      nameTEController.text = userName;
      emailTEController.text = userMail;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          ReusableBackgroundImage(bgImagePath: AssetsPath.secondaryBGSVG),
          // Custom Appbar
          const ReusableCustomAppbar(screenTitle: 'profile'),
          Column(
            children: [
              SizedBox(
                height: 97.h,
              ),
              // Profile card section
              Stack(
                children: [
                  Center(
                    child: SvgPicture.asset(
                      AssetsPath.profileSectionBGSVG,
                      //width: Get.width-32,
                      width: 328,
                      height: 200,
                    ),
                  ),
                  Consumer<UserProvider>(
                      builder: (context, userProvider, child) {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Center(
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    selectedImagePath == ''
                                        ? userProvider.userData!.thumbnailUrl == null || userProvider.userData!.thumbnailUrl == 'Null' || userProvider.userData!.thumbnailUrl == ''?  ClipOval(
                                      child: Image.asset(
                                        AssetsPath.profileAvatarPNG,
                                        height: 100,
                                        width: 100,
                                      ),
                                    ) : ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Container(
                                        height: 100.w,
                                        width: 100.w,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(100),
                                            color: Colors.white
                                        ),
                                        child: Image.network(
                                          userProvider.userData!.thumbnailUrl!,
                                          fit: BoxFit.cover,
                                          height: 100.w,
                                          width: 100.w,
                                        ),
                                      ),
                                    ) : ClipOval(
                                      child: Image.file(
                                        File(selectedImagePath),
                                        height: 100.w,
                                        width: 100.w,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Positioned(
                                      right: 5,
                                      bottom: 5,
                                      child: InkWell(
                                        onTap: () async {
                                          selectedImagePath =
                                          await selectImageFromGallery();

                                          if (selectedImagePath != '') {
                                            setState(() {
                                              imageFile = File(selectedImagePath);
                                            });
                                          }
                                        },
                                        child: Image.asset(
                                          AssetsPath.avatarEditPNG,
                                          height: 20,
                                          width: 20,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Text(
                                  userName,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: AppColors.colorWhiteHighEmp,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  userMail,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: AppColors.colorWhiteHighEmp,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              // Form section
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28),
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
                          readOnly: true,
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
                        SizedBox(
                          height: 54.h,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              checkFormErrors();
                            },
                            child: Text(
                              'save_btn_text'.tr,
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 16.sp,
                                  color: AppColors.colorBlackHighEmp,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 22.h,
                        ),
                        SizedBox(
                          height: 54.h,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async{
                              await showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text('Are you sure?'),
                                    content: Text('Do you want to delete this account?',style: TextStyle(fontSize: 12.sp),),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () => Navigator.of(context).pop(false), //<-- SEE HERE
                                        child: Text('No'),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          deleteData();
                                        },
                                        child: Text('Yes'),
                                      ),
                                    ],
                                  ));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              // Other styling properties
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.delete,
                                  size: 22.sp,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 10.w,),
                                Text(
                                  'Delete Account'.tr,
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16.sp,
                                      color: AppColors.colorWhiteHighEmp,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 50.h,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  bool deletingAccount = false;

  Future<void> deleteData() async {
    Navigator.pop(context);
    showLoadingDialog(context);
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    String? userId = sharedPreferences.getString('user_id');

    final response = await http.delete(
      Uri.parse("${Urls.deleteAccount}$userId"),
    );

    if (response.statusCode == 200) {
      print('DELETE request successful');
      Navigator.pop(context);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) => SignUpScreen(isParent: true)),
            (Route<dynamic> route) => false,
      );
    } else {
      Navigator.pop(context);
      FunctionsAndMethods.showSnackbarErrorMessage('Unknown Error!! Please try again..');
      print('Failed to delete data. Error code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }

  //Form error checking method
  void checkFormErrors() async{
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
    if (passwordTEController.text.isNotEmpty &&
        passwordTEController.text.length < 8) {
      FunctionsAndMethods.showSnackbarErrorMessage('error_password_hint2'.tr);
      return;
    }
    if (passwordTEController.text.isNotEmpty &&
        (confirmPasswordTEController.text != passwordTEController.text)) {
      FunctionsAndMethods.showSnackbarErrorMessage(
          'error_confirm_password_hint2');
      return;
    }
    // Loading indicator method
    showLoadingDialog(context);
    Map<String, dynamic> requestBody = {};
    if (passwordTEController.text.isEmpty) {
      requestBody = {"fullName": nameTEController.text.trim()};
    } else {
      requestBody = {
        "fullName": nameTEController.text.trim(),
        "password": passwordTEController.text
      };
    }
    print(requestBody);
    // Update method
    updateUserData(requestBody, context);
  }

  // Update method
  Future<void> updateUserData(
      Map<String, dynamic> requestBody, BuildContext context) async {
    bool imageUpload;
    if(selectedImagePath != ''){
      imageUpload = true;
    }else{
      imageUpload = false;
    }
    final response = await Get.find<EditProfileScreenController>()
        .updateUserData(requestBody, userId, imageUpload, imageFile);
    if (response) {
      await UserDataController.setUserName(nameTEController.text.trim());
      Get.back();
      loadUserData();
      FunctionsAndMethods.showSnackbarErrorMessage('data_update_success');
      Provider.of<UserProvider>(context, listen: false).fetchLoggedInUserData(true);
    } else {
      Get.back();
      FunctionsAndMethods.showSnackbarErrorMessage(
          Get.find<EditProfileScreenController>().message);
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
