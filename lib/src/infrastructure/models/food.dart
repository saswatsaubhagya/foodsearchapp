class FoodModel {
  FoodModel({
    this.categories,
  });

  List<CategoryElement> categories;

  factory FoodModel.fromJson(Map<String, dynamic> json) => FoodModel(
        categories: List<CategoryElement>.from(
            json["categories"].map((x) => CategoryElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
      };
}

class CategoryElement {
  CategoryElement({
    this.category,
  });

  CategoryCategory category;

  factory CategoryElement.fromJson(Map<String, dynamic> json) =>
      CategoryElement(
        category: CategoryCategory.fromJson(json["category"]),
      );

  Map<String, dynamic> toJson() => {
        "category": category.toJson(),
      };
}

class CategoryCategory {
  CategoryCategory({
    this.subcategories,
    this.categoryName,
    this.colorCode,
    this.servingSize,
  });

  List<Subcategory> subcategories;
  String categoryName;
  String colorCode;
  String servingSize;

  factory CategoryCategory.fromJson(Map<String, dynamic> json) =>
      CategoryCategory(
        subcategories: List<Subcategory>.from(
            json["subcategories"].map((x) => Subcategory.fromJson(x))),
        categoryName: json["categoryName"] ?? "",
        colorCode: json["colorCode"] ?? "",
        servingSize: json["servingSize"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "subcategories":
            List<dynamic>.from(subcategories.map((x) => x.toJson())),
        "categoryName": categoryName ?? "",
        "colorCode": colorCode ?? "",
        "servingSize": servingSize ?? "",
      };
}

class Subcategory {
  Subcategory({
    this.items,
    this.subCategoryname,
    this.servingSize = "",
  });

  List<String> items;
  String subCategoryname;
  String servingSize;

  factory Subcategory.fromJson(Map<String, dynamic> json) => Subcategory(
        items: List<String>.from(json["items"].map((x) => x)),
        subCategoryname: json["subCategoryname"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items.map((x) => x)),
        "subCategoryname": subCategoryname,
      };
}
