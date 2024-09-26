import 'package:JazakAllah/presentation/state_holders/Providers/gpt_provider.dart';
import 'package:JazakAllah/presentation/state_holders/Providers/location_provider.dart';
import 'package:JazakAllah/presentation/ui/screens/generated_name_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../application/utility/colors.dart';
import '../utility/assets_path.dart';
import '../utility/functions_and_methods.dart';
import '../widgets/reusable_background_image.dart';
import '../widgets/reusable_text_form_field.dart';

class IslamicBabyNameScreen extends StatefulWidget {
  const IslamicBabyNameScreen({super.key});

  @override
  State<IslamicBabyNameScreen> createState() => _IslamicBabyNameScreenState();
}

class _IslamicBabyNameScreenState extends State<IslamicBabyNameScreen> {
  final TextEditingController initialLetterController = TextEditingController();
  String? selectedType;
  List<String> typeList = ['Boy baby', 'Girl baby'];

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    initialLetterController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gptProvider = Provider.of<GPTProvider>(context, listen: false);
    final provider = Provider.of<LocationProvider>(context, listen: false);
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          ReusableBackgroundImage(bgImagePath: AssetsPath.secondaryBGSVG),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50.h,),
                appbarWidget(),
                SizedBox(height: 30.h,),
                Text(
                  "name_type".tr,
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
                DropdownButtonFormField<String>(
                  value: selectedType,
                  onChanged: (String? newValue) {
                    // You can update the state or perform any other actions here
                    setState(() {
                      selectedType = newValue!;
                    });
                  },
                  hint: Text(
                    'name_type'.tr,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, color: AppColors.colorDisabled,
                    ),
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.fromLTRB(16, -0, 16, -0),
                    // sets the padding for the text input field content
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Colors.white,
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Colors.white,
                        width: 1,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: AppColors.colorPrimary,
                        width: 1,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: AppColors.colorPrimary,
                        width: 1,
                      ),
                    ),
                  ),
                  items: typeList.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(height: 20.h,),
                ReusableTextFormField(
                  formTitle: 'initial_letter'.tr,
                  hintText: 'eg. A/B/C',
                  controller: initialLetterController,
                  keyboardType: TextInputType.text,
                  obscureText: false,
                ),
                SizedBox(height: 46.h,),
                GestureDetector(
                  onTap: () async{
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    String? language = prefs.getString('language') ?? 'en';
                    final String? apiKey = dotenv.env['chatGPT_Api'];
                    if(selectedType != null){
                      if(initialLetterController.text.isNotEmpty){
                        if(initialLetterController.text.length >= 2){
                          FunctionsAndMethods.showSnackbarErrorMessage("Initial letter should not be more than one letter");
                        } else{
                          _loaderDialog();
                          final allOk = await gptProvider.sendCompilation(selectedType! , initialLetterController.text, apiKey!, language);
                          if(allOk){
                            _dismissLoader();
                            Navigator.push(context, MaterialPageRoute(builder: (context) => GeneratedNameScreen()));
                          }
                        }
                      } else{
                        FunctionsAndMethods.showSnackbarErrorMessage("Enter initial letter");
                      }
                    } else{
                      FunctionsAndMethods.showSnackbarErrorMessage("Select a type");

                    }
                  },
                  child: Container(
                    height: 55.h,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: AppColors.indicatorColor,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Center(
                      child: Text(
                        "generate".tr,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
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


  //Custom loader showing while request ongoing
  void _loaderDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: Container(
            height: 90.w,
            width: 90.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.colorPrimary
            ),
            child: const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }

  //Dismiss custom loader after request done
  void _dismissLoader(){
    Navigator.pop(context);
  }
}
