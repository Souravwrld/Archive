import 'dart:ui';
import 'package:JazakAllah/presentation/state_holders/Providers/wallpaper_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import '../../../../application/utility/colors.dart';

class SetWallPaper extends StatefulWidget {
  const SetWallPaper({super.key, required this.index});
  final int index;
  @override
  State<SetWallPaper> createState() => _SetWallPaperState();
}

class _SetWallPaperState extends State<SetWallPaper> {

  // ignore: prefer_final_fields
  double? _containerHeight = 115.0,
      _containerWidth;
  bool? showInfo = false,
      isLongPress = false;

  Icon sizeChangeIcon = const Icon(
    Icons.fullscreen_exit,
    color: Colors.white,
  );
  BoxFit imageFit = BoxFit.cover;
  bool isFitCover = true;

  @override
  Widget build(BuildContext context) {
    return Consumer<WallPaperProvider>(
      builder: (context, provider, child){
        return Scaffold(
          backgroundColor: Colors.black,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            toolbarOpacity: (isLongPress!) ? 0.0 : 1.0,
            backgroundColor: Colors.transparent,
            titleSpacing: 0,
            title: Text(
              'wallpaper'.tr,
              style: TextStyle(
                color:
                  (isLongPress!)
                      ? Colors.transparent
                      : Colors.white,
              ),
            ),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    (isLongPress!)
                        ? Colors.transparent
                        : Colors.black.withOpacity(0.8),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
            elevation: 0.0,
            iconTheme: const IconThemeData(color: Colors.white),
            actions: [
              IconButton(
                icon: sizeChangeIcon,
                onPressed: () {
                  setState(() {
                    isFitCover = !isFitCover;
                    imageFit = (isFitCover) ? BoxFit.cover : BoxFit.contain;
                    sizeChangeIcon = (isFitCover)
                        ? const Icon(
                      Icons.fullscreen_exit,
                      color: Colors.white,
                    )
                        : const Icon(
                      Icons.fullscreen,
                      color: Colors.white,
                    );
                  });
                },
              ),
            ],
          ),
          body: Stack(
            children: <Widget>[
              GestureDetector(
                onLongPressStart: (value) {
                  setState(() {
                    isLongPress = true;
                  });
                },
                onLongPressEnd: (value) {
                  setState(() {
                    isLongPress = false;
                  });
                },
                child: Image.network(
                  provider.allWallpapers![widget.index].originalUrl,
                  loadingBuilder: (BuildContext? context, Widget? child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child!;
                    return Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(provider.allWallpapers![widget.index].thumbnailUrl), fit: BoxFit.cover),
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                ' Press & Hold for preview ',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white,
                                  backgroundColor: Colors.black45,
                                ),
                              ),
                              const SizedBox(
                                height: 50.0,
                              ),
                              CircularProgressIndicator(
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                    Colors.white),
                                strokeWidth: 2.0,
                                backgroundColor: Colors.black45,
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  fit: imageFit,
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
              Align(
                alignment: FractionalOffset.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 50.0),
                  child: buildPhotoActions(context, provider.allWallpapers![widget.index].originalUrl),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildPhotoActions(BuildContext context, largeImage) {
    bool android;
    if (Theme.of(context).platform == TargetPlatform.android) {
      android = true;
    } else if (Theme.of(context).platform == TargetPlatform.iOS) {
      android = false;
    } else {
      android = false; // Default color for unknown platform
    }
    String? result;
    // ignore: prefer_typing_uninitialized_variables
    var file;
    final provider = Provider.of<WallPaperProvider>(context, listen: false);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      transform: Matrix4.translationValues(
          0, (isLongPress!) ? (_containerHeight! + 150.0) : 0, 0),
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            blurRadius: 10.0,
          ),
        ],
        borderRadius: BorderRadius.circular(50.0),
        color: AppColors.colorPrimaryLighter,
      ),
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.all(10.0),
      width: _containerWidth,
      height: MediaQuery
          .of(context)
          .size
          .height * 0.1,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            android?
            GestureDetector(
              onTap: (){
                _save(provider.allWallpapers![widget.index].originalUrl);
              },
              child: Icon(
                Icons.save_alt,
                size: 24.sp,
                color: Colors.white,
              )
            ) : const SizedBox(),
            android?
            GestureDetector(
              onTap: () async{
                Navigator.of(context).pop();
                Fluttertoast.showToast(
                  msg: "Setting Both Screen Wallpaper Please Wait... ",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                );
                file = await DefaultCacheManager().getSingleFile(largeImage);
                result = await WallpaperManager.setWallpaperFromFile(
                    file.path, WallpaperManager.BOTH_SCREEN)
                // ignore: missing_return
                    .then((value) {
                  Fluttertoast.showToast(
                    msg: "Successfully Set Wallpaper",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                  );
                  return null;
                });
              },
              child: Image.asset(
                  "assets/images/wall2.png",
                height: 50.h,
                width: 50.h,
              ),
            ) : GestureDetector(
                onTap: (){
                  _save(provider.allWallpapers![widget.index].originalUrl);
                },
                child: Icon(
                  Icons.save_alt,
                  size: 24.sp,
                  color: Colors.white,
                )
            ),
            android?
            GestureDetector(
              onTap: (){
                handleApply(provider.allWallpapers![widget.index].originalUrl, context);
              },
              child: Icon(
                  Icons.more_horiz,
                color: Colors.white,
                size: 24.sp,
              ),
            ) : const SizedBox(),
          ],
        ),
      ),
    );
  }


  // ignore: prefer_void_to_null
  Future<Null> handleApply(String image, BuildContext context) async {
    String? result;
    // ignore: prefer_typing_uninitialized_variables
    var file;

    try {
      showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 300.h,
            child: Padding(
              padding:
              const EdgeInsets.symmetric(
                  horizontal: 24),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 40.h),
                  Text(
                    "What would like to do?",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 30.h),
                  Container(
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/images/phone.png",
                          height: 20.h,
                          width: 20.w,
                        ),
                        SizedBox(width: 12.w),
                        InkWell(
                          onTap: () async{
                            Navigator.of(context).pop();
                            Fluttertoast.showToast(
                              msg: "Setting Home Screen Wallpaper Please Wait... ",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                            );
                            file = await DefaultCacheManager().getSingleFile(image);
                            result = await WallpaperManager.setWallpaperFromFile(
                                file.path, WallpaperManager.HOME_SCREEN)
                            // ignore: missing_return
                                .then((value) {
                              Fluttertoast.showToast(
                                msg: "Successfully Set Wallpaper",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                              );
                              return null;
                            });
                          },
                          child: Text(
                            'Set on home screen',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Divider(height: 1),
                  SizedBox(height: 16.h),
                  Container(
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/images/lockPhone.png",
                          height: 20.h,
                          width: 20.w,
                        ),
                        SizedBox(width: 12.w),
                        InkWell(
                          onTap: () async{
                            Navigator.of(context).pop();
                            Fluttertoast.showToast(
                              msg: "Setting Lock Screen Wallpaper Please Wait... ",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                            );
                            file = await DefaultCacheManager().getSingleFile(image);
                            result = await WallpaperManager.setWallpaperFromFile(
                                file.path, WallpaperManager.LOCK_SCREEN)
                            // ignore: missing_return
                                .then((value) {
                              Fluttertoast.showToast(
                                msg: "Successfully Set Wallpaper",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                              );
                              return null;
                            });
                          },
                          child: Text(
                            "Set on lock screen",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12.h),
                  const Divider(height: 1),
                  SizedBox(height: 16.h),
                  Container(
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/images/lockPhone2.png",
                          height: 20.h,
                          width: 20.w,
                        ),
                        SizedBox(width: 12.w),
                        InkWell(
                          onTap: () async{
                            Navigator.of(context).pop();
                            Fluttertoast.showToast(
                              msg: "Setting Both Screen Wallpaper Please Wait... ",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                            );
                            file = await DefaultCacheManager().getSingleFile(image);
                            result = await WallpaperManager.setWallpaperFromFile(
                                file.path, WallpaperManager.BOTH_SCREEN)
                            // ignore: missing_return
                                .then((value) {
                              Fluttertoast.showToast(
                                msg: "Successfully Set Wallpaper",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                              );
                              return null;
                            });
                          },
                          child: Text(
                            'Set on both screen',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12.h),
                  const Divider(height: 1),
                  SizedBox(height: 16.h),
                  Container(
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/images/save.png",
                          height: 24.h,
                          width: 24.w,
                        ),
                        SizedBox(width: 12.w),
                        InkWell(
                          onTap: () {
                            _save(Provider.of<WallPaperProvider>(context, listen: false).allWallpapers![widget.index].originalUrl);
                            Navigator.pop(
                                context);
                          },
                          child: Text(
                            'Save to device',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    } on PlatformException {
      result = 'Failed to get wallpaper.';
    }
  }

  Future<void> _save(String image) async {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: AppColors.colorPrimary,
          content: Text('Saving image...'),
        ),
      );
    }

    TextStyle _selectedStyle = TextStyle(
      color: Colors.white,
      // Set any other style properties as per your design requirements
    );

    var status = await Permission.storage.request();
    if(status.isGranted){
      var response = await Dio().get(
          image,
          options: Options(responseType: ResponseType.bytes));
      final result = await ImageGallerySaver.saveImage(
          Uint8List.fromList(response.data),
          quality: 60,
          name: "image");
      print(result);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColors.colorPrimary,
            content: Text('Image saved successfully.'),
            duration: Duration(seconds: 1),
          ),
        );
      }
    }
  }


}