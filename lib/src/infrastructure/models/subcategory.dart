import 'dart:convert';

class LocalSubCategory {
  int subCatId;
  String subCategoryname;
  int catId;
  LocalSubCategory({
    this.subCatId,
    this.subCategoryname,
    this.catId,
  });

  LocalSubCategory copyWith({
    int subCatId,
    String subCategoryname,
    int catId,
  }) {
    return LocalSubCategory(
      subCatId: subCatId ?? this.subCatId,
      subCategoryname: subCategoryname ?? this.subCategoryname,
      catId: catId ?? this.catId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'subCatId': subCatId,
      'subCategoryname': subCategoryname,
      'catId': catId,
    };
  }

  factory LocalSubCategory.fromMap(Map<String, dynamic> map) {
    return LocalSubCategory(
      subCatId: map['subCatId'],
      subCategoryname: map['subCategoryname'],
      catId: map['catId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LocalSubCategory.fromJson(String source) =>
      LocalSubCategory.fromMap(json.decode(source));

  @override
  String toString() =>
      'SubCategory(subCatId: $subCatId, subCategoryname: $subCategoryname, catId: $catId)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LocalSubCategory &&
        other.subCatId == subCatId &&
        other.subCategoryname == subCategoryname &&
        other.catId == catId;
  }

  @override
  int get hashCode =>
      subCatId.hashCode ^ subCategoryname.hashCode ^ catId.hashCode;
}
