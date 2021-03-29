import 'dart:convert';

class LocalItem {
  int itemId;
  String name;
  int subCatId;
  LocalItem({
    this.itemId,
    this.name,
    this.subCatId,
  });

  LocalItem copyWith({
    int itemId,
    String name,
    int subCatId,
  }) {
    return LocalItem(
      itemId: itemId ?? this.itemId,
      name: name ?? this.name,
      subCatId: subCatId ?? this.subCatId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'itemId': itemId,
      'name': name,
      'subCatId': subCatId,
    };
  }

  factory LocalItem.fromMap(Map<String, dynamic> map) {
    return LocalItem(
      itemId: map['itemId'],
      name: map['name'],
      subCatId: map['subCatId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LocalItem.fromJson(String source) =>
      LocalItem.fromMap(json.decode(source));

  @override
  String toString() =>
      'Item(itemId: $itemId, name: $name, subCatId: $subCatId)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LocalItem &&
        other.itemId == itemId &&
        other.name == name &&
        other.subCatId == subCatId;
  }

  @override
  int get hashCode => itemId.hashCode ^ name.hashCode ^ subCatId.hashCode;
}
