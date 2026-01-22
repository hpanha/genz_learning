class VideoCategory {
  final int id;
  final String name;

  VideoCategory({
    required this.id,
    required this.name,
  });

  factory VideoCategory.fromJson(Map<String, dynamic> json) {
    return VideoCategory(
      id: json['id'],
      name: json['name'],
    );
  }
}
