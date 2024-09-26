class CategoryListModel {
  String? sId;
  String? categoryArabic;
  String? categoryEnglish;
  String? categoryTurkish;
  String? categoryUrdu;
  String? timestamp;

  CategoryListModel(
      {this.sId, this.categoryArabic, this.categoryEnglish, this.categoryTurkish, this.categoryUrdu, this.timestamp});

  CategoryListModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    categoryArabic = json['categoryArabic'];
    categoryEnglish = json['categoryEnglish'];
    categoryTurkish = json['categoryTurkish'];
    categoryUrdu = json['categoryUrdu'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['categoryArabic'] = categoryArabic;
    data['categoryEnglish'] = categoryEnglish;
    data['categoryTurkish'] = categoryTurkish;
    data['categoryUrdu'] = categoryUrdu;
    data['timestamp'] = timestamp;
    return data;
  }
}
