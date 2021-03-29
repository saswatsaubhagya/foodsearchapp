import 'dart:convert';

class LocalCategory {
  int catId;
  String name;
  String colorCode;
  String servingSize;
  LocalCategory({
    this.catId,
    this.name,
    this.colorCode,
    this.servingSize,
  });

  LocalCategory copyWith({
    int catId,
    String name,
    String colorCode,
    String servingSize,
  }) {
    return LocalCategory(
      catId: catId ?? this.catId,
      name: name ?? this.name,
      colorCode: colorCode ?? this.colorCode,
      servingSize: servingSize ?? this.servingSize,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'catId': catId,
      'name': name,
      'colorCode': colorCode,
      'servingSize': servingSize,
    };
  }

  factory LocalCategory.fromMap(Map<String, dynamic> map) {
    return LocalCategory(
      catId: map['catId'],
      name: map['name'],
      colorCode: map['colorCode'],
      servingSize: map['servingSize'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LocalCategory.fromJson(String source) =>
      LocalCategory.fromMap(json.decode(source));

  @override
  String toString() {
    return 'LocalCategory(catId: $catId, name: $name, colorCode: $colorCode, servingSize: $servingSize)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LocalCategory &&
        other.catId == catId &&
        other.name == name &&
        other.colorCode == colorCode &&
        other.servingSize == servingSize;
  }

  @override
  int get hashCode {
    return catId.hashCode ^
        name.hashCode ^
        colorCode.hashCode ^
        servingSize.hashCode;
  }
}
