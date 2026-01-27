class SubCategory {
  final int id;
  final String name;
  final int categoryId;

  SubCategory({
    required this.id,
    required this.name,
    required this.categoryId,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      id: json['id'],
      name: json['sub_name'],
      categoryId: json['vd_category_id'],
    );
  }
}
