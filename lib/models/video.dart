class Video {
  final int id;
  final String title;
  final String youtubeId;
  final int categoryId;
  final int subCategoryId;
  final String categoryName;
  final String subCategoryName;

  Video({
    required this.id,
    required this.title,
    required this.youtubeId,
    required this.categoryId,
    required this.subCategoryId,
    required this.categoryName,
    required this.subCategoryName,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json['id'],
      title: json['title'],
      youtubeId: json['youtube_id'],
      categoryId: json['vd_category_id'],
      subCategoryId: json['sub_cat_id'],
      categoryName: json['category']['name'],
      subCategoryName: json['sub_category']['sub_name'],
    );
  }

  String get thumbnail =>
      'https://img.youtube.com/vi/$youtubeId/hqdefault.jpg';
}
