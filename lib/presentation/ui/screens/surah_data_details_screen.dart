import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:JazakAllah/application/utility/colors.dart';
import 'package:JazakAllah/data/models/al_quran_surah/full_surah_details_model.dart';
import 'package:JazakAllah/presentation/state_holders/full_surah_details_controller.dart';
import 'package:JazakAllah/presentation/ui/utility/assets_path.dart';
import 'package:JazakAllah/presentation/ui/widgets/azkar_details_card.dart';
import 'package:JazakAllah/presentation/ui/widgets/loading_popup.dart';
import 'package:JazakAllah/presentation/ui/widgets/reusable_background_image.dart';
import 'package:JazakAllah/presentation/ui/widgets/reusable_custom_appbar.dart';
import 'package:JazakAllah/presentation/ui/widgets/surah_ayat_details_card.dart';

import '../widgets/surah_datails_card.dart';

class SurahDataDetailsScreen extends StatefulWidget {
  const SurahDataDetailsScreen({
    Key? key,
    required this.surahName,
    required this.surahNumber,
  }) : super(key: key);

  final String surahName;
  final int surahNumber;

  @override
  State<SurahDataDetailsScreen> createState() => _SurahDataDetailsScreenState();
}

class _SurahDataDetailsScreenState extends State<SurahDataDetailsScreen> {
  int selectedCardIndex = -1;
  final AudioPlayer _audioPlayer = AudioPlayer();
  int _currentIndex = 0;
  bool _isAudioPlaying = false;
  List<String> surahUrlsList = [];

  // Play audio method

  void _initAudioPlayer() {
    _audioPlayer.onPlayerComplete.listen((event) {
      setState(() {
        _isAudioPlaying = false;
        if (_currentIndex < surahUrlsList.length - 1) {
          _currentIndex++;
          _playAudio(surahUrlsList[_currentIndex]);
        }
      });
    });
  }

  // Audio play method
  Future<void> _playAudio(String url) async {
    await _audioPlayer.play(UrlSource(url));
    setState(() {
      _isAudioPlaying = true;
    });
  }

  // Audio pause method
  Future<void> _pauseAudio() async {
    await _audioPlayer.pause();
    setState(() {
      _isAudioPlaying = false;
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Get.find<FullSurahDetailsController>()
          .getFullSurahDetails(widget.surahNumber);
    });
    super.initState();
    // Play audio method
    _initAudioPlayer();
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
            screenTitle: widget.surahName,
          ),
          GetBuilder<FullSurahDetailsController>(
            builder: (fullSurahDetailsController) {
              if (fullSurahDetailsController.fullSurahFetchInProgress) {
                return const LoadingPopup();
              }
              final List<Verses> versesDataList =
                  fullSurahDetailsController.versesList!;
              surahUrlsList.clear();
              for (int i = 0; i < versesDataList.length; i++) {
                surahUrlsList.add(versesDataList[i].audio!.primary!);
              }
              return Padding(
                padding: const EdgeInsets.only(
                  top: 97,
                  left: 16,
                  right: 16,
                  bottom: 16,
                ),
                child: ListView.separated(
                  padding: const EdgeInsets.only(top: 0),
                  itemCount: versesDataList.length,
                  itemBuilder: (context, index) {
                    final verse = versesDataList[index];
                    if (index == 0) {
                      return SurahAyatDetailsCard(
                        arabic: verse.text?.arab ?? '',
                        english: verse.translation?.en ?? '',
                        surahName: widget.surahName,
                        onIconTap: () {
                          if (selectedCardIndex == -1) {
                            if (_isAudioPlaying) {
                              _pauseAudio();
                            } else {
                              _playAudio(surahUrlsList[_currentIndex]);
                            }
                          }
                        },
                        isAudioPlaying: _isAudioPlaying,
                      );
                    } else {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedCardIndex =
                                selectedCardIndex == index ? -1 : index;
                            _currentIndex = selectedCardIndex;
                            _pauseAudio();
                            if (selectedCardIndex == -1) {
                              _currentIndex = 0;
                            }
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: selectedCardIndex == index
                                  ? Colors.blue
                                  : Colors.transparent,
                              width: selectedCardIndex == index ? 2 : 0,
                            ),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: SurahDetailsCard(
                            surahEnglish: verse.translation?.en ?? '',
                            surahArabic: verse.text?.arab ?? '',
                          ),
                        ),
                      );
                    }
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      height: 8,
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: selectedCardIndex != -1
          ? FloatingActionButton(
        backgroundColor: AppColors.colorPrimary,
              onPressed: () {
                setState(() {
                  if (_isAudioPlaying) {
                    _pauseAudio();
                  } else {
                    _playAudio(surahUrlsList[_currentIndex]);
                  }
                });
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(
                _isAudioPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.white,
              ),
            )
          : null,
    );
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
