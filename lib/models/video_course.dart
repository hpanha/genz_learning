class VideoCourse {
  final int id;
  final String title;
  final String author;
  final String url;
  final String youtubeId;
  final int categoryId;
  final String categoryName;

  VideoCourse({
    required this.id,
    required this.title,
    required this.author,
    required this.url,
    required this.youtubeId,
    required this.categoryId,
    required this.categoryName,
  });

  factory VideoCourse.fromJson(Map<String, dynamic> json) {
    return VideoCourse(
      id: json['id'],
      title: json['title'],
      author: json['author'],
      url: json['url'],
      youtubeId: json['youtube_id'],
      categoryId: json['vd_category_id'],
      categoryName: json['category']['name'],
    );
  }

  String get thumbnail =>
      'https://img.youtube.com/vi/$youtubeId/hqdefault.jpg';
}
