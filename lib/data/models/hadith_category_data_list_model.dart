class HadithCategoryDataListModel {
  String? sId;
  String? narratedBy;
  String? referenceBook;
  String? categoryArabic;
  String? categoryEnglish;
  String? categoryTurkish;
  String? categoryUrdu;
  String? hadithArabic;
  String? hadithEnglish;
  String? hadithTurkish;
  String? hadithUrdu;
  String? timestamp;

  HadithCategoryDataListModel(
      {this.sId,
      this.narratedBy,
      this.referenceBook,
      this.categoryArabic,
      this.categoryEnglish,
      this.categoryTurkish,
      this.categoryUrdu,
      this.hadithArabic,
      this.hadithEnglish,
      this.hadithTurkish,
      this.hadithUrdu,
      this.timestamp});

  HadithCategoryDataListModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    narratedBy = json['narratedBy'];
    referenceBook = json['referenceBook'];
    categoryArabic = json['categoryArabic'];
    categoryEnglish = json['categoryEnglish'];
    categoryTurkish = json['categoryTurkish'];
    categoryUrdu = json['categoryUrdu'];
    hadithArabic = json['hadithArabic'];
    hadithEnglish = json['hadithEnglish'];
    hadithTurkish = json['hadithTurkish'];
    hadithUrdu = json['hadithUrdu'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['narratedBy'] = narratedBy;
    data['referenceBook'] = referenceBook;
    data['categoryArabic'] = categoryArabic;
    data['categoryEnglish'] = categoryEnglish;
    data['categoryTurkish'] = categoryTurkish;
    data['categoryUrdu'] = categoryUrdu;
    data['hadithArabic'] = hadithArabic;
    data['hadithEnglish'] = hadithEnglish;
    data['hadithTurkish'] = hadithTurkish;
    data['hadithUrdu'] = hadithUrdu;
    data['timestamp'] = timestamp;
    return data;
  }
}
