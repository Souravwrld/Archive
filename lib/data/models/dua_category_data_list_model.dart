class DuaCategoryDataListModel {
  String? sId;
  String? duaArabic;
  String? duaEnglish;
  String? duaTurkish; // New field for Turkish translation
  String? duaUrdu;
  String? categoryArabic;
  String? categoryEnglish;
  String? categoryTurkish; // New field for Turkish translation
  String? categoryUrdu;
  String? titleArabic;
  String? titleEnglish;
  String? titleTurkish; // New field for Turkish translation
  String? titleUrdu;
  String? timestamp;

  DuaCategoryDataListModel({
    this.sId,
    this.duaArabic,
    this.duaEnglish,
    this.duaTurkish,
    this.duaUrdu,
    this.categoryArabic,
    this.categoryEnglish,
    this.categoryTurkish,
    this.categoryUrdu,
    this.titleArabic,
    this.titleEnglish,
    this.titleTurkish,
    this.titleUrdu,
    this.timestamp,
  });

  DuaCategoryDataListModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    duaArabic = json['duaArabic'];
    duaEnglish = json['duaEnglish'];
    duaTurkish = json['duaTurkish'];
    duaUrdu = json['duaUrdu'];
    categoryArabic = json['categoryArabic'];
    categoryEnglish = json['categoryEnglish'];
    categoryTurkish = json['categoryTurkish'];
    categoryUrdu = json['categoryUrdu'];
    titleArabic = json['titleArabic'];
    titleEnglish = json['titleEnglish'];
    titleTurkish = json['titleTurkish'];
    titleUrdu = json['titleUrdu'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['duaArabic'] = duaArabic;
    data['duaEnglish'] = duaEnglish;
    data['duaTurkish'] = duaTurkish;
    data['duaUrdu'] = duaUrdu;
    data['categoryArabic'] = categoryArabic;
    data['categoryEnglish'] = categoryEnglish;
    data['categoryTurkish'] = categoryTurkish;
    data['categoryUrdu'] = categoryUrdu;
    data['titleArabic'] = titleArabic;
    data['titleEnglish'] = titleEnglish;
    data['titleTurkish'] = titleTurkish;
    data['titleUrdu'] = titleUrdu;
    data['timestamp'] = timestamp;
    return data;
  }
}
