import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:JazakAllah/data/models/azkar_category_data_list_model.dart';
import 'package:JazakAllah/data/models/dua_category_data_list_model.dart';
import 'package:JazakAllah/data/models/event_prayer_category_data_list_model.dart';
import 'package:JazakAllah/data/models/hadith_category_data_list_model.dart';
import 'package:JazakAllah/presentation/state_holders/azkar_category_data_list_controller.dart';
import 'package:JazakAllah/presentation/state_holders/dua_category_data_list_controller.dart';
import 'package:JazakAllah/presentation/state_holders/event_prayer_category_data_list_controller.dart';
import 'package:JazakAllah/presentation/state_holders/hadith_category_data_list_controller.dart';
import 'package:JazakAllah/presentation/ui/utility/assets_path.dart';
import 'package:JazakAllah/presentation/ui/widgets/azkar_details_card.dart';
import 'package:JazakAllah/presentation/ui/widgets/category_data_details_card.dart';
import 'package:JazakAllah/presentation/ui/widgets/loading_popup.dart';
import 'package:JazakAllah/presentation/ui/widgets/reusable_background_image.dart';
import 'package:JazakAllah/presentation/ui/widgets/reusable_custom_appbar.dart';

class ReusableCategoryDataDetailsScreen extends StatefulWidget {
  const ReusableCategoryDataDetailsScreen({
    Key? key,
    required this.id,
    required this.categoryName,
    required this.cateSign,
    required this.categoryNameEng,
  }) : super(key: key);

  final String categoryName;
  final String categoryNameEng;
  final String cateSign;
  final String id;

  @override
  State<ReusableCategoryDataDetailsScreen> createState() =>
      _ReusableCategoryDataDetailsScreenState();
}

class _ReusableCategoryDataDetailsScreenState
    extends State<ReusableCategoryDataDetailsScreen> {
  List<HadithCategoryDataListModel> hadithCategoryDataList = [];
  List<DuaCategoryDataListModel> duaCategoryDataList = [];
  List<AzkarCategoryDataListModel> azkarCategoryDataList = [];
  List<EventPrayerCategoryDataListModel> eventPrayersCategoryDataList = [];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      // Loading indicator method
      showLoadingDialog(context);
      await callAPIController();

      Get.back();
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, Widget Function(int)> cardBuilders = {
      'HADITH': buildHadithCard,
      'DUA': buildDuaCard,
      'AZKAR': buildAzkarCard,
      'EVENT-PRAYERS': buildEventPrayersCard,
    };

    final List? dataList = getDataList();

    return Scaffold(
      body: Stack(
        children: [
          ReusableBackgroundImage(
            bgImagePath: AssetsPath.secondaryBGSVG,
          ),
          ReusableCustomAppbar(
            screenTitle: widget.categoryName,
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 97, left: 16, right: 16, bottom: 16),
            child: ListView.separated(
              padding: const EdgeInsets.only(top: 0),
              itemCount: dataList?.length ?? 0,
              itemBuilder: (context, index) {
                final builder = cardBuilders[widget.cateSign];
                if (builder != null) {
                  return builder(index);
                }
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  height: 8,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  List? getDataList() {
    switch (widget.cateSign) {
      case 'HADITH':
        return hadithCategoryDataList;
      case 'DUA':
        return duaCategoryDataList;
      case 'AZKAR':
        return azkarCategoryDataList;
      case 'EVENT-PRAYERS':
        return eventPrayersCategoryDataList;
      default:
        return null;
    }
  }

  Widget buildHadithCard(int index) {
    final data = hadithCategoryDataList[index];
    return CategoryDataDetailsCard(
      amolEnglish: data.hadithEnglish ?? '',
      amolArabic: data.hadithArabic ?? '',
      authorName: data.narratedBy ?? '',
      title: data.referenceBook ?? '',
      amolTurkish: data.hadithTurkish ?? '',
      amolUrdu: data.hadithUrdu ?? '',
    );
  }

  Widget buildDuaCard(int index) {
    final data = duaCategoryDataList[index];
    return CategoryDataDetailsCard(
      amolEnglish: data.duaEnglish ?? '',
      amolArabic: data.duaArabic ?? '',
      title: data.titleEnglish ?? '',
      amolTurkish: data.duaTurkish ?? '',
      amolUrdu: data.duaArabic ?? '',
    );
  }

  Widget buildAzkarCard(int index) {
    final data = azkarCategoryDataList[index];
    return AzkarDetailsCard(
      azkarEnglish: data.azkarEnglish ?? '',
      azkarArabic: data.azkarArabic ?? '',
      azkarTurkish: data.azkarTurkish ?? '',
      azkarUrdu: data.azkarUrdu ?? '',
    );
  }

  Widget buildEventPrayersCard(int index) {
    final data = eventPrayersCategoryDataList[index];
    return AzkarDetailsCard(
      azkarEnglish: data.eventPrayerEnglish ?? '',
      azkarArabic: data.eventPrayerArabic ?? '',
      azkarTurkish: '',
      azkarUrdu: '',
    );
  }

  Future<void> callAPIController() async {
    switch (widget.cateSign) {
      case 'HADITH':
        await fetchHadithData();
        break;
      case 'DUA':
        await fetchDuaData();
        break;
      case 'AZKAR':
        await fetchAzkarData();
        break;
      case 'EVENT-PRAYERS':
        await fetchEventPrayersData();
        break;
      default:
        break;
    }
  }

  Future<void> fetchHadithData() async {
    await Get.find<HadithCategoryDataListController>()
        .getHadithCategoryData(widget.id);
    hadithCategoryDataList =
        Get.find<HadithCategoryDataListController>().hadithCategoryDataList;
  }

  Future<void> fetchDuaData() async {
    await Get.find<DuaCategoryDataListController>()
        .getDuaCategoryData(widget.id);
    duaCategoryDataList =
        Get.find<DuaCategoryDataListController>().duaCategoryDataList;
  }

  Future<void> fetchAzkarData() async {
    await Get.find<AzkarCategoryDataListController>()
        .getAzkarCategoryData(widget.id);
    azkarCategoryDataList =
        Get.find<AzkarCategoryDataListController>().azkarCategoryDataList;
  }

  Future<void> fetchEventPrayersData() async {
    await Get.find<EventPrayerCategoryDataListController>()
        .getEventPrayerCategoryData(widget.id);
    eventPrayersCategoryDataList =
        Get.find<EventPrayerCategoryDataListController>()
            .eventPrayerCategoryDataList;
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
