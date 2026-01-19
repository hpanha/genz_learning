import 'category_model.dart';
import 'course_section_model.dart';

class CourseDetail {
  final int id;
  final String slug;
  final String? imgUrl; 
  final Category category;
  final List<CourseSection> sections;

  CourseDetail({
    required this.id,
    required this.slug,
    this.imgUrl,
    required this.category,
    required this.sections,
  });

  factory CourseDetail.fromJson(Map<String, dynamic> json) {
    return CourseDetail(
      id: json['id'],
      slug: json['slug'],
      imgUrl: json['img_url'],
      category: Category.fromJson(json['category']),
      sections: (json['course_sections'] as List)
          .map((e) => CourseSection.fromJson(e))
          .toList(),
    );
  }
}
