import 'package:JazakAllah/application/utility/colors.dart';
import 'package:JazakAllah/presentation/state_holders/Providers/wallpaper_provider.dart';
import 'package:JazakAllah/presentation/ui/screens/wallpapers/set_wallpaper_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class AllWallPapersScreen extends StatefulWidget {
  const AllWallPapersScreen({super.key});

  @override
  State<AllWallPapersScreen> createState() => _AllWallPapersScreenState();
}

class _AllWallPapersScreenState extends State<AllWallPapersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorPrimary,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.colorPrimary,
        titleSpacing: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
            "wallpaper".tr,
          style: TextStyle(
            color: Colors.white,
            fontSize: 22.sp,
          ),
        ),
      ),
      body: Consumer<WallPaperProvider>(
        builder: (context, provider, child){
          return GridView.builder(
            padding: EdgeInsets.all(16.w),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Number of items horizontally
              crossAxisSpacing: 12.0, // Spacing between items horizontally
              mainAxisSpacing: 12.0, // Spacing between items vertically
              childAspectRatio: 0.8,
            ),
            itemCount: provider.allWallpapers!.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SetWallPaper(index: index,)));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.colorPrimaryLight,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                        image: NetworkImage(
                            provider.allWallpapers![index].thumbnailUrl,
                        ),
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            },
          );
        },
      )
    );
  }
}
