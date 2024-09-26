import 'dart:async';
import 'package:JazakAllah/presentation/ui/screens/reusable_counter_summery_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../../application/utility/colors.dart';
import '../../state_holders/Providers/DBHelper/helper_function.dart';
import '../../state_holders/Providers/counter_provider.dart';
import '../../state_holders/Providers/models/note_model.dart';
import '../../state_holders/Providers/models/zikir_model.dart';
import '../../state_holders/Providers/note_provider.dart';

class ReusableTasbihCounterScreen extends StatefulWidget {
  final String data;
  const ReusableTasbihCounterScreen({super.key, required this.data});

  @override
  State<ReusableTasbihCounterScreen> createState() => _ReusableTasbihCounterScreenState();
}

class _ReusableTasbihCounterScreenState extends State<ReusableTasbihCounterScreen> {
  int countNumber = 0;
  int secondaryCountNumber = 0;
  late Stopwatch _stopwatch;
  late Timer _timer;
  DateTime? date;
  late ZikirProvider zikirProvider;

  //For textField which saving note
  final noteController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch();
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (_stopwatch.isRunning) {
        updateElapsedTime();
      }
    });
    _stopwatch.start();
    Provider.of<NoteProvider>(context, listen: false).getAllNotes();
  }

  void updateElapsedTime() {
    if (mounted) {
      setState(() {}); // Trigger a rebuild
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    saveZikir();// Cancel the timer to avoid calling setState after dispose
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    zikirProvider = Provider.of<ZikirProvider>(context, listen: false);

  }
  
  @override
  Widget build(BuildContext context) {
    final noteProvider = Provider.of<NoteProvider>(context, listen: false);
    final zikirProvider = Provider.of<ZikirProvider>(context, listen: false);
    Duration duration = _stopwatch.elapsed;
    int hours = duration.inHours;
    int minutes = duration.inMinutes.remainder(60);
    int seconds = duration.inSeconds.remainder(60);
    return Scaffold(
      resizeToAvoidBottomInset: false, // Disable automatic resizing
      body: Stack(
        children: [
          // Background Image
          SvgPicture.asset(
            'assets/images/background02.svg', // Replace with your image asset path
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Positioned(
              top: 45.h,
              left: 20.w,
              right: 16.w,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () async {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0, right: 12),
                    child: Text(
                      'tasbih_counter'.tr,
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                ],
              )),
          Positioned(
            bottom: 0.h,
            left: 16.w,
            right: 16.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: 30.h,
                ),
                Text(
                  widget.data,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.colorAlert, fontSize: 20.sp),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Container(
                  height: 40.h,
                  width: 90.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.colorWhiteLowEmp.withOpacity(0.2)
                  ),
                  child: Center(
                    child: Text(
                      '${hours > 0 ? '$hours:' : ''}${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
                      style: TextStyle(color: Colors.white, fontSize: 20.sp),
                    ),
                  ),
                ),
                SizedBox(height: 30.h),
                Text(
                  'tasbih_counter'.tr,
                  style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ),
                Text(
                  '$countNumber',
                  style: TextStyle(
                      color: AppColors.colorAlert,
                      fontSize: 100.sp,
                      fontWeight: FontWeight.w900),
                ),
                SizedBox(
                  height: 60.h,
                ),
                Visibility(
                  visible: countNumber ==
                      0, // Set the condition to show/hide the Row
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.arrow_back_ios,
                        size: 18,
                        color: AppColors.colorWhiteHighEmp,
                      ),
                      SizedBox(width: 12.w),
                      Text(
                        'Swipe'.tr,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.sp,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                        color: AppColors.colorWhiteHighEmp,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Container(
                      height: 90.h,
                      width: 280.w,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Swiper(
                        loop: true,
                        scrollDirection: Axis.horizontal,
                        duration: 800,
                        itemCount: 100,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              SizedBox(
                                width: 110.w,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Container(
                                  height: 60.w,
                                  width: 60.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                        onIndexChanged: (int demo) {
                          setState(() {
                            countNumber++;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                  child: Container(
                    height: 85.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.colorPrimaryDark,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                countNumber = 0;
                              });
                            },
                            child: Icon(
                              Icons.refresh,
                              color: Colors.white,
                              size: 25.sp,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              _showSimpleDialogForAddNotes();
                            },
                            child: Icon(
                              Icons.save,
                              color: Colors.white,
                              size: 22.sp,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              _showSimpleDialogForAllNotes();
                            },
                            child: Icon(
                              Icons.history,
                              color: Colors.white,
                              size: 25.sp,
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              saveZikir();
                              secondaryCountNumber = countNumber;
                              Get.to(const SummaryScreen());
                            },
                            child: Icon(
                              Icons.bar_chart,
                              color: Colors.white,
                              size: 22.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  //Dialog for adding notes
  Future<void> _showSimpleDialogForAddNotes() async {
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          backgroundColor: Colors.white,
          child: SizedBox(
            height: 420.h,
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                    child: SvgPicture.asset(
                      'assets/images/popup_bg.svg',
                      alignment: Alignment.topCenter,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'what_are_you_reading'.tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: AppColors.colorBlackHighEmp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Center(
                    child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: noteController,
                          decoration: InputDecoration(
                              hintText: "Subhanallah - 33 Times",
                              contentPadding:
                              const EdgeInsets.symmetric(vertical: 10),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: const BorderSide(
                                      color: AppColors.colorWhiteLowEmp,
                                      width: 1))),
                          textAlign: TextAlign.center,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This field must not be empty';
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () {
                      saveNote();
                      Navigator.pop(context);
                      showMsg(context, 'Added Successfully');
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 80, right: 80),
                      height: 36.h,
                      width: 140.w,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppColors.colorButtonGradientStart,
                            AppColors.colorButtonGradientEnd,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Center(
                        child: Text(
                          'add'.tr,
                          style: TextStyle(
                              color: AppColors.colorBlackHighEmp,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'close'.tr,
                          style: TextStyle(
                              color: AppColors.colorDisabled,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400),
                        )),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  //Dialog for showing saved notes
  Future<void> _showSimpleDialogForAllNotes() async {
    final noteProvider = Provider.of<NoteProvider>(context, listen: false);
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          backgroundColor: Colors.white,
          child: SizedBox(
            height: 500.h,
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                  child: SvgPicture.asset(
                    'assets/images/popup_bg.svg',
                    alignment: Alignment.topCenter,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'tasbih_note'.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: AppColors.colorBlackHighEmp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 120.h,
                  child: Consumer<NoteProvider>(
                    builder: (context, provider, child) => ListView.builder(
                      itemCount: provider.noteList.length,
                      itemBuilder: (context, index) {
                        final note = provider.noteList[index];
                        return Column(
                          children: [
                            Container(
                              height: 30.h,
                              margin:
                              const EdgeInsets.symmetric(horizontal: 24),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                border: Border.all(
                                    color: AppColors.colorWhiteLowEmp),
                              ),
                              child: Center(
                                child: Text(
                                  note.note,
                                  style: TextStyle(
                                    color: AppColors.colorBlackHighEmp,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 3.h),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                GestureDetector(
                  onTap: () {
                    deleteNotes(context, noteProvider);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 80, right: 80),
                    height: 36.h,
                    width: 140.w,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColors.colorButtonGradientStart,
                          AppColors.colorButtonGradientEnd,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Center(
                      child: Text(
                        'clear_note'.tr,
                        style: TextStyle(
                          color: AppColors.colorBlackHighEmp,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'close'.tr,
                      style: TextStyle(
                        color: AppColors.colorDisabled,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  //Method for save notes
  void saveNote() {
    final noteProvider = Provider.of<NoteProvider>(context, listen: false);
    if (_formKey.currentState!.validate()) {
      final note = NoteModel(note: noteController.text);
      noteProvider.insertNote(note).then((value) {
        noteProvider.getAllNotes();
        noteController.clear();
      }).catchError((error) {
        print(error.toString());
      });
    }
  }

  //Method for delete exiting notes
  void deleteNotes(BuildContext context, NoteProvider provider) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: AppColors.colorPrimaryDark,
          title: const Text(
            'Clear All Notes?',
            style: TextStyle(color: AppColors.colorAlert),
          ),
          content: const Text(
            'Are you sure to clear all notes?',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('No',
                    style: TextStyle(color: Colors.white))),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  provider.deleteNotes().then((value) {
                    Navigator.pop(context);
                    provider.getAllNotes();
                  });
                },
                child: const Text('Yes',
                    style: TextStyle(color: AppColors.colorAlert)))
          ],
        ));
  }

  //Method for save count
  void saveZikir() {
    date = DateTime.now();
    final zikir = ZikirModel(
        date: getFormattedDate(date!, 'dd/MM/yyyy'),
        name: widget.data,
        count: countNumber - secondaryCountNumber);
    zikirProvider.insertZikir(zikir).then((value) {
      zikirProvider.getAllZikirs();
    }).catchError((error) {
      print(error.toString());
    });
  }


}
