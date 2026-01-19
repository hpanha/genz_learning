class CourseItem {
  final int id;
  final String titleKh;
  final String? imgUrl;        
  final String? description; 
  final String type;

  CourseItem({
    required this.id,
    required this.titleKh,
    this.imgUrl,
    this.description,
    required this.type,
  });

  factory CourseItem.fromJson(Map<String, dynamic> json) {
    return CourseItem(
      id: json['id'],
      titleKh: json['item_title_kh'],
      imgUrl: json['img_url'],
      description: json['item_description'],
      type: json['type'],
    );
  }
}
