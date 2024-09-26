class AzkarCategoryDataListModel {
  int? id;
  String? sId;
  String? azkarEnglish;
  String? azkarArabic;
  String? azkarTurkish;
  String? azkarUrdu;
  String? categoryId;
  String? timestamp;
  String? createdAt;
  String? updatedAt;
  String? categoryArabic;
  String? categoryEnglish;
  String? categoryTurkish;
  String? categoryUrdu;

  AzkarCategoryDataListModel({
    this.id,
    this.sId,
    this.azkarEnglish,
    this.azkarArabic,
    this.azkarTurkish,
    this.azkarUrdu,
    this.categoryId,
    this.timestamp,
    this.createdAt,
    this.updatedAt,
    this.categoryArabic,
    this.categoryEnglish,
    this.categoryTurkish,
    this.categoryUrdu,
  });

  AzkarCategoryDataListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sId = json['_id'];
    azkarEnglish = json['azkarEnglish'];
    azkarArabic = json['azkarArabic'];
    azkarTurkish = json['azkarTurkish'];
    azkarUrdu = json['azkarUrdu'];
    categoryId = json['category_id'];
    timestamp = json['timestamp'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    categoryArabic = json['categoryArabic'];
    categoryEnglish = json['categoryEnglish'];
    categoryTurkish = json['categoryTurkish'];
    categoryUrdu = json['categoryUrdu'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['_id'] = sId;
    data['azkarEnglish'] = azkarEnglish;
    data['azkarArabic'] = azkarArabic;
    data['azkarTurkish'] = azkarTurkish;
    data['azkarUrdu'] = azkarUrdu;
    data['category_id'] = categoryId;
    data['timestamp'] = timestamp;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['categoryArabic'] = categoryArabic;
    data['categoryEnglish'] = categoryEnglish;
    data['categoryTurkish'] = categoryTurkish;
    data['categoryUrdu'] = categoryUrdu;
    return data;
  }
}
