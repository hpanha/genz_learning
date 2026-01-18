class Course {
  final int id;
  final String titleKh;
  final String slug;
  final String shortDesc;
  final String imgUrl;
  final String categoryName;

  Course({
    required this.id,
    required this.titleKh,
    required this.slug,
    required this.shortDesc,
    required this.imgUrl,
    required this.categoryName,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      titleKh: json['title_kh'],
      slug: json['slug'],
      shortDesc: json['short_desc'],
      imgUrl: json['img_url'],
      categoryName: json['category']['name'],
    );
  }
}
