class Merchant {
  Merchant(
    this.id,
    this.name,
    this.categoryName,
    this.hasPhysicalStores,
  );

  final String id;
  final String name;
  final String categoryName;
  final bool hasPhysicalStores;

  Merchant fromJson(Map<String, dynamic> json) => Merchant(
        json['id'] as String,
        json['name'] as String,
        json['categoryName'] as String,
        json['hasPhysicalStores'] as bool? ?? false,
      );

  Map<String, dynamic> toJson(Merchant instance) => <String, dynamic>{
        'id': instance.id,
        'name': instance.name,
        'categoryName': instance.categoryName,
        'hasPhysicalStores': instance.hasPhysicalStores,
      };
}
