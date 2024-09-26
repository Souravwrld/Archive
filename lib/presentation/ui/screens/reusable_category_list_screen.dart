import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:JazakAllah/application/utility/colors.dart';
import 'package:JazakAllah/data/models/category_list_model.dart';
import 'package:JazakAllah/presentation/state_holders/category_list_controller.dart';
import 'package:JazakAllah/presentation/state_holders/check_language_controller.dart';
import 'package:JazakAllah/presentation/ui/screens/reusable_category_data_details_screen.dart';
import 'package:JazakAllah/presentation/ui/screens/surah_data_details_screen.dart';
import 'package:JazakAllah/presentation/ui/utility/assets_path.dart';
import 'package:JazakAllah/presentation/ui/widgets/category_item_card.dart';
import 'package:JazakAllah/presentation/ui/widgets/loading_popup.dart';
import 'package:JazakAllah/presentation/ui/widgets/reusable_background_image.dart';
import 'package:JazakAllah/presentation/ui/widgets/reusable_custom_appbar.dart';

class ReusableCategoryListScreen extends StatefulWidget {
  const ReusableCategoryListScreen(
      {super.key,
      required this.categoryTitle,
      required this.iconPath,
      required this.categoryName,
      required this.cateSign});

  final String categoryTitle, iconPath, categoryName, cateSign;

  @override
  State<ReusableCategoryListScreen> createState() =>
      _ReusableCategoryListScreenState();
}

class _ReusableCategoryListScreenState
    extends State<ReusableCategoryListScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      widget.cateSign == 'AL-QURAN'
          ? await Get.find<CategoryListController>()
              .getCategoryList(widget.cateSign)
          : await Get.find<CategoryListController>()
              .getCategoryList(widget.categoryName);
      await LanguageCheckingController.getLanguage();
    });
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ReusableBackgroundImage(
            bgImagePath: AssetsPath.secondaryBGSVG,
          ),
          ReusableCustomAppbar(
            screenTitle: widget.categoryTitle,
          ),
          GetBuilder<CategoryListController>(builder: (categoryListController) {
            if (categoryListController.categoryDataFetchInProgress) {
              return const LoadingPopup();
            }
            if (categoryListController.categoryList.isEmpty &&
                (categoryListController.surahListModel.data?.isEmpty ?? true)) {
              return Center(
                child: Text(
                  '${widget.categoryTitle.tr} is empty!',
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
              );
            }
            final List<CategoryListModel> categoryListData =
                categoryListController.categoryList;
            return Padding(
              padding: const EdgeInsets.only(
                  top: 97, left: 16, right: 16, bottom: 16),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: ShapeDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment(0.00, -1.00),
                    end: Alignment(0, 1),
                    colors: [
                      AppColors.colorGradient2Start,
                      AppColors.colorGradient2End
                    ],
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(top: 0),
                  itemCount: widget.cateSign == 'AL-QURAN'
                      ? categoryListController.surahListModel.data?.length ?? 0
                      : categoryListData.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () async {
                        widget.cateSign == 'AL-QURAN'
                            ? Get.to(() => SurahDataDetailsScreen(
                                  surahName:
                                      LanguageCheckingController.setLang == 'ar'
                                          ? categoryListController
                                          .surahListModel
                                          .data![index]
                                          .name!
                                          .short!
                                          : categoryListController
                                          .surahListModel
                                          .data![index]
                                          .name!
                                          .transliteration!
                                          .en!,
                                  surahNumber: index + 1,
                                ))
                            : Get.to(
                                () => ReusableCategoryDataDetailsScreen(
                                  categoryName:
                                      LanguageCheckingController.setLang == 'en'
                                          ? categoryListData[index]
                                                  .categoryEnglish ??
                                              ''
                                          : LanguageCheckingController.setLang == 'tr'
                                          ? categoryListData[index]
                                          .categoryTurkish ??
                                          ''
                                          : LanguageCheckingController.setLang == 'ur'
                                          ? categoryListData[index]
                                          .categoryUrdu ??
                                          ''
                                          : categoryListData[index]
                                                  .categoryArabic ??
                                              '',
                                  cateSign: widget.cateSign, categoryNameEng: categoryListData[index]
                                    .categoryEnglish ??
                                    '', id: categoryListData[index].sId ?? '',
                                ),
                              );
                      },
                      child: CategoryItemCard(
                        iconImagePath: widget.iconPath,
                        title: widget.cateSign == 'AL-QURAN'
                            ? LanguageCheckingController.setLang == 'ar'
                                ? categoryListController.surahListModel.data![index].name!.short!
                                : categoryListController.surahListModel.data![index].name!.transliteration!.en!
                            : LanguageCheckingController.setLang == 'en'
                                ? categoryListData[index].categoryEnglish ?? ''
                                : LanguageCheckingController.setLang == 'tr'
                            ? categoryListData[index].categoryTurkish ?? ''
                            : LanguageCheckingController.setLang == 'ur'
                            ? categoryListData[index].categoryUrdu ?? ''
                            : categoryListData[index].categoryArabic ?? '',
                      ),
                    );
                  },
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
