
import 'course_item_model.dart';

class CourseSection {
  final int id;
  final String titleKh;
  final List<CourseItem> items;

  CourseSection({
    required this.id,
    required this.titleKh,
    required this.items,
  });

  factory CourseSection.fromJson(Map<String, dynamic> json) {
    return CourseSection(
      id: json['id'],
      titleKh: json['section_title_kh'],
      items: (json['course_items'] as List)
          .map((e) => CourseItem.fromJson(e))
          .toList(),
    );
  }
}
